import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

/// A GGUF model the app can download for on-device AI. Pinned to an exact
/// upstream revision and checksum so a changed or tampered file is rejected.
class OnDeviceModelSpec {
  const OnDeviceModelSpec({
    required this.id,
    required this.displayName,
    required this.fileName,
    required this.url,
    required this.sha256,
    required this.sizeBytes,
    required this.license,
  });

  final String id;
  final String displayName;
  final String fileName;
  final Uri url;
  final String sha256;
  final int sizeBytes;
  final String license;
}

/// Qwen3 1.7B, Q4_K_M quantization (Apache-2.0), from unsloth/Qwen3-1.7B-GGUF.
final defaultOnDeviceModel = OnDeviceModelSpec(
  id: 'qwen3-1.7b-q4_k_m.gguf',
  displayName: 'Qwen3 1.7B (Q4_K_M)',
  fileName: 'Qwen3-1.7B-Q4_K_M.gguf',
  url: Uri.parse('https://huggingface.co/unsloth/Qwen3-1.7B-GGUF/resolve/'
      'd7f544eead698dbd1f15126ef60b45a1e1933222/Qwen3-1.7B-Q4_K_M.gguf'),
  sha256: 'b139949c5bd74937ad8ed8c8cf3d9ffb1e99c866c823204dc42c0d91fa181897',
  sizeBytes: 1107409472,
  license: 'Apache-2.0',
);

enum ModelFileState { missing, partial, ready }

class ModelDownloadProgress {
  const ModelDownloadProgress(this.receivedBytes, this.totalBytes, {this.verifying = false});
  final int receivedBytes;
  final int totalBytes;
  final bool verifying;

  double get fraction => totalBytes == 0 ? 0 : receivedBytes / totalBytes;
}

enum ModelStoreError { network, checksum, cancelled, diskFull }

class ModelStoreException implements Exception {
  ModelStoreException(this.error, [this.detail]);
  final ModelStoreError error;
  final String? detail;

  @override
  String toString() => 'ModelStoreException(${error.name}${detail == null ? '' : ': $detail'})';
}

/// Cooperative cancellation for [ModelStore.download].
class ModelDownloadCancel {
  bool _cancelled = false;
  bool get isCancelled => _cancelled;
  void cancel() => _cancelled = true;
}

/// Downloads, verifies and deletes on-device model files under
/// `<app support>/models/`. A file counts as ready only after its SHA-256 has
/// matched once; the verified hash is remembered in a `.verified` marker so
/// the 1 GB file is not re-hashed on every launch.
class ModelStore {
  ModelStore(this.directory, {http.Client Function()? client}) : _client = client ?? http.Client.new;

  final Directory directory;
  final http.Client Function() _client;

  File modelFile(OnDeviceModelSpec m) => File(p.join(directory.path, m.fileName));
  File _partFile(OnDeviceModelSpec m) => File('${modelFile(m).path}.part');
  File _marker(OnDeviceModelSpec m) => File('${modelFile(m).path}.verified');

  Future<ModelFileState> state(OnDeviceModelSpec m) async {
    final f = modelFile(m);
    if (await f.exists() &&
        await f.length() == m.sizeBytes &&
        await _marker(m).exists() &&
        (await _marker(m).readAsString()).trim() == m.sha256) {
      return ModelFileState.ready;
    }
    if (await _partFile(m).exists()) return ModelFileState.partial;
    return ModelFileState.missing;
  }

  /// Downloads [m], resuming a previous partial download, then verifies the
  /// checksum. Emits progress; completes when the file is ready.
  Stream<ModelDownloadProgress> download(OnDeviceModelSpec m, {ModelDownloadCancel? cancel}) async* {
    if (await state(m) == ModelFileState.ready) {
      yield ModelDownloadProgress(m.sizeBytes, m.sizeBytes);
      return;
    }
    await directory.create(recursive: true);
    final part = _partFile(m);
    var received = await part.exists() ? await part.length() : 0;
    if (received > m.sizeBytes) {
      await part.delete();
      received = 0;
    }

    if (received < m.sizeBytes) {
      final client = _client();
      IOSink? sink;
      try {
        final req = http.Request('GET', m.url);
        if (received > 0) req.headers['Range'] = 'bytes=$received-';
        final res = await client.send(req);
        if (res.statusCode == 200 && received > 0) {
          // Server ignored the range: start over.
          received = 0;
        } else if (res.statusCode != 200 && res.statusCode != 206) {
          throw ModelStoreException(ModelStoreError.network, 'HTTP ${res.statusCode}');
        }
        sink = part.openWrite(mode: received == 0 ? FileMode.write : FileMode.append);
        var lastEmit = DateTime.fromMillisecondsSinceEpoch(0);
        await for (final chunk in res.stream) {
          if (cancel?.isCancelled ?? false) throw ModelStoreException(ModelStoreError.cancelled);
          sink.add(chunk);
          received += chunk.length;
          final now = DateTime.now();
          if (now.difference(lastEmit) > const Duration(milliseconds: 250)) {
            lastEmit = now;
            yield ModelDownloadProgress(received, m.sizeBytes);
          }
        }
        await sink.flush();
      } on ModelStoreException {
        rethrow;
      } on FileSystemException catch (e) {
        throw ModelStoreException(ModelStoreError.diskFull, e.message);
      } on Exception catch (e) {
        throw ModelStoreException(ModelStoreError.network, '$e');
      } finally {
        await sink?.close();
        client.close();
      }
    }

    yield ModelDownloadProgress(received, m.sizeBytes, verifying: true);
    final digest = await sha256.bind(part.openRead()).first;
    if (digest.toString() != m.sha256 || await part.length() != m.sizeBytes) {
      await part.delete();
      throw ModelStoreException(ModelStoreError.checksum);
    }
    await part.rename(modelFile(m).path);
    await _marker(m).writeAsString(m.sha256);
    yield ModelDownloadProgress(m.sizeBytes, m.sizeBytes);
  }

  Future<void> delete(OnDeviceModelSpec m) async {
    for (final f in [modelFile(m), _partFile(m), _marker(m)]) {
      if (await f.exists()) await f.delete();
    }
  }
}

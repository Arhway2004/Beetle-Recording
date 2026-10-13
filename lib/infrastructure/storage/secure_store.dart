import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Credential storage (iOS Keychain / Android Keystore-backed encryption).
/// Secrets are never written to SQLite or included in backups.
abstract class SecretStore {
  Future<String?> read(String key);
  Future<void> write(String key, String? value);
}

class SecretKeys {
  static const gatewayToken = 'mac_gateway_token';
}

class PlatformSecretStore implements SecretStore {
  PlatformSecretStore()
      : _storage = const FlutterSecureStorage(
          iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
        );

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String? value) =>
      value == null || value.isEmpty ? _storage.delete(key: key) : _storage.write(key: key, value: value);
}

/// In-memory store for tests and previews.
class MemorySecretStore implements SecretStore {
  final Map<String, String> _values = {};

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String? value) async =>
      value == null ? _values.remove(key) : _values[key] = value;
}

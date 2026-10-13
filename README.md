# apps/mobile — Beetle Keeper (Flutter)

Offline-first Android/iOS app. Simplified Chinese by default; English and Thai included.

## Setup
```bash
flutter pub get
dart run build_runner build   # Drift code (lib/**/*.g.dart, committed)
flutter gen-l10n              # lib/l10n/gen (committed)
flutter run
```
Requires Flutter 3.29.0 / Dart 3.7. Version pins chosen for this toolchain (revisit when upgrading Flutter):
`fl_chart` 1.0.0 (1.1.x needs a newer `vector_math`), `flutter_timezone` ^4.1 (5.x needs a newer Kotlin
plugin setup), `flutter_secure_storage` ^9.2 (10.x needs compileSdk 36). Android uses NDK 27 and the
Kotlin Gradle plugin 2.1.0.

If `flutter build` fails with `IconTreeShakerException: ConstFinder failure`, the local Flutter
engine cache is incomplete: run `flutter precache --force` (or build with `--no-tree-shake-icons`).

## Commands
| | |
|---|---|
| Analyze | `flutter analyze` |
| Tests | `flutter test` (unit, repository, Drift schema, backup, gateway client, widget) |
| Integration test (device/simulator) | `flutter test integration_test` |
| Android APK | `flutter build apk --release` |
| iOS | `flutter build ios --release --no-codesign`, then sign/archive in Xcode |
| Schema change | bump `schemaVersion`, add an `onUpgrade` step, run `dart run drift_dev make-migrations` |

## Android release signing
Create `android/key.properties` (git-ignored):
```
storeFile=/absolute/path/upload-keystore.jks
storePassword=…
keyAlias=upload
keyPassword=…
```
Without it the release build is signed with the debug key — fine for sideloading tests, not for distribution.

## iOS
Deployment target 13.0. Set your Team in Xcode (Runner → Signing & Capabilities) to install on an
iPhone. Info.plist declares camera, photo library and local-network usage strings.

## Structure
See [docs/architecture/overview.md](../../docs/architecture/overview.md). Key entry points:
`lib/main.dart` (bootstrap), `lib/app.dart`, `lib/core/router/app_router.dart`,
`lib/data/database/tables.dart`, `lib/domain/proactive/care_rules.dart`, `lib/domain/ai/`.

## Connecting the Mac AI
Settings → Mac AI gateway: URL (`https://<mac>.local:8443` or a Tailscale address), token
(`make gateway-token`), certificate fingerprint (`make gateway-cert`). The token is stored in the
Keychain/Keystore. On first use the app asks for consent to send data to that address.

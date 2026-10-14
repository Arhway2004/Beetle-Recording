import 'package:beetle_keeper/application/providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Locale localeFor(Map<String, String> settings) {
    final c = ProviderContainer(overrides: [initialSettingsProvider.overrideWithValue(settings)]);
    addTearDown(c.dispose);
    return c.read(localeProvider);
  }

  test('explicit choices are kept; nothing chosen stays Simplified Chinese', () {
    expect(localeFor({'ui.locale': 'th'}), const Locale('th'));
    expect(localeFor({'ui.locale': 'en'}), const Locale('en'));
    expect(localeFor({}), const Locale('zh'));
    expect(localeFor({'ui.locale': 'fr'}), const Locale('zh')); // unknown stored value
  });

  test('device language: supported languages are used, others fall back to Chinese', () {
    expect(resolveSupportedLocale(const Locale('th', 'TH')), const Locale('th'));
    expect(resolveSupportedLocale(const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant')), const Locale('zh'));
    expect(resolveSupportedLocale(const Locale('en', 'GB')), const Locale('en'));
    expect(resolveSupportedLocale(const Locale('ja')), const Locale('zh'));
    expect(resolveSupportedLocale(null), const Locale('zh'));
  });

  testWidgets('"system" follows the device language', (tester) async {
    tester.platformDispatcher.localeTestValue = const Locale('th', 'TH');
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
    expect(localeFor({'ui.locale': systemLanguage}), const Locale('th'));
  });
}

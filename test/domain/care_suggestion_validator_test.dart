import 'dart:convert';

import 'package:beetle_keeper/domain/ai/care_suggestion.dart';
import 'package:beetle_keeper/domain/models/enums.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.dart';

void main() {
  const validator = CareSuggestionValidator();

  group('shared contract fixtures', () {
    for (final f in contractFixtures('suggestions/valid')) {
      test('accepts ${f.uri.pathSegments.last}', () {
        final r = validator.validate(jsonDecode(f.readAsStringSync()));
        expect(r.errors, isEmpty);
        expect(r.isValid, isTrue);
        expect(r.value!.requiresUserConfirmation, isTrue);
      });
    }
    for (final f in contractFixtures('suggestions/invalid')) {
      test('rejects ${f.uri.pathSegments.last}', () {
        final r = validator.validate(jsonDecode(f.readAsStringSync()));
        expect(r.isValid, isFalse);
        expect(r.errors, isNotEmpty);
      });
    }
  });

  test('parses example into typed suggestion', () {
    final r = validator.validate(contractFixture('suggestions/valid/possible-prepupa.json'));
    final s = r.value!;
    expect(s.beetleCode, 'CCK-001');
    expect(s.eventType, CareEventType.possiblePrepupa);
    expect(s.confidence, Confidence.low);
    expect(s.reminder!.delayDays, 3);
    // Round-trips through toJson.
    expect(validator.validate(s.toJson()).isValid, isTrue);
  });

  test('rejects non-object and the app-internal custom event type', () {
    expect(validator.validate('text').isValid, isFalse);
    final m = (contractFixture('suggestions/valid/possible-prepupa.json')! as Map).cast<String, Object?>();
    expect(validator.validate({...m, 'event_type': 'custom'}).isValid, isFalse);
  });

  test('batch keeps valid items and reports invalid ones', () {
    final ok = contractFixture('suggestions/valid/possible-prepupa.json');
    final bad = contractFixture('suggestions/invalid/no-confirmation.json');
    final r = validator.validateBatch({'schema_version': '1', 'suggestions': [ok, bad]});
    expect(r.valid, hasLength(1));
    expect(r.errors.single, startsWith('suggestions[1].'));
    expect(validator.validateBatch({'schema_version': '2', 'suggestions': [ok]}).valid, isEmpty);
    expect(validator.validateBatch({'schema_version': '1', 'suggestions': [ok], 'x': 1}).valid, isEmpty);
  });

  test('string length counts code points', () {
    final m = (contractFixture('suggestions/valid/possible-prepupa.json')! as Map).cast<String, Object?>();
    final reminder = (m['suggested_reminder']! as Map).cast<String, Object?>();
    // 80 emoji = 80 code points but 160 UTF-16 units: still valid.
    final title = List.filled(80, '🪲').join();
    expect(validator.validate({...m, 'suggested_reminder': {...reminder, 'title': title}}).isValid, isTrue);
  });
}

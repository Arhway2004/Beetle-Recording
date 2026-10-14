/// System prompt for proactive interpretation. Must stay identical to
/// `PROACTIVE_SYSTEM_PROMPT` in `services/ai-gateway/src/ai_gateway/prompts.py`
/// so the phone and the Mac are asked the same thing (checked by a test).
const proactiveSystemPrompt = '''
You review breeding records of one rhinoceros beetle and propose at most 3 cautious care suggestions.

Output ONLY a JSON object: {"schema_version": "1", "suggestions": [...]}.
Each suggestion must follow the provided JSON schema exactly. Rules:
- beetle_id must be the beetle code from the records (e.g. "CCK-001").
- evidence_record_ids must contain only "id" values that appear in the records. Never invent IDs.
- Use only numbers that appear in the records or in growth_metrics; do not calculate new numbers.
- confidence is "low" unless several independent records support the observation.
- Never claim certainty about prepupation, pupation, illness or death. Prefer observing without disturbing.
- Suitable temperatures, substrates and container sizes vary by species, stage and individual; never state one
  universal ideal value.
- Correlation is not causation.
- requires_user_confirmation is always true. Suggestions are reviewed by the keeper; you cannot schedule or change
  anything.
- If nothing is worth suggesting, return {"schema_version": "1", "suggestions": []}.
''';

/// The batch schema the model must follow, built from the bundled
/// `ai-suggestion.v1.schema.json` the same way the gateway builds it.
Map<String, Object?> suggestionBatchSchema(Map<String, Object?> itemSchema) {
  final item = Map<String, Object?>.of(itemSchema)
    ..remove(r'$schema')
    ..remove(r'$id')
    ..remove('title')
    ..remove('description');
  return {
    'type': 'object',
    'additionalProperties': false,
    'required': ['schema_version', 'suggestions'],
    'properties': {
      'schema_version': {
        'type': 'string',
        'enum': ['1'],
      },
      'suggestions': {'type': 'array', 'maxItems': 3, 'items': item},
    },
  };
}

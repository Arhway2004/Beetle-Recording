// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Beetle Keeper';

  @override
  String get navDashboard => 'Home';

  @override
  String get navBeetles => 'Beetles';

  @override
  String get navRecords => 'Records';

  @override
  String get navAssistant => 'Assistant';

  @override
  String get navReminders => 'Reminders';

  @override
  String get navAnalytics => 'Analytics';

  @override
  String get navSettings => 'Settings';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonClose => 'Close';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonAll => 'All';

  @override
  String get commonNone => 'None';

  @override
  String get commonOptional => 'Optional';

  @override
  String get commonRequired => 'Required';

  @override
  String get commonInvalidNumber => 'Enter a valid number';

  @override
  String get commonMustBePositive => 'Must be greater than 0';

  @override
  String get commonErrorTitle => 'Something went wrong';

  @override
  String get commonSaved => 'Saved';

  @override
  String get commonNotes => 'Notes';

  @override
  String get commonDateTime => 'Date & time';

  @override
  String get commonDeleteConfirmTitle => 'Delete?';

  @override
  String get commonDeleteRecordMessage => 'The record will be marked as deleted (kept for audit). The beetle\'s current values fall back to the previous record.';

  @override
  String get commonNotSet => 'Not set';

  @override
  String get sexMale => 'Male';

  @override
  String get sexFemale => 'Female';

  @override
  String get sexUnknown => 'Unknown';

  @override
  String get stageL1 => 'L1 larva';

  @override
  String get stageL2 => 'L2 larva';

  @override
  String get stageL3 => 'L3 larva';

  @override
  String get stagePrepupa => 'Prepupa';

  @override
  String get stagePupa => 'Pupa';

  @override
  String get stageAdult => 'Adult';

  @override
  String get stageUnset => 'Stage not recorded';

  @override
  String get l3Early => 'early';

  @override
  String get l3Middle => 'middle';

  @override
  String get l3Late => 'late';

  @override
  String get statusActive => 'Active';

  @override
  String get statusDeceased => 'Deceased';

  @override
  String get statusTransferred => 'Transferred';

  @override
  String get statusArchived => 'Archived';

  @override
  String get obsGeneral => 'General';

  @override
  String get obsColorChange => 'Color change';

  @override
  String get obsActivity => 'Activity';

  @override
  String get obsFeeding => 'Feeding';

  @override
  String get obsPupalChamber => 'Pupal chamber';

  @override
  String get obsMolt => 'Molt';

  @override
  String get obsHealth => 'Health';

  @override
  String get obsBehavior => 'Behavior';

  @override
  String get reminderStatusSuggested => 'Suggested';

  @override
  String get reminderStatusConfirmed => 'Confirmed';

  @override
  String get reminderStatusScheduled => 'Scheduled';

  @override
  String get reminderStatusCompleted => 'Completed';

  @override
  String get reminderStatusCancelled => 'Cancelled';

  @override
  String get reminderStatusExpired => 'Expired';

  @override
  String get severityInfo => 'Info';

  @override
  String get severityObservation => 'Observe';

  @override
  String get severityWarning => 'Warning';

  @override
  String get severityAlert => 'Alert';

  @override
  String confidenceLabel(String level) {
    return 'Confidence: $level';
  }

  @override
  String get confidenceLow => 'low';

  @override
  String get confidenceMedium => 'medium';

  @override
  String get confidenceHigh => 'high';

  @override
  String get basisMeasured => 'Measured';

  @override
  String get basisCalculated => 'Calculated';

  @override
  String get basisAiInference => 'AI inference';

  @override
  String get sourceUser => 'Created by you';

  @override
  String get sourceRule => 'Rule check';

  @override
  String get sourceAi => 'AI suggestion';

  @override
  String get recordWeight => 'Weight';

  @override
  String get recordObservation => 'Observation';

  @override
  String get recordSubstrate => 'Substrate';

  @override
  String get recordContainer => 'Container';

  @override
  String get recordLifeStage => 'Life stage';

  @override
  String get recordTemperature => 'Temperature';

  @override
  String get eventSignificantWeightChange => 'Significant weight change';

  @override
  String get eventWeightLoss => 'Weight loss';

  @override
  String get eventMeasurementOverdue => 'Measurement overdue';

  @override
  String get eventSubstrateInspection => 'Substrate check';

  @override
  String get eventContainerReview => 'Container review';

  @override
  String get eventTemperatureOutOfRange => 'Temperature out of range';

  @override
  String get eventPossiblePrepupa => 'Possible prepupa';

  @override
  String get eventPossiblePupation => 'Possible pupation';

  @override
  String get eventExpectedEmergenceWindow => 'Expected emergence window';

  @override
  String get eventOutdatedReminder => 'Outdated reminder';

  @override
  String get eventGeneralObservation => 'General observation';

  @override
  String get eventCustom => 'Custom';

  @override
  String get dashboardActiveBeetles => 'Active';

  @override
  String get dashboardPendingSuggestions => 'Pending suggestions';

  @override
  String get dashboardUpcoming => 'Upcoming reminders';

  @override
  String get dashboardRecent => 'Recent records';

  @override
  String get dashboardEmptyTitle => 'No beetles yet';

  @override
  String get dashboardEmptyBody => 'Add your first beetle to start tracking its growth.';

  @override
  String get dashboardAddBeetle => 'Add beetle';

  @override
  String get dashboardBySpecies => 'By species';

  @override
  String get dashboardByStage => 'By stage';

  @override
  String get dashboardNoUpcoming => 'No reminders';

  @override
  String dashboardTemperatureAlert(String celsius, String sensor) {
    return '$sensor: $celsius°C is outside your configured range';
  }

  @override
  String get dashboardReviewSuggestions => 'Review';

  @override
  String get beetlesSearchHint => 'Search code or notes';

  @override
  String get beetlesEmpty => 'No beetles match';

  @override
  String get filterSpecies => 'Species';

  @override
  String get filterSex => 'Sex';

  @override
  String get filterStage => 'Stage';

  @override
  String get filterStatus => 'Status';

  @override
  String get beetleFormNewTitle => 'New beetle';

  @override
  String get beetleFormEditTitle => 'Edit beetle';

  @override
  String get fieldCode => 'Code';

  @override
  String get fieldCodeHelper => 'e.g. DHH-001';

  @override
  String get fieldCodeInvalid => 'Use SPECIES-NUMBER, e.g. DHH-001';

  @override
  String fieldCodeDuplicate(String code) {
    return 'Code $code already exists';
  }

  @override
  String get fieldSpecies => 'Species';

  @override
  String get fieldSex => 'Sex';

  @override
  String get fieldStatus => 'Status';

  @override
  String get fieldAcquiredAt => 'Acquired on';

  @override
  String get fieldHatchDate => 'Hatch date';

  @override
  String get fieldEstimatedHatchDate => 'Estimated hatch date';

  @override
  String get fieldHatchUncertainty => 'Uncertainty (± days)';

  @override
  String get fieldStage => 'Current stage';

  @override
  String get fieldL3Phase => 'L3 phase (observational label)';

  @override
  String get fieldWeight => 'Current weight (g)';

  @override
  String get fieldContainer => 'Container volume (L)';

  @override
  String get fieldSubstrateType => 'Substrate type';

  @override
  String get fieldSubstrateBrand => 'Substrate brand';

  @override
  String get fieldSensor => 'Temperature sensor';

  @override
  String get fieldBreedingNotes => 'Breeding notes';

  @override
  String get beetleFormInitialSection => 'Initial records (saved as history events)';

  @override
  String get beetleFormStageHint => 'The stage is only set from your records, never inferred from weight.';

  @override
  String get beetleFormHistoryHint => 'Record later changes of weight, container, substrate and stage from the beetle page.';

  @override
  String get detailOverview => 'Overview';

  @override
  String get detailGrowth => 'Growth';

  @override
  String get detailHistory => 'History';

  @override
  String get detailPhotos => 'Photos';

  @override
  String get detailReminders => 'Reminders';

  @override
  String get detailAiAnalyses => 'AI analyses';

  @override
  String get detailAddPhoto => 'Add photo';

  @override
  String get detailNoPhotos => 'No photos';

  @override
  String get detailNoHistory => 'No records';

  @override
  String get detailAiInterpret => 'AI interpretation';

  @override
  String detailAiInterpretDone(int n) {
    return 'AI produced $n suggestion(s), added for your review';
  }

  @override
  String detailAiInterpretRejected(int n) {
    return '$n AI output(s) failed validation and were discarded';
  }

  @override
  String get detailLatestWeight => 'Latest weight';

  @override
  String get detailMaxWeight => 'Max';

  @override
  String get detailChangeSincePrevious => 'Since previous';

  @override
  String get detailAvgWeekly => 'Avg / week';

  @override
  String get detailNeedTwoWeights => 'At least two measurements are needed to calculate change';

  @override
  String get detailHatch => 'Hatched';

  @override
  String detailEstimatedHatch(String date, int days) {
    return '~$date (±$days days)';
  }

  @override
  String get detailAcquired => 'Acquired';

  @override
  String get detailContainer => 'Container';

  @override
  String get detailSubstrate => 'Substrate';

  @override
  String get detailChangeStatus => 'Change status';

  @override
  String get detailAvgNote => 'Averages only reflect the first and last record; growth is not linear.';

  @override
  String get recordsEmpty => 'No records yet';

  @override
  String get recordsAdd => 'Add record';

  @override
  String get chooseRecordType => 'Choose record type';

  @override
  String get chooseBeetle => 'Choose beetle';

  @override
  String get weightGrams => 'Weight (g)';

  @override
  String get weightDisturbWarning => 'This beetle is recorded as prepupa or pupa. Disturbing or weighing it at this stage can cause harm.';

  @override
  String get observationCategory => 'Category';

  @override
  String get observationDescription => 'Description';

  @override
  String get substrateQuantity => 'Quantity (L)';

  @override
  String get substrateBatch => 'Batch';

  @override
  String get weightDuringChange => 'Weight at change (g)';

  @override
  String get observedCondition => 'Observed condition';

  @override
  String get nextPlannedAt => 'Next planned check';

  @override
  String get containerPrevious => 'Previous (L, blank = last record)';

  @override
  String get containerNew => 'New container (L)';

  @override
  String get stageNew => 'New stage';

  @override
  String get stageIsEstimated => 'Date is an estimate';

  @override
  String get temperatureCelsius => 'Temperature (°C)';

  @override
  String get noSensors => 'Add a temperature sensor in Settings first';

  @override
  String get noBeetles => 'Add a beetle first';

  @override
  String get addPhotos => 'Add photos';

  @override
  String photosSelected(int n) {
    return '$n photo(s) selected';
  }

  @override
  String get photoFromCamera => 'Camera';

  @override
  String get photoFromGallery => 'Gallery';

  @override
  String suggestionsCreated(int n) {
    return 'Saved. $n suggestion(s) need your review';
  }

  @override
  String get remindersTabSuggested => 'To review';

  @override
  String get remindersTabUpcoming => 'Confirmed';

  @override
  String get remindersTabHistory => 'History';

  @override
  String get remindersEmptySuggested => 'No suggestions to review';

  @override
  String get remindersEmptyUpcoming => 'No confirmed reminders';

  @override
  String get remindersEmptyHistory => 'No history';

  @override
  String get reminderNew => 'New reminder';

  @override
  String get reminderTitleField => 'Title';

  @override
  String get reminderMessageField => 'Message';

  @override
  String get reminderDueAt => 'Remind at';

  @override
  String get reminderBeetleOptional => 'Beetle (optional)';

  @override
  String get reminderAccept => 'Accept';

  @override
  String get reminderReject => 'Reject';

  @override
  String get reminderPostpone => 'Postpone';

  @override
  String reminderPostponeDays(int days) {
    return 'Postpone $days day(s)';
  }

  @override
  String get reminderDisableSimilar => 'Stop similar suggestions';

  @override
  String reminderDisableSimilarConfirm(String event) {
    return 'Suggestions of this type ($event) will no longer be created. You can undo this in Settings.';
  }

  @override
  String get reminderComplete => 'Done';

  @override
  String get reminderCancel => 'Cancel reminder';

  @override
  String get reminderReason => 'Reason';

  @override
  String get reminderRecommendation => 'Recommendation';

  @override
  String reminderEvidence(int n) {
    return 'Based on $n record(s)';
  }

  @override
  String get reminderNeedsConfirmation => 'Notifications are only scheduled after you confirm';

  @override
  String get reminderReview => 'Review reminder';

  @override
  String get reminderAcceptEdited => 'Accept with changes';

  @override
  String get notificationsDenied => 'Notifications are off: reminders are saved but will not alert you.';

  @override
  String get notificationsRationale => 'Notification permission is needed to alert you at the chosen time.';

  @override
  String remindersDeferred(int n) {
    return '$n later reminder(s) will be scheduled closer to the date (OS limit)';
  }

  @override
  String get remindersInexact => 'Exact alarms not allowed; notifications may be slightly delayed.';

  @override
  String get reminderOverdue => 'Overdue';

  @override
  String ruleWeightChangeTitle(String code, String percent) {
    return '$code weight changed $percent%';
  }

  @override
  String ruleWeightChangeMessage(String code) {
    return 'Re-check $code\'s weight and condition.';
  }

  @override
  String ruleWeightChangeReason(String from, String percent, String to) {
    return 'The last two records changed from $from g to $to g ($percent%).';
  }

  @override
  String get ruleWeightLossRecommendation => 'Re-weigh in a week and check substrate and temperature. Weight loss in late L3 may relate to preparing for pupation or have other causes; avoid frequent disturbance.';

  @override
  String get ruleWeightGainRecommendation => 'Continue recording as usual.';

  @override
  String ruleOverdueTitle(String code) {
    return 'Weigh $code';
  }

  @override
  String get ruleOverdueMessage => 'It has been a while since the last weighing; consider weighing at the next substrate change.';

  @override
  String ruleOverdueReasonDays(int days) {
    return 'No weight recorded for $days days.';
  }

  @override
  String get ruleOverdueReasonNever => 'No weight has been recorded yet.';

  @override
  String get ruleOverdueRecommendation => 'Weigh larvae when convenient; do not dig up a prepupa or pupa to weigh it.';

  @override
  String ruleSubstrateTitle(String code) {
    return 'Check $code\'s substrate';
  }

  @override
  String get ruleSubstrateMessage => 'Check the substrate as planned.';

  @override
  String ruleSubstrateReason(int days) {
    return '$days days since the last substrate change; your planned check is due.';
  }

  @override
  String get ruleSubstrateRecommendation => 'Observe from outside first; if there are signs of a pupal chamber, do not replace it.';

  @override
  String ruleTempTitle(String sensor) {
    return 'Temperature out of range: $sensor';
  }

  @override
  String ruleTempMessage(String celsius, String sensor) {
    return '$sensor measured $celsius°C.';
  }

  @override
  String ruleTempReason(String celsius, String range) {
    return 'Measured $celsius°C is outside your configured range ($range). This is a measurement, not an AI prediction.';
  }

  @override
  String get ruleTempRecommendation => 'Check the room and temperature-control equipment.';

  @override
  String rulePrepupaTitle(String code) {
    return 'Observe $code';
  }

  @override
  String get rulePrepupaMessage => 'Check for externally visible changes and avoid unnecessary disturbance.';

  @override
  String get rulePrepupaReason => 'Recent notes mention color change or a pupal chamber, but the evidence is insufficient to confirm prepupation.';

  @override
  String get rulePrepupaRecommendation => 'Observe externally without disturbing a possible pupal chamber.';

  @override
  String ruleEmergenceTitle(String code) {
    return '$code expected emergence window';
  }

  @override
  String ruleEmergenceMessage(int max, int min) {
    return 'Based on your configured pupal period ($min–$max days), start watching for emergence.';
  }

  @override
  String ruleEmergenceReason(int max, int min) {
    return 'Pupation was recorded; your configured pupal period for this species is $min–$max days.';
  }

  @override
  String get ruleEmergenceRecommendation => 'Observe externally. Newly emerged adults need time to harden; do not remove them too early.';

  @override
  String get assistantHint => 'Ask about your records…';

  @override
  String get assistantEmptyTitle => 'Ask about your breeding records';

  @override
  String get assistantEmptyBody => 'The AI looks up your records before answering and labels what is recorded, calculated, hypothesized or recommended.';

  @override
  String get assistantExample1 => 'Is CCK-001 growing normally this month?';

  @override
  String get assistantExample2 => 'Compare DHH-001 and DHH-002 growth over the last three months.';

  @override
  String get assistantExample3 => 'Why has my larva lost weight recently?';

  @override
  String get assistantNoProvider => 'No AI model is available, so this question cannot be answered. Records, reminders and analytics still work.';

  @override
  String get assistantProviderMac => 'Mac local AI';

  @override
  String get assistantProviderMobile => 'On-device AI';

  @override
  String assistantFallback(String provider) {
    return 'Fell back to $provider';
  }

  @override
  String get assistantConsentTitle => 'Send data to your Mac?';

  @override
  String assistantConsentBody(String host) {
    return 'To answer, the app sends relevant breeding records to your configured Mac AI gateway ($host). Nothing is sent to any cloud service. You can revoke this in Settings.';
  }

  @override
  String get assistantConsentPublicWarning => 'Warning: this address is not a local, LAN or VPN address. Make sure it is your own device.';

  @override
  String get assistantConsentAllow => 'Allow';

  @override
  String assistantEvidence(int n) {
    return 'Based on $n record(s)';
  }

  @override
  String assistantToolsUsed(int n) {
    return '$n data lookup(s)';
  }

  @override
  String get assistantReminderDraft => 'Reminder proposed by AI (not created)';

  @override
  String get assistantReviewDraft => 'Review & confirm';

  @override
  String get assistantFeedbackHelpful => 'Helpful';

  @override
  String get assistantFeedbackNotHelpful => 'Not helpful';

  @override
  String assistantError(String error) {
    return 'Request failed: $error';
  }

  @override
  String get assistantThinking => 'Looking up records…';

  @override
  String get assistantGoToSettings => 'Open settings';

  @override
  String get assistantNewChat => 'New chat';

  @override
  String get assistantToolLoop => 'The AI made too many lookups and was stopped. Try a more specific question.';

  @override
  String get assistantImageUnavailable => 'Image analysis unavailable: no validated multimodal model is integrated.';

  @override
  String get claimVerified => 'Recorded';

  @override
  String get claimCalculated => 'Calculated';

  @override
  String get claimObservation => 'Observation';

  @override
  String get claimHypothesis => 'Hypothesis';

  @override
  String get claimRecommendation => 'Recommendation';

  @override
  String get claimUnknown => 'Unknown';

  @override
  String get claimUnclassified => 'Unlabeled';

  @override
  String get unavailableDisabled => 'Disabled';

  @override
  String get unavailableNotConfigured => 'Address or token not configured';

  @override
  String get unavailableConsent => 'Your consent is required';

  @override
  String get unavailableUnreachable => 'Unreachable';

  @override
  String get unavailableUnauthorized => 'Access token rejected';

  @override
  String get unavailableInsecure => 'HTTPS required (pin fingerprint for self-signed certs)';

  @override
  String get unavailableModelMissing => 'Model unavailable';

  @override
  String get unavailableNotBundled => 'Not included in this build';

  @override
  String get analyticsWeightComparison => 'Weight comparison';

  @override
  String get analyticsSelectBeetles => 'Select beetles to compare';

  @override
  String get analyticsTemperatureTrends => 'Temperature (7 days)';

  @override
  String get analyticsSubstrateHistory => 'Substrate changes';

  @override
  String get analyticsAiHistory => 'AI observation history';

  @override
  String get analyticsCorrelationNote => 'Charts only show recorded data; changes occurring together do not imply causation.';

  @override
  String get analyticsNoData => 'No data';

  @override
  String analyticsMinMax(String current, String high, String low) {
    return 'Now $current°C · min $low°C · max $high°C';
  }

  @override
  String analyticsTarget(String range, String target) {
    return 'Target $target°C · range $range';
  }

  @override
  String get analyticsRecentMeasurements => 'Recent measurements';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsAi => 'AI';

  @override
  String get settingsMacGateway => 'Mac AI gateway';

  @override
  String get settingsGatewayUrl => 'Gateway URL';

  @override
  String get settingsGatewayUrlHelper => 'e.g. https://my-mac.local:8443';

  @override
  String get settingsGatewayUrlInvalid => 'Enter an https:// URL';

  @override
  String get settingsGatewayToken => 'Access token';

  @override
  String get settingsGatewayTokenHelper => 'Generate on the Mac with `make gateway-token`; stored in the system keychain';

  @override
  String get settingsGatewayTokenSet => 'Saved (hidden)';

  @override
  String get settingsCertFingerprint => 'Certificate SHA-256 fingerprint';

  @override
  String get settingsCertFingerprintHelper => 'Required for self-signed certificates (printed by make gateway-cert)';

  @override
  String get settingsCertFingerprintInvalid => 'Must be 64 hex characters';

  @override
  String get settingsModel => 'Model';

  @override
  String get settingsTimeout => 'Timeout (s)';

  @override
  String get settingsTestConnection => 'Test connection';

  @override
  String get settingsConnectionOk => 'Connected';

  @override
  String get settingsEnabled => 'Enabled';

  @override
  String get settingsRouting => 'AI routing';

  @override
  String get routingAuto => 'Auto (prefer Mac)';

  @override
  String get routingMac => 'Mac only';

  @override
  String get routingMobile => 'Phone only';

  @override
  String get settingsMobileAi => 'On-device AI (llama.cpp)';

  @override
  String get settingsMobileAiStatus => 'Unavailable: llama.cpp runtime and model are not integrated in this build';

  @override
  String get settingsVision => 'Image analysis';

  @override
  String get settingsAutoAi => 'Ask AI to interpret after saving records';

  @override
  String get settingsAutoAiHelper => 'Sends that beetle\'s records to the Mac gateway; results are only suggestions for review';

  @override
  String get settingsRevokeConsent => 'Revoke data-sharing consent';

  @override
  String settingsConsentGranted(String date) {
    return 'Consent granted: $date';
  }

  @override
  String get settingsCareRules => 'Proactive care rules';

  @override
  String get ruleWeightPercent => 'Weight change threshold (%)';

  @override
  String get ruleGapDays => 'Measurement gap (days)';

  @override
  String get ruleSubstrateInterval => 'Substrate check interval (days, blank = off)';

  @override
  String get ruleSuggestionExpiry => 'Unreviewed suggestions expire after (days)';

  @override
  String get settingsSpecies => 'Species';

  @override
  String get speciesAdd => 'Add species';

  @override
  String get speciesCode => 'Code (2–8 uppercase letters/digits)';

  @override
  String get speciesScientific => 'Scientific name';

  @override
  String get speciesCommon => 'Common name';

  @override
  String get speciesPupaMin => 'Pupal period min (days)';

  @override
  String get speciesPupaMax => 'Pupal period max (days)';

  @override
  String get speciesPupaHelper => 'Leave blank if unknown; only used for emergence window suggestions';

  @override
  String get speciesBuiltin => 'Built-in';

  @override
  String get speciesRangeInvalid => 'Min must not exceed max';

  @override
  String get settingsSensors => 'Temperature sensors';

  @override
  String get sensorAdd => 'Add sensor';

  @override
  String get sensorName => 'Name';

  @override
  String get sensorLocation => 'Location';

  @override
  String get sensorKind => 'Type';

  @override
  String get sensorManual => 'Manual';

  @override
  String get sensorBluetooth => 'Bluetooth (not yet supported)';

  @override
  String get sensorWifi => 'Wi-Fi (not yet supported)';

  @override
  String get sensorMin => 'Minimum (°C)';

  @override
  String get sensorMax => 'Maximum (°C)';

  @override
  String get sensorTarget => 'Target (°C)';

  @override
  String get sensorThresholdHelper => 'Suitable temperatures differ by species and stage; set them for your own setup.';

  @override
  String get settingsSuppressions => 'Disabled suggestion types';

  @override
  String get suppressionAllBeetles => 'All beetles';

  @override
  String get settingsBackup => 'Backup & restore';

  @override
  String get backupExport => 'Export backup';

  @override
  String get backupExportHelper => 'Includes all records and photos; never includes access tokens';

  @override
  String get backupImport => 'Restore from backup';

  @override
  String get backupRestoreConfirm => 'The backup is merged by record ID: new records are added and newer edits replace older ones. No duplicates are created. Continue?';

  @override
  String backupRestored(int inserted, int skipped, int updated) {
    return 'Restored: $inserted added, $updated updated, $skipped unchanged';
  }

  @override
  String get backupErrorNotBackup => 'Not a valid backup file';

  @override
  String get backupErrorVersion => 'Unsupported backup version (possibly from a newer app)';

  @override
  String get backupErrorCorrupted => 'Backup is corrupted (integrity check failed)';

  @override
  String get backupErrorAlready => 'This backup was already restored';

  @override
  String backupErrorConflict(String codes) {
    return 'Code conflict: $codes. Different records with the same code exist on this device; nothing was changed.';
  }

  @override
  String get settingsAiMemory => 'AI memory';

  @override
  String get aiMemoryEmpty => 'No AI analyses yet';

  @override
  String get aiMemoryDeleteAll => 'Delete all AI analyses';

  @override
  String get aiMemoryDeleteConfirm => 'Only AI-generated analyses are deleted. Breeding records are not affected.';

  @override
  String get aiMemoryOutcome => 'Prediction outcome';

  @override
  String get outcomeNotApplicable => 'N/A';

  @override
  String get outcomePending => 'Pending';

  @override
  String get outcomeCorrect => 'Correct';

  @override
  String get outcomeIncorrect => 'Incorrect';

  @override
  String get aiMemoryQuestion => 'Question';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get privacyBody => 'All data stays on this device. No account, no analytics. Data is sent only to your own Mac gateway after you consent, never to a cloud service.';

  @override
  String get settingsAbout => 'About';

  @override
  String aboutVersion(String version) {
    return 'Version $version';
  }

  @override
  String get parentsSection => 'Parents';

  @override
  String get parentsHint => 'Pick a beetle from your collection, or describe a parent you never kept here.';

  @override
  String get fieldSire => 'Father (sire)';

  @override
  String get fieldDam => 'Mother (dam)';

  @override
  String get parentNotInCollection => 'Not in collection';

  @override
  String get fieldSireNote => 'Father details';

  @override
  String get fieldDamNote => 'Mother details';

  @override
  String get parentNoteHelper => 'e.g. WD 150 mm, Guadeloupe';

  @override
  String get parentUnknown => 'Not recorded';

  @override
  String offspringSection(int count) {
    return 'Offspring ($count)';
  }

  @override
  String get parentErrorSelf => 'A beetle cannot be its own parent';

  @override
  String get parentErrorSame => 'Father and mother must be different beetles';

  @override
  String get parentErrorNotFound => 'The selected parent no longer exists';

  @override
  String get parentErrorWrongSex => 'The father must be male and the mother female';

  @override
  String get parentErrorCycle => 'That would make the beetle its own ancestor';

  @override
  String get parentErrorSexConflict => 'This beetle already has offspring as the other parent, so it cannot change to this sex';
}

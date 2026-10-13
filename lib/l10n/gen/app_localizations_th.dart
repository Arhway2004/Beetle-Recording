// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'ผู้ช่วยเลี้ยงด้วง';

  @override
  String get navDashboard => 'หน้าหลัก';

  @override
  String get navBeetles => 'ด้วง';

  @override
  String get navRecords => 'บันทึก';

  @override
  String get navAssistant => 'ผู้ช่วย AI';

  @override
  String get navReminders => 'การแจ้งเตือน';

  @override
  String get navAnalytics => 'การวิเคราะห์';

  @override
  String get navSettings => 'การตั้งค่า';

  @override
  String get commonSave => 'บันทึก';

  @override
  String get commonCancel => 'ยกเลิก';

  @override
  String get commonDelete => 'ลบ';

  @override
  String get commonEdit => 'แก้ไข';

  @override
  String get commonConfirm => 'ยืนยัน';

  @override
  String get commonRetry => 'ลองอีกครั้ง';

  @override
  String get commonClose => 'ปิด';

  @override
  String get commonAdd => 'เพิ่ม';

  @override
  String get commonAll => 'ทั้งหมด';

  @override
  String get commonNone => 'ไม่มี';

  @override
  String get commonOptional => 'ไม่บังคับ';

  @override
  String get commonRequired => 'จำเป็น';

  @override
  String get commonInvalidNumber => 'กรุณากรอกตัวเลขที่ถูกต้อง';

  @override
  String get commonMustBePositive => 'ต้องมากกว่า 0';

  @override
  String get commonErrorTitle => 'เกิดข้อผิดพลาด';

  @override
  String get commonSaved => 'บันทึกแล้ว';

  @override
  String get commonNotes => 'หมายเหตุ';

  @override
  String get commonDateTime => 'วันและเวลา';

  @override
  String get commonDeleteConfirmTitle => 'ยืนยันการลบ?';

  @override
  String get commonDeleteRecordMessage => 'บันทึกจะถูกทำเครื่องหมายว่าลบแล้ว (เก็บไว้เพื่อการตรวจสอบ) และค่าปัจจุบันของด้วงจะย้อนกลับไปใช้บันทึกก่อนหน้า';

  @override
  String get commonNotSet => 'ยังไม่ได้ตั้งค่า';

  @override
  String get sexMale => 'ตัวผู้';

  @override
  String get sexFemale => 'ตัวเมีย';

  @override
  String get sexUnknown => 'ไม่ทราบ';

  @override
  String get stageL1 => 'ตัวอ่อน L1';

  @override
  String get stageL2 => 'ตัวอ่อน L2';

  @override
  String get stageL3 => 'ตัวอ่อน L3';

  @override
  String get stagePrepupa => 'ก่อนเข้าดักแด้';

  @override
  String get stagePupa => 'ดักแด้';

  @override
  String get stageAdult => 'ตัวเต็มวัย';

  @override
  String get stageUnset => 'ยังไม่บันทึกระยะ';

  @override
  String get l3Early => 'ช่วงต้น';

  @override
  String get l3Middle => 'ช่วงกลาง';

  @override
  String get l3Late => 'ช่วงปลาย';

  @override
  String get statusActive => 'กำลังเลี้ยง';

  @override
  String get statusDeceased => 'ตายแล้ว';

  @override
  String get statusTransferred => 'โอนแล้ว';

  @override
  String get statusArchived => 'เก็บถาวร';

  @override
  String get obsGeneral => 'ทั่วไป';

  @override
  String get obsColorChange => 'สีเปลี่ยน';

  @override
  String get obsActivity => 'การเคลื่อนไหว';

  @override
  String get obsFeeding => 'การกิน';

  @override
  String get obsPupalChamber => 'โพรงดักแด้';

  @override
  String get obsMolt => 'ลอกคราบ';

  @override
  String get obsHealth => 'สุขภาพ';

  @override
  String get obsBehavior => 'พฤติกรรม';

  @override
  String get reminderStatusSuggested => 'รอยืนยัน';

  @override
  String get reminderStatusConfirmed => 'ยืนยันแล้ว';

  @override
  String get reminderStatusScheduled => 'ตั้งเวลาแล้ว';

  @override
  String get reminderStatusCompleted => 'เสร็จแล้ว';

  @override
  String get reminderStatusCancelled => 'ยกเลิกแล้ว';

  @override
  String get reminderStatusExpired => 'หมดอายุ';

  @override
  String get severityInfo => 'ข้อมูล';

  @override
  String get severityObservation => 'เฝ้าสังเกต';

  @override
  String get severityWarning => 'ควรระวัง';

  @override
  String get severityAlert => 'แจ้งเตือนด่วน';

  @override
  String confidenceLabel(String level) {
    return 'ความมั่นใจ: $level';
  }

  @override
  String get confidenceLow => 'ต่ำ';

  @override
  String get confidenceMedium => 'ปานกลาง';

  @override
  String get confidenceHigh => 'สูง';

  @override
  String get basisMeasured => 'ค่าที่วัดได้';

  @override
  String get basisCalculated => 'ผลการคำนวณ';

  @override
  String get basisAiInference => 'การอนุมานของ AI';

  @override
  String get sourceUser => 'สร้างโดยคุณ';

  @override
  String get sourceRule => 'ตรวจพบโดยกฎ';

  @override
  String get sourceAi => 'คำแนะนำจาก AI';

  @override
  String get recordWeight => 'น้ำหนัก';

  @override
  String get recordObservation => 'การสังเกต';

  @override
  String get recordSubstrate => 'เปลี่ยนดิน';

  @override
  String get recordContainer => 'เปลี่ยนกล่อง';

  @override
  String get recordLifeStage => 'เปลี่ยนระยะ';

  @override
  String get recordTemperature => 'อุณหภูมิ';

  @override
  String get eventSignificantWeightChange => 'น้ำหนักเปลี่ยนมาก';

  @override
  String get eventWeightLoss => 'น้ำหนักลด';

  @override
  String get eventMeasurementOverdue => 'ไม่ได้ชั่งน้ำหนักนาน';

  @override
  String get eventSubstrateInspection => 'ตรวจ/เปลี่ยนดิน';

  @override
  String get eventContainerReview => 'ประเมินกล่อง';

  @override
  String get eventTemperatureOutOfRange => 'อุณหภูมิเกินช่วง';

  @override
  String get eventPossiblePrepupa => 'อาจเข้าระยะก่อนดักแด้';

  @override
  String get eventPossiblePupation => 'อาจเข้าดักแด้';

  @override
  String get eventExpectedEmergenceWindow => 'ช่วงที่คาดว่าจะออกจากดักแด้';

  @override
  String get eventOutdatedReminder => 'การแจ้งเตือนที่ล้าสมัย';

  @override
  String get eventGeneralObservation => 'การสังเกตทั่วไป';

  @override
  String get eventCustom => 'กำหนดเอง';

  @override
  String get dashboardActiveBeetles => 'กำลังเลี้ยง';

  @override
  String get dashboardPendingSuggestions => 'คำแนะนำรอยืนยัน';

  @override
  String get dashboardUpcoming => 'การแจ้งเตือนที่ใกล้ถึง';

  @override
  String get dashboardRecent => 'บันทึกล่าสุด';

  @override
  String get dashboardEmptyTitle => 'ยังไม่มีด้วง';

  @override
  String get dashboardEmptyBody => 'เพิ่มด้วงตัวแรกเพื่อเริ่มติดตามการเติบโต';

  @override
  String get dashboardAddBeetle => 'เพิ่มด้วง';

  @override
  String get dashboardBySpecies => 'ตามชนิด';

  @override
  String get dashboardByStage => 'ตามระยะ';

  @override
  String get dashboardNoUpcoming => 'ไม่มีการแจ้งเตือน';

  @override
  String dashboardTemperatureAlert(String celsius, String sensor) {
    return '$sensor: $celsius°C อยู่นอกช่วงที่คุณตั้งไว้';
  }

  @override
  String get dashboardReviewSuggestions => 'ดู';

  @override
  String get beetlesSearchHint => 'ค้นหารหัสหรือหมายเหตุ';

  @override
  String get beetlesEmpty => 'ไม่มีด้วงที่ตรงเงื่อนไข';

  @override
  String get filterSpecies => 'ชนิด';

  @override
  String get filterSex => 'เพศ';

  @override
  String get filterStage => 'ระยะ';

  @override
  String get filterStatus => 'สถานะ';

  @override
  String get beetleFormNewTitle => 'เพิ่มด้วงใหม่';

  @override
  String get beetleFormEditTitle => 'แก้ไขด้วง';

  @override
  String get fieldCode => 'รหัส';

  @override
  String get fieldCodeHelper => 'เช่น DHH-001';

  @override
  String get fieldCodeInvalid => 'รูปแบบต้องเป็น ชนิด-หมายเลข เช่น DHH-001';

  @override
  String fieldCodeDuplicate(String code) {
    return 'รหัส $code มีอยู่แล้ว';
  }

  @override
  String get fieldSpecies => 'ชนิด';

  @override
  String get fieldSex => 'เพศ';

  @override
  String get fieldStatus => 'สถานะ';

  @override
  String get fieldAcquiredAt => 'วันที่ได้มา';

  @override
  String get fieldHatchDate => 'วันฟักไข่';

  @override
  String get fieldEstimatedHatchDate => 'วันฟักโดยประมาณ';

  @override
  String get fieldHatchUncertainty => 'ความคลาดเคลื่อน (± วัน)';

  @override
  String get fieldStage => 'ระยะปัจจุบัน';

  @override
  String get fieldL3Phase => 'ช่วงของ L3 (ป้ายจากการสังเกต)';

  @override
  String get fieldWeight => 'น้ำหนักปัจจุบัน (กรัม)';

  @override
  String get fieldContainer => 'ขนาดกล่อง (ลิตร)';

  @override
  String get fieldSubstrateType => 'ชนิดดิน';

  @override
  String get fieldSubstrateBrand => 'ยี่ห้อดิน';

  @override
  String get fieldSensor => 'เซนเซอร์อุณหภูมิ';

  @override
  String get fieldBreedingNotes => 'บันทึกการเลี้ยง';

  @override
  String get beetleFormInitialSection => 'บันทึกเริ่มต้น (บันทึกเป็นประวัติ)';

  @override
  String get beetleFormStageHint => 'ระยะจะกำหนดจากบันทึกของคุณเท่านั้น ไม่ได้อนุมานจากน้ำหนัก';

  @override
  String get beetleFormHistoryHint => 'การเปลี่ยนแปลงภายหลังให้เพิ่มเป็นบันทึกในหน้ารายละเอียด';

  @override
  String get detailOverview => 'ภาพรวม';

  @override
  String get detailGrowth => 'การเติบโต';

  @override
  String get detailHistory => 'ประวัติ';

  @override
  String get detailPhotos => 'รูปภาพ';

  @override
  String get detailReminders => 'การแจ้งเตือน';

  @override
  String get detailAiAnalyses => 'ผลวิเคราะห์ AI';

  @override
  String get detailAddPhoto => 'เพิ่มรูป';

  @override
  String get detailNoPhotos => 'ยังไม่มีรูป';

  @override
  String get detailNoHistory => 'ยังไม่มีบันทึก';

  @override
  String get detailAiInterpret => 'ให้ AI วิเคราะห์';

  @override
  String detailAiInterpretDone(int n) {
    return 'AI สร้างคำแนะนำ $n รายการ รอให้คุณยืนยัน';
  }

  @override
  String detailAiInterpretRejected(int n) {
    return 'ผลลัพธ์ AI $n รายการไม่ผ่านการตรวจสอบและถูกทิ้ง';
  }

  @override
  String get detailLatestWeight => 'น้ำหนักล่าสุด';

  @override
  String get detailMaxWeight => 'สูงสุด';

  @override
  String get detailChangeSincePrevious => 'เทียบครั้งก่อน';

  @override
  String get detailAvgWeekly => 'เฉลี่ย/สัปดาห์';

  @override
  String get detailNeedTwoWeights => 'ต้องมีการชั่งอย่างน้อยสองครั้งจึงจะคำนวณการเปลี่ยนแปลงได้';

  @override
  String get detailHatch => 'ฟัก';

  @override
  String detailEstimatedHatch(String date, int days) {
    return 'ประมาณ $date (±$days วัน)';
  }

  @override
  String get detailAcquired => 'ได้มา';

  @override
  String get detailContainer => 'กล่อง';

  @override
  String get detailSubstrate => 'ดิน';

  @override
  String get detailChangeStatus => 'เปลี่ยนสถานะ';

  @override
  String get detailAvgNote => 'ค่าเฉลี่ยสะท้อนเพียงบันทึกแรกและล่าสุด การเติบโตไม่เป็นเส้นตรง';

  @override
  String get recordsEmpty => 'ยังไม่มีบันทึก';

  @override
  String get recordsAdd => 'เพิ่มบันทึก';

  @override
  String get chooseRecordType => 'เลือกประเภทบันทึก';

  @override
  String get chooseBeetle => 'เลือกด้วง';

  @override
  String get weightGrams => 'น้ำหนัก (กรัม)';

  @override
  String get weightDisturbWarning => 'ด้วงตัวนี้อยู่ในระยะก่อนดักแด้หรือดักแด้ การรบกวนหรือชั่งน้ำหนักอาจเป็นอันตราย';

  @override
  String get observationCategory => 'หมวดหมู่';

  @override
  String get observationDescription => 'รายละเอียด';

  @override
  String get substrateQuantity => 'ปริมาณ (ลิตร)';

  @override
  String get substrateBatch => 'ล็อต';

  @override
  String get weightDuringChange => 'น้ำหนักขณะเปลี่ยน (กรัม)';

  @override
  String get observedCondition => 'สภาพที่สังเกตได้';

  @override
  String get nextPlannedAt => 'กำหนดตรวจครั้งถัดไป';

  @override
  String get containerPrevious => 'กล่องเดิม (ลิตร เว้นว่าง = ค่าล่าสุด)';

  @override
  String get containerNew => 'กล่องใหม่ (ลิตร)';

  @override
  String get stageNew => 'ระยะใหม่';

  @override
  String get stageIsEstimated => 'วันที่เป็นค่าประมาณ';

  @override
  String get temperatureCelsius => 'อุณหภูมิ (°C)';

  @override
  String get noSensors => 'กรุณาเพิ่มเซนเซอร์อุณหภูมิในการตั้งค่าก่อน';

  @override
  String get noBeetles => 'กรุณาเพิ่มด้วงก่อน';

  @override
  String get addPhotos => 'เพิ่มรูป';

  @override
  String photosSelected(int n) {
    return 'เลือกรูปแล้ว $n รูป';
  }

  @override
  String get photoFromCamera => 'ถ่ายรูป';

  @override
  String get photoFromGallery => 'เลือกจากคลังภาพ';

  @override
  String suggestionsCreated(int n) {
    return 'บันทึกแล้ว มีคำแนะนำ $n รายการรอยืนยัน';
  }

  @override
  String get remindersTabSuggested => 'รอยืนยัน';

  @override
  String get remindersTabUpcoming => 'ยืนยันแล้ว';

  @override
  String get remindersTabHistory => 'ประวัติ';

  @override
  String get remindersEmptySuggested => 'ไม่มีคำแนะนำรอยืนยัน';

  @override
  String get remindersEmptyUpcoming => 'ไม่มีการแจ้งเตือนที่ยืนยันแล้ว';

  @override
  String get remindersEmptyHistory => 'ยังไม่มีประวัติ';

  @override
  String get reminderNew => 'สร้างการแจ้งเตือน';

  @override
  String get reminderTitleField => 'หัวข้อ';

  @override
  String get reminderMessageField => 'ข้อความ';

  @override
  String get reminderDueAt => 'เวลาแจ้งเตือน';

  @override
  String get reminderBeetleOptional => 'ด้วง (ไม่บังคับ)';

  @override
  String get reminderAccept => 'ยอมรับ';

  @override
  String get reminderReject => 'ปฏิเสธ';

  @override
  String get reminderPostpone => 'เลื่อน';

  @override
  String reminderPostponeDays(int days) {
    return 'เลื่อน $days วัน';
  }

  @override
  String get reminderDisableSimilar => 'ไม่ต้องแนะนำแบบนี้อีก';

  @override
  String reminderDisableSimilarConfirm(String event) {
    return 'จะไม่สร้างคำแนะนำประเภทนี้ ($event) อีก สามารถเปลี่ยนกลับได้ในการตั้งค่า';
  }

  @override
  String get reminderComplete => 'เสร็จ';

  @override
  String get reminderCancel => 'ยกเลิกการแจ้งเตือน';

  @override
  String get reminderReason => 'เหตุผล';

  @override
  String get reminderRecommendation => 'คำแนะนำ';

  @override
  String reminderEvidence(int n) {
    return 'อ้างอิงบันทึก $n รายการ';
  }

  @override
  String get reminderNeedsConfirmation => 'จะตั้งเวลาแจ้งเตือนหลังจากคุณยืนยันเท่านั้น';

  @override
  String get reminderReview => 'ตรวจสอบการแจ้งเตือน';

  @override
  String get reminderAcceptEdited => 'ยอมรับพร้อมแก้ไข';

  @override
  String get notificationsDenied => 'การแจ้งเตือนถูกปิด: บันทึกการแจ้งเตือนแล้วแต่จะไม่มีการแจ้งเตือนจากระบบ';

  @override
  String get notificationsRationale => 'ต้องการสิทธิ์การแจ้งเตือนเพื่อเตือนคุณตามเวลาที่กำหนด';

  @override
  String remindersDeferred(int n) {
    return 'การแจ้งเตือน $n รายการจะถูกตั้งเวลาเมื่อใกล้ถึง (ข้อจำกัดของระบบ)';
  }

  @override
  String get remindersInexact => 'ไม่ได้รับสิทธิ์การปลุกแบบแม่นยำ การแจ้งเตือนอาจล่าช้าเล็กน้อย';

  @override
  String get reminderOverdue => 'เลยกำหนด';

  @override
  String ruleWeightChangeTitle(String code, String percent) {
    return '$code น้ำหนักเปลี่ยน $percent%';
  }

  @override
  String ruleWeightChangeMessage(String code) {
    return 'ตรวจน้ำหนักและสภาพของ $code อีกครั้ง';
  }

  @override
  String ruleWeightChangeReason(String from, String percent, String to) {
    return 'บันทึกสองครั้งล่าสุดเปลี่ยนจาก $from g เป็น $to g ($percent%)';
  }

  @override
  String get ruleWeightLossRecommendation => 'ชั่งใหม่ในอีกหนึ่งสัปดาห์ และตรวจดินกับอุณหภูมิ น้ำหนักที่ลดในช่วงปลาย L3 อาจเกี่ยวกับการเตรียมเข้าดักแด้หรือสาเหตุอื่น หลีกเลี่ยงการรบกวนบ่อย';

  @override
  String get ruleWeightGainRecommendation => 'บันทึกตามปกติต่อไป';

  @override
  String ruleOverdueTitle(String code) {
    return 'ชั่งน้ำหนัก $code';
  }

  @override
  String get ruleOverdueMessage => 'ไม่ได้ชั่งมานานแล้ว อาจชั่งตอนเปลี่ยนดินครั้งถัดไป';

  @override
  String ruleOverdueReasonDays(int days) {
    return 'ไม่มีบันทึกน้ำหนักมา $days วัน';
  }

  @override
  String get ruleOverdueReasonNever => 'ยังไม่มีบันทึกน้ำหนัก';

  @override
  String get ruleOverdueRecommendation => 'ชั่งตัวอ่อนเมื่อสะดวก อย่าขุดระยะก่อนดักแด้หรือดักแด้ขึ้นมาชั่ง';

  @override
  String ruleSubstrateTitle(String code) {
    return 'ตรวจดินของ $code';
  }

  @override
  String get ruleSubstrateMessage => 'ตรวจสภาพดินตามแผน';

  @override
  String ruleSubstrateReason(int days) {
    return 'ผ่านไป $days วันตั้งแต่เปลี่ยนดินครั้งล่าสุด ถึงกำหนดตรวจที่คุณตั้งไว้';
  }

  @override
  String get ruleSubstrateRecommendation => 'สังเกตจากภายนอกก่อน หากมีร่องรอยโพรงดักแด้ อย่าเปลี่ยนดิน';

  @override
  String ruleTempTitle(String sensor) {
    return 'อุณหภูมิเกินช่วง: $sensor';
  }

  @override
  String ruleTempMessage(String celsius, String sensor) {
    return '$sensor วัดได้ $celsius°C';
  }

  @override
  String ruleTempReason(String celsius, String range) {
    return 'ค่าที่วัดได้ $celsius°C อยู่นอกช่วงที่ตั้งไว้ ($range) นี่คือค่าที่วัดได้ ไม่ใช่การคาดการณ์ของ AI';
  }

  @override
  String get ruleTempRecommendation => 'ตรวจสอบอุณหภูมิห้องและอุปกรณ์ควบคุมอุณหภูมิ';

  @override
  String rulePrepupaTitle(String code) {
    return 'สังเกต $code';
  }

  @override
  String get rulePrepupaMessage => 'ตรวจการเปลี่ยนแปลงที่มองเห็นได้จากภายนอก หลีกเลี่ยงการรบกวนที่ไม่จำเป็น';

  @override
  String get rulePrepupaReason => 'บันทึกล่าสุดระบุสีเปลี่ยนหรือโพรงดักแด้ แต่หลักฐานยังไม่พอจะยืนยันระยะก่อนดักแด้';

  @override
  String get rulePrepupaRecommendation => 'สังเกตจากภายนอกโดยไม่รบกวนโพรงดักแด้ที่อาจมีอยู่';

  @override
  String ruleEmergenceTitle(String code) {
    return 'ช่วงคาดว่า $code จะออกจากดักแด้';
  }

  @override
  String ruleEmergenceMessage(int max, int min) {
    return 'ตามระยะดักแด้ที่คุณตั้งไว้ ($min–$max วัน) เริ่มเฝ้าดูการออกจากดักแด้';
  }

  @override
  String ruleEmergenceReason(int max, int min) {
    return 'มีบันทึกการเข้าดักแด้ ระยะดักแด้ที่คุณตั้งไว้สำหรับชนิดนี้คือ $min–$max วัน';
  }

  @override
  String get ruleEmergenceRecommendation => 'สังเกตจากภายนอก ตัวเต็มวัยที่เพิ่งออกต้องใช้เวลาให้เปลือกแข็ง อย่านำออกเร็วเกินไป';

  @override
  String get assistantHint => 'ถามเกี่ยวกับบันทึกของคุณ…';

  @override
  String get assistantEmptyTitle => 'ถามเกี่ยวกับบันทึกการเลี้ยง';

  @override
  String get assistantEmptyBody => 'AI จะค้นบันทึกของคุณก่อนตอบ และระบุว่าส่วนไหนเป็นบันทึก การคำนวณ การคาดเดา หรือคำแนะนำ';

  @override
  String get assistantExample1 => 'CCK-001 เดือนนี้โตปกติไหม?';

  @override
  String get assistantExample2 => 'เปรียบเทียบการเติบโตของ DHH-001 และ DHH-002 ในสามเดือนที่ผ่านมา';

  @override
  String get assistantExample3 => 'ทำไมตัวอ่อนของฉันน้ำหนักลดลง?';

  @override
  String get assistantNoProvider => 'ไม่มีโมเดล AI ที่ใช้งานได้ จึงไม่สามารถตอบได้ บันทึก การแจ้งเตือน และการวิเคราะห์ยังใช้งานได้ตามปกติ';

  @override
  String get assistantProviderMac => 'AI บน Mac';

  @override
  String get assistantProviderMobile => 'AI บนมือถือ';

  @override
  String assistantFallback(String provider) {
    return 'เปลี่ยนไปใช้ $provider';
  }

  @override
  String get assistantConsentTitle => 'อนุญาตให้ส่งข้อมูลไปยัง Mac?';

  @override
  String assistantConsentBody(String host) {
    return 'เพื่อตอบคำถาม แอปจะส่งบันทึกที่เกี่ยวข้องไปยังเกตเวย์ AI บน Mac ที่คุณตั้งค่าไว้ ($host) จะไม่ส่งไปยังบริการคลาวด์ใด ๆ คุณเพิกถอนได้ในการตั้งค่า';
  }

  @override
  String get assistantConsentPublicWarning => 'คำเตือน: ที่อยู่นี้ไม่ใช่เครื่องนี้หรือเครือข่าย LAN/VPN โปรดยืนยันว่าเป็นอุปกรณ์ของคุณเอง';

  @override
  String get assistantConsentAllow => 'อนุญาต';

  @override
  String assistantEvidence(int n) {
    return 'อ้างอิง $n บันทึก';
  }

  @override
  String assistantToolsUsed(int n) {
    return 'ค้นข้อมูล $n ครั้ง';
  }

  @override
  String get assistantReminderDraft => 'การแจ้งเตือนที่ AI เสนอ (ยังไม่ได้สร้าง)';

  @override
  String get assistantReviewDraft => 'ตรวจสอบและยืนยัน';

  @override
  String get assistantFeedbackHelpful => 'มีประโยชน์';

  @override
  String get assistantFeedbackNotHelpful => 'ไม่มีประโยชน์';

  @override
  String assistantError(String error) {
    return 'คำขอล้มเหลว: $error';
  }

  @override
  String get assistantThinking => 'กำลังค้นบันทึก…';

  @override
  String get assistantGoToSettings => 'ไปที่การตั้งค่า';

  @override
  String get assistantNewChat => 'แชทใหม่';

  @override
  String get assistantToolLoop => 'AI ค้นข้อมูลมากเกินไปและถูกหยุด ลองถามให้เจาะจงขึ้น';

  @override
  String get assistantImageUnavailable => 'การวิเคราะห์ภาพยังใช้ไม่ได้: ยังไม่มีโมเดลมัลติโมดัลที่ผ่านการตรวจสอบ';

  @override
  String get claimVerified => 'บันทึกไว้';

  @override
  String get claimCalculated => 'คำนวณ';

  @override
  String get claimObservation => 'การสังเกต';

  @override
  String get claimHypothesis => 'สมมติฐาน';

  @override
  String get claimRecommendation => 'คำแนะนำ';

  @override
  String get claimUnknown => 'ไม่ทราบ';

  @override
  String get claimUnclassified => 'ไม่ระบุ';

  @override
  String get unavailableDisabled => 'ปิดอยู่';

  @override
  String get unavailableNotConfigured => 'ยังไม่ได้ตั้งค่าที่อยู่หรือโทเค็น';

  @override
  String get unavailableConsent => 'ต้องได้รับความยินยอมจากคุณ';

  @override
  String get unavailableUnreachable => 'เชื่อมต่อไม่ได้';

  @override
  String get unavailableUnauthorized => 'โทเค็นไม่ถูกต้อง';

  @override
  String get unavailableInsecure => 'ต้องใช้ HTTPS (ใส่ลายนิ้วมือสำหรับใบรับรองที่ลงนามเอง)';

  @override
  String get unavailableModelMissing => 'โมเดลไม่พร้อมใช้งาน';

  @override
  String get unavailableNotBundled => 'ไม่มีในเวอร์ชันนี้';

  @override
  String get analyticsWeightComparison => 'เปรียบเทียบน้ำหนัก';

  @override
  String get analyticsSelectBeetles => 'เลือกด้วงที่จะเปรียบเทียบ';

  @override
  String get analyticsTemperatureTrends => 'แนวโน้มอุณหภูมิ (7 วัน)';

  @override
  String get analyticsSubstrateHistory => 'ประวัติการเปลี่ยนดิน';

  @override
  String get analyticsAiHistory => 'ประวัติการสังเกตของ AI';

  @override
  String get analyticsCorrelationNote => 'กราฟแสดงเฉพาะข้อมูลที่บันทึก การเปลี่ยนแปลงที่เกิดพร้อมกันไม่ได้แปลว่าเป็นเหตุและผล';

  @override
  String get analyticsNoData => 'ไม่มีข้อมูล';

  @override
  String analyticsMinMax(String current, String high, String low) {
    return 'ตอนนี้ $current°C · ต่ำสุด $low°C · สูงสุด $high°C';
  }

  @override
  String analyticsTarget(String range, String target) {
    return 'เป้าหมาย $target°C · ช่วง $range';
  }

  @override
  String get analyticsRecentMeasurements => 'การชั่งล่าสุด';

  @override
  String get settingsAppearance => 'รูปลักษณ์';

  @override
  String get settingsTheme => 'ธีม';

  @override
  String get themeSystem => 'ตามระบบ';

  @override
  String get themeLight => 'สว่าง';

  @override
  String get themeDark => 'มืด';

  @override
  String get settingsLanguage => 'ภาษา';

  @override
  String get settingsAi => 'AI';

  @override
  String get settingsMacGateway => 'เกตเวย์ AI บน Mac';

  @override
  String get settingsGatewayUrl => 'URL เกตเวย์';

  @override
  String get settingsGatewayUrlHelper => 'เช่น https://my-mac.local:8443';

  @override
  String get settingsGatewayUrlInvalid => 'กรุณาใส่ URL ที่ขึ้นต้นด้วย https://';

  @override
  String get settingsGatewayToken => 'โทเค็นการเข้าถึง';

  @override
  String get settingsGatewayTokenHelper => 'สร้างบน Mac ด้วย make gateway-token และเก็บในพวงกุญแจของระบบ';

  @override
  String get settingsGatewayTokenSet => 'บันทึกแล้ว (ซ่อน)';

  @override
  String get settingsCertFingerprint => 'ลายนิ้วมือ SHA-256 ของใบรับรอง';

  @override
  String get settingsCertFingerprintHelper => 'จำเป็นสำหรับใบรับรองที่ลงนามเอง (แสดงโดย make gateway-cert)';

  @override
  String get settingsCertFingerprintInvalid => 'ต้องเป็นเลขฐานสิบหก 64 ตัว';

  @override
  String get settingsModel => 'โมเดล';

  @override
  String get settingsTimeout => 'หมดเวลา (วินาที)';

  @override
  String get settingsTestConnection => 'ทดสอบการเชื่อมต่อ';

  @override
  String get settingsConnectionOk => 'เชื่อมต่อสำเร็จ';

  @override
  String get settingsEnabled => 'เปิดใช้งาน';

  @override
  String get settingsRouting => 'การเลือก AI';

  @override
  String get routingAuto => 'อัตโนมัติ (ใช้ Mac ก่อน)';

  @override
  String get routingMac => 'Mac เท่านั้น';

  @override
  String get routingMobile => 'มือถือเท่านั้น';

  @override
  String get settingsMobileAi => 'AI บนมือถือ (llama.cpp)';

  @override
  String get settingsMobileAiStatus => 'ยังใช้ไม่ได้: เวอร์ชันนี้ยังไม่มี llama.cpp และโมเดล';

  @override
  String get settingsVision => 'การวิเคราะห์ภาพ';

  @override
  String get settingsAutoAi => 'ให้ AI วิเคราะห์อัตโนมัติหลังบันทึก';

  @override
  String get settingsAutoAiHelper => 'จะส่งบันทึกของด้วงตัวนั้นไปยังเกตเวย์ Mac ผลลัพธ์เป็นเพียงคำแนะนำรอยืนยัน';

  @override
  String get settingsRevokeConsent => 'เพิกถอนความยินยอมในการส่งข้อมูล';

  @override
  String settingsConsentGranted(String date) {
    return 'ให้ความยินยอมแล้ว: $date';
  }

  @override
  String get settingsCareRules => 'กฎการดูแลเชิงรุก';

  @override
  String get ruleWeightPercent => 'เกณฑ์การเปลี่ยนน้ำหนัก (%)';

  @override
  String get ruleGapDays => 'ไม่ได้ชั่งนานเกิน (วัน)';

  @override
  String get ruleSubstrateInterval => 'รอบตรวจดิน (วัน เว้นว่าง = ปิด)';

  @override
  String get ruleSuggestionExpiry => 'คำแนะนำที่ไม่ได้ตรวจหมดอายุหลัง (วัน)';

  @override
  String get settingsSpecies => 'จัดการชนิด';

  @override
  String get speciesAdd => 'เพิ่มชนิด';

  @override
  String get speciesCode => 'รหัส (ตัวพิมพ์ใหญ่/ตัวเลข 2–8 ตัว)';

  @override
  String get speciesScientific => 'ชื่อวิทยาศาสตร์';

  @override
  String get speciesCommon => 'ชื่อสามัญ';

  @override
  String get speciesPupaMin => 'ระยะดักแด้ต่ำสุด (วัน)';

  @override
  String get speciesPupaMax => 'ระยะดักแด้สูงสุด (วัน)';

  @override
  String get speciesPupaHelper => 'เว้นว่างถ้าไม่ทราบ ใช้สำหรับคำแนะนำช่วงออกจากดักแด้เท่านั้น';

  @override
  String get speciesBuiltin => 'ในตัว';

  @override
  String get speciesRangeInvalid => 'ค่าต่ำสุดต้องไม่เกินค่าสูงสุด';

  @override
  String get settingsSensors => 'เซนเซอร์อุณหภูมิ';

  @override
  String get sensorAdd => 'เพิ่มเซนเซอร์';

  @override
  String get sensorName => 'ชื่อ';

  @override
  String get sensorLocation => 'ตำแหน่ง';

  @override
  String get sensorKind => 'ประเภท';

  @override
  String get sensorManual => 'บันทึกเอง';

  @override
  String get sensorBluetooth => 'บลูทูธ (ยังไม่รองรับ)';

  @override
  String get sensorWifi => 'Wi-Fi (ยังไม่รองรับ)';

  @override
  String get sensorMin => 'ต่ำสุด (°C)';

  @override
  String get sensorMax => 'สูงสุด (°C)';

  @override
  String get sensorTarget => 'เป้าหมาย (°C)';

  @override
  String get sensorThresholdHelper => 'อุณหภูมิที่เหมาะสมต่างกันตามชนิดและระยะ กรุณาตั้งค่าตามการเลี้ยงของคุณ';

  @override
  String get settingsSuppressions => 'ประเภทคำแนะนำที่ปิดไว้';

  @override
  String get suppressionAllBeetles => 'ด้วงทั้งหมด';

  @override
  String get settingsBackup => 'สำรองและกู้คืน';

  @override
  String get backupExport => 'ส่งออกข้อมูลสำรอง';

  @override
  String get backupExportHelper => 'รวมบันทึกและรูปทั้งหมด ไม่รวมโทเค็น';

  @override
  String get backupImport => 'กู้คืนจากข้อมูลสำรอง';

  @override
  String get backupRestoreConfirm => 'ข้อมูลสำรองจะถูกรวมตาม ID: บันทึกใหม่จะถูกเพิ่ม และการแก้ไขที่ใหม่กว่าจะแทนที่ของเก่า ไม่มีข้อมูลซ้ำ ดำเนินการต่อ?';

  @override
  String backupRestored(int inserted, int skipped, int updated) {
    return 'กู้คืนแล้ว: เพิ่ม $inserted อัปเดต $updated ข้าม $skipped';
  }

  @override
  String get backupErrorNotBackup => 'ไม่ใช่ไฟล์สำรองที่ถูกต้อง';

  @override
  String get backupErrorVersion => 'ไม่รองรับเวอร์ชันข้อมูลสำรองนี้ (อาจมาจากแอปเวอร์ชันใหม่กว่า)';

  @override
  String get backupErrorCorrupted => 'ข้อมูลสำรองเสียหาย (ตรวจสอบความสมบูรณ์ไม่ผ่าน)';

  @override
  String get backupErrorAlready => 'ข้อมูลสำรองนี้ถูกกู้คืนไปแล้ว';

  @override
  String backupErrorConflict(String codes) {
    return 'รหัสซ้ำ: $codes มีบันทึกอื่นที่ใช้รหัสเดียวกันในเครื่องนี้ ไม่มีการเปลี่ยนแปลงใด ๆ';
  }

  @override
  String get settingsAiMemory => 'หน่วยความจำ AI';

  @override
  String get aiMemoryEmpty => 'ยังไม่มีผลวิเคราะห์ AI';

  @override
  String get aiMemoryDeleteAll => 'ลบผลวิเคราะห์ AI ทั้งหมด';

  @override
  String get aiMemoryDeleteConfirm => 'ลบเฉพาะผลวิเคราะห์ที่ AI สร้าง บันทึกการเลี้ยงไม่ได้รับผลกระทบ';

  @override
  String get aiMemoryOutcome => 'ผลของการคาดการณ์';

  @override
  String get outcomeNotApplicable => 'ไม่เกี่ยวข้อง';

  @override
  String get outcomePending => 'รอตรวจสอบ';

  @override
  String get outcomeCorrect => 'ถูกต้อง';

  @override
  String get outcomeIncorrect => 'ไม่ถูกต้อง';

  @override
  String get aiMemoryQuestion => 'คำถาม';

  @override
  String get settingsPrivacy => 'ความเป็นส่วนตัว';

  @override
  String get privacyBody => 'ข้อมูลทั้งหมดอยู่ในเครื่องนี้ ไม่ต้องมีบัญชี ไม่มีการเก็บสถิติ ข้อมูลจะถูกส่งไปยังเกตเวย์ Mac ของคุณเท่านั้นหลังจากคุณยินยอม และไม่ส่งไปยังคลาวด์';

  @override
  String get settingsAbout => 'เกี่ยวกับ';

  @override
  String aboutVersion(String version) {
    return 'เวอร์ชัน $version';
  }

  @override
  String get parentsSection => 'พ่อแม่พันธุ์';

  @override
  String get parentsHint => 'เลือกด้วงในรายการของคุณ หรือกรอกข้อมูลพ่อแม่ที่ไม่ได้เลี้ยงไว้ที่นี่';

  @override
  String get fieldSire => 'พ่อพันธุ์';

  @override
  String get fieldDam => 'แม่พันธุ์';

  @override
  String get parentNotInCollection => 'ไม่อยู่ในรายการ';

  @override
  String get fieldSireNote => 'ข้อมูลพ่อพันธุ์';

  @override
  String get fieldDamNote => 'ข้อมูลแม่พันธุ์';

  @override
  String get parentNoteHelper => 'เช่น WD 150 มม. กวาเดอลูป';

  @override
  String get parentUnknown => 'ไม่ได้บันทึก';

  @override
  String offspringSection(int count) {
    return 'ลูก ($count)';
  }

  @override
  String get parentErrorSelf => 'ด้วงเป็นพ่อแม่ของตัวเองไม่ได้';

  @override
  String get parentErrorSame => 'พ่อและแม่ต้องเป็นคนละตัว';

  @override
  String get parentErrorNotFound => 'ไม่พบพ่อแม่ที่เลือก';

  @override
  String get parentErrorWrongSex => 'พ่อต้องเป็นเพศผู้ และแม่ต้องเป็นเพศเมีย';

  @override
  String get parentErrorCycle => 'จะทำให้ด้วงเป็นบรรพบุรุษของตัวเอง';

  @override
  String get parentErrorSexConflict => 'ด้วงตัวนี้มีลูกในฐานะพ่อ/แม่อีกฝ่ายแล้ว จึงเปลี่ยนเป็นเพศนี้ไม่ได้';
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In zh, this message translates to:
  /// **'甲虫饲养助手'**
  String get appTitle;

  /// No description provided for @navDashboard.
  ///
  /// In zh, this message translates to:
  /// **'首页'**
  String get navDashboard;

  /// No description provided for @navBeetles.
  ///
  /// In zh, this message translates to:
  /// **'甲虫'**
  String get navBeetles;

  /// No description provided for @navRecords.
  ///
  /// In zh, this message translates to:
  /// **'记录'**
  String get navRecords;

  /// No description provided for @navAssistant.
  ///
  /// In zh, this message translates to:
  /// **'AI 助手'**
  String get navAssistant;

  /// No description provided for @navReminders.
  ///
  /// In zh, this message translates to:
  /// **'提醒'**
  String get navReminders;

  /// No description provided for @navAnalytics.
  ///
  /// In zh, this message translates to:
  /// **'分析'**
  String get navAnalytics;

  /// No description provided for @navSettings.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get navSettings;

  /// No description provided for @commonSave.
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In zh, this message translates to:
  /// **'编辑'**
  String get commonEdit;

  /// No description provided for @commonConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确认'**
  String get commonConfirm;

  /// No description provided for @commonRetry.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get commonRetry;

  /// No description provided for @commonClose.
  ///
  /// In zh, this message translates to:
  /// **'关闭'**
  String get commonClose;

  /// No description provided for @commonAdd.
  ///
  /// In zh, this message translates to:
  /// **'添加'**
  String get commonAdd;

  /// No description provided for @commonAll.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get commonAll;

  /// No description provided for @commonNone.
  ///
  /// In zh, this message translates to:
  /// **'无'**
  String get commonNone;

  /// No description provided for @commonOptional.
  ///
  /// In zh, this message translates to:
  /// **'可选'**
  String get commonOptional;

  /// No description provided for @commonRequired.
  ///
  /// In zh, this message translates to:
  /// **'必填'**
  String get commonRequired;

  /// No description provided for @commonInvalidNumber.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效的数字'**
  String get commonInvalidNumber;

  /// No description provided for @commonMustBePositive.
  ///
  /// In zh, this message translates to:
  /// **'必须大于 0'**
  String get commonMustBePositive;

  /// No description provided for @commonErrorTitle.
  ///
  /// In zh, this message translates to:
  /// **'出错了'**
  String get commonErrorTitle;

  /// No description provided for @commonSaved.
  ///
  /// In zh, this message translates to:
  /// **'已保存'**
  String get commonSaved;

  /// No description provided for @commonNotes.
  ///
  /// In zh, this message translates to:
  /// **'备注'**
  String get commonNotes;

  /// No description provided for @commonDateTime.
  ///
  /// In zh, this message translates to:
  /// **'时间'**
  String get commonDateTime;

  /// No description provided for @commonDeleteConfirmTitle.
  ///
  /// In zh, this message translates to:
  /// **'确认删除？'**
  String get commonDeleteConfirmTitle;

  /// No description provided for @commonDeleteRecordMessage.
  ///
  /// In zh, this message translates to:
  /// **'该记录会被标记为已删除（保留审计痕迹），甲虫的当前状态会回退到上一条记录。'**
  String get commonDeleteRecordMessage;

  /// No description provided for @commonNotSet.
  ///
  /// In zh, this message translates to:
  /// **'未设定'**
  String get commonNotSet;

  /// No description provided for @sexMale.
  ///
  /// In zh, this message translates to:
  /// **'公'**
  String get sexMale;

  /// No description provided for @sexFemale.
  ///
  /// In zh, this message translates to:
  /// **'母'**
  String get sexFemale;

  /// No description provided for @sexUnknown.
  ///
  /// In zh, this message translates to:
  /// **'未知'**
  String get sexUnknown;

  /// No description provided for @stageL1.
  ///
  /// In zh, this message translates to:
  /// **'L1 幼虫'**
  String get stageL1;

  /// No description provided for @stageL2.
  ///
  /// In zh, this message translates to:
  /// **'L2 幼虫'**
  String get stageL2;

  /// No description provided for @stageL3.
  ///
  /// In zh, this message translates to:
  /// **'L3 幼虫'**
  String get stageL3;

  /// No description provided for @stagePrepupa.
  ///
  /// In zh, this message translates to:
  /// **'预蛹'**
  String get stagePrepupa;

  /// No description provided for @stagePupa.
  ///
  /// In zh, this message translates to:
  /// **'蛹'**
  String get stagePupa;

  /// No description provided for @stageAdult.
  ///
  /// In zh, this message translates to:
  /// **'成虫'**
  String get stageAdult;

  /// No description provided for @stageUnset.
  ///
  /// In zh, this message translates to:
  /// **'阶段未记录'**
  String get stageUnset;

  /// No description provided for @l3Early.
  ///
  /// In zh, this message translates to:
  /// **'前期'**
  String get l3Early;

  /// No description provided for @l3Middle.
  ///
  /// In zh, this message translates to:
  /// **'中期'**
  String get l3Middle;

  /// No description provided for @l3Late.
  ///
  /// In zh, this message translates to:
  /// **'后期'**
  String get l3Late;

  /// No description provided for @statusActive.
  ///
  /// In zh, this message translates to:
  /// **'饲养中'**
  String get statusActive;

  /// No description provided for @statusDeceased.
  ///
  /// In zh, this message translates to:
  /// **'已死亡'**
  String get statusDeceased;

  /// No description provided for @statusTransferred.
  ///
  /// In zh, this message translates to:
  /// **'已转让'**
  String get statusTransferred;

  /// No description provided for @statusArchived.
  ///
  /// In zh, this message translates to:
  /// **'已归档'**
  String get statusArchived;

  /// No description provided for @obsGeneral.
  ///
  /// In zh, this message translates to:
  /// **'一般'**
  String get obsGeneral;

  /// No description provided for @obsColorChange.
  ///
  /// In zh, this message translates to:
  /// **'体色变化'**
  String get obsColorChange;

  /// No description provided for @obsActivity.
  ///
  /// In zh, this message translates to:
  /// **'活动'**
  String get obsActivity;

  /// No description provided for @obsFeeding.
  ///
  /// In zh, this message translates to:
  /// **'进食'**
  String get obsFeeding;

  /// No description provided for @obsPupalChamber.
  ///
  /// In zh, this message translates to:
  /// **'蛹室'**
  String get obsPupalChamber;

  /// No description provided for @obsMolt.
  ///
  /// In zh, this message translates to:
  /// **'蜕皮'**
  String get obsMolt;

  /// No description provided for @obsHealth.
  ///
  /// In zh, this message translates to:
  /// **'健康'**
  String get obsHealth;

  /// No description provided for @obsBehavior.
  ///
  /// In zh, this message translates to:
  /// **'行为'**
  String get obsBehavior;

  /// No description provided for @reminderStatusSuggested.
  ///
  /// In zh, this message translates to:
  /// **'待确认'**
  String get reminderStatusSuggested;

  /// No description provided for @reminderStatusConfirmed.
  ///
  /// In zh, this message translates to:
  /// **'已确认'**
  String get reminderStatusConfirmed;

  /// No description provided for @reminderStatusScheduled.
  ///
  /// In zh, this message translates to:
  /// **'已安排'**
  String get reminderStatusScheduled;

  /// No description provided for @reminderStatusCompleted.
  ///
  /// In zh, this message translates to:
  /// **'已完成'**
  String get reminderStatusCompleted;

  /// No description provided for @reminderStatusCancelled.
  ///
  /// In zh, this message translates to:
  /// **'已取消'**
  String get reminderStatusCancelled;

  /// No description provided for @reminderStatusExpired.
  ///
  /// In zh, this message translates to:
  /// **'已过期'**
  String get reminderStatusExpired;

  /// No description provided for @severityInfo.
  ///
  /// In zh, this message translates to:
  /// **'信息'**
  String get severityInfo;

  /// No description provided for @severityObservation.
  ///
  /// In zh, this message translates to:
  /// **'观察'**
  String get severityObservation;

  /// No description provided for @severityWarning.
  ///
  /// In zh, this message translates to:
  /// **'注意'**
  String get severityWarning;

  /// No description provided for @severityAlert.
  ///
  /// In zh, this message translates to:
  /// **'警报'**
  String get severityAlert;

  /// No description provided for @confidenceLabel.
  ///
  /// In zh, this message translates to:
  /// **'置信度：{level}'**
  String confidenceLabel(String level);

  /// No description provided for @confidenceLow.
  ///
  /// In zh, this message translates to:
  /// **'低'**
  String get confidenceLow;

  /// No description provided for @confidenceMedium.
  ///
  /// In zh, this message translates to:
  /// **'中'**
  String get confidenceMedium;

  /// No description provided for @confidenceHigh.
  ///
  /// In zh, this message translates to:
  /// **'高'**
  String get confidenceHigh;

  /// No description provided for @basisMeasured.
  ///
  /// In zh, this message translates to:
  /// **'实测超限'**
  String get basisMeasured;

  /// No description provided for @basisCalculated.
  ///
  /// In zh, this message translates to:
  /// **'计算结果'**
  String get basisCalculated;

  /// No description provided for @basisAiInference.
  ///
  /// In zh, this message translates to:
  /// **'AI 推测'**
  String get basisAiInference;

  /// No description provided for @sourceUser.
  ///
  /// In zh, this message translates to:
  /// **'用户创建'**
  String get sourceUser;

  /// No description provided for @sourceRule.
  ///
  /// In zh, this message translates to:
  /// **'规则检测'**
  String get sourceRule;

  /// No description provided for @sourceAi.
  ///
  /// In zh, this message translates to:
  /// **'AI 建议'**
  String get sourceAi;

  /// No description provided for @recordWeight.
  ///
  /// In zh, this message translates to:
  /// **'体重'**
  String get recordWeight;

  /// No description provided for @recordObservation.
  ///
  /// In zh, this message translates to:
  /// **'观察'**
  String get recordObservation;

  /// No description provided for @recordSubstrate.
  ///
  /// In zh, this message translates to:
  /// **'换土'**
  String get recordSubstrate;

  /// No description provided for @recordContainer.
  ///
  /// In zh, this message translates to:
  /// **'换盒'**
  String get recordContainer;

  /// No description provided for @recordLifeStage.
  ///
  /// In zh, this message translates to:
  /// **'阶段变化'**
  String get recordLifeStage;

  /// No description provided for @recordTemperature.
  ///
  /// In zh, this message translates to:
  /// **'温度'**
  String get recordTemperature;

  /// No description provided for @eventSignificantWeightChange.
  ///
  /// In zh, this message translates to:
  /// **'体重显著变化'**
  String get eventSignificantWeightChange;

  /// No description provided for @eventWeightLoss.
  ///
  /// In zh, this message translates to:
  /// **'体重下降'**
  String get eventWeightLoss;

  /// No description provided for @eventMeasurementOverdue.
  ///
  /// In zh, this message translates to:
  /// **'长时间未称重'**
  String get eventMeasurementOverdue;

  /// No description provided for @eventSubstrateInspection.
  ///
  /// In zh, this message translates to:
  /// **'检查/更换土'**
  String get eventSubstrateInspection;

  /// No description provided for @eventContainerReview.
  ///
  /// In zh, this message translates to:
  /// **'评估容器'**
  String get eventContainerReview;

  /// No description provided for @eventTemperatureOutOfRange.
  ///
  /// In zh, this message translates to:
  /// **'温度超出范围'**
  String get eventTemperatureOutOfRange;

  /// No description provided for @eventPossiblePrepupa.
  ///
  /// In zh, this message translates to:
  /// **'可能进入预蛹'**
  String get eventPossiblePrepupa;

  /// No description provided for @eventPossiblePupation.
  ///
  /// In zh, this message translates to:
  /// **'可能化蛹'**
  String get eventPossiblePupation;

  /// No description provided for @eventExpectedEmergenceWindow.
  ///
  /// In zh, this message translates to:
  /// **'预期羽化窗口'**
  String get eventExpectedEmergenceWindow;

  /// No description provided for @eventOutdatedReminder.
  ///
  /// In zh, this message translates to:
  /// **'过期提醒'**
  String get eventOutdatedReminder;

  /// No description provided for @eventGeneralObservation.
  ///
  /// In zh, this message translates to:
  /// **'一般观察'**
  String get eventGeneralObservation;

  /// No description provided for @eventCustom.
  ///
  /// In zh, this message translates to:
  /// **'自定义'**
  String get eventCustom;

  /// No description provided for @dashboardActiveBeetles.
  ///
  /// In zh, this message translates to:
  /// **'饲养中'**
  String get dashboardActiveBeetles;

  /// No description provided for @dashboardPendingSuggestions.
  ///
  /// In zh, this message translates to:
  /// **'待确认建议'**
  String get dashboardPendingSuggestions;

  /// No description provided for @dashboardUpcoming.
  ///
  /// In zh, this message translates to:
  /// **'即将到来的提醒'**
  String get dashboardUpcoming;

  /// No description provided for @dashboardRecent.
  ///
  /// In zh, this message translates to:
  /// **'最近记录'**
  String get dashboardRecent;

  /// No description provided for @dashboardEmptyTitle.
  ///
  /// In zh, this message translates to:
  /// **'还没有甲虫'**
  String get dashboardEmptyTitle;

  /// No description provided for @dashboardEmptyBody.
  ///
  /// In zh, this message translates to:
  /// **'添加第一只甲虫，开始记录它的成长。'**
  String get dashboardEmptyBody;

  /// No description provided for @dashboardAddBeetle.
  ///
  /// In zh, this message translates to:
  /// **'添加甲虫'**
  String get dashboardAddBeetle;

  /// No description provided for @dashboardBySpecies.
  ///
  /// In zh, this message translates to:
  /// **'按种类'**
  String get dashboardBySpecies;

  /// No description provided for @dashboardByStage.
  ///
  /// In zh, this message translates to:
  /// **'按阶段'**
  String get dashboardByStage;

  /// No description provided for @dashboardNoUpcoming.
  ///
  /// In zh, this message translates to:
  /// **'暂无提醒'**
  String get dashboardNoUpcoming;

  /// No description provided for @dashboardTemperatureAlert.
  ///
  /// In zh, this message translates to:
  /// **'{sensor}：{celsius}°C 超出你设定的范围'**
  String dashboardTemperatureAlert(String celsius, String sensor);

  /// No description provided for @dashboardReviewSuggestions.
  ///
  /// In zh, this message translates to:
  /// **'查看'**
  String get dashboardReviewSuggestions;

  /// No description provided for @beetlesSearchHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索编号或备注'**
  String get beetlesSearchHint;

  /// No description provided for @beetlesEmpty.
  ///
  /// In zh, this message translates to:
  /// **'没有符合条件的甲虫'**
  String get beetlesEmpty;

  /// No description provided for @filterSpecies.
  ///
  /// In zh, this message translates to:
  /// **'种类'**
  String get filterSpecies;

  /// No description provided for @filterSex.
  ///
  /// In zh, this message translates to:
  /// **'性别'**
  String get filterSex;

  /// No description provided for @filterStage.
  ///
  /// In zh, this message translates to:
  /// **'阶段'**
  String get filterStage;

  /// No description provided for @filterStatus.
  ///
  /// In zh, this message translates to:
  /// **'状态'**
  String get filterStatus;

  /// No description provided for @beetleFormNewTitle.
  ///
  /// In zh, this message translates to:
  /// **'新增甲虫'**
  String get beetleFormNewTitle;

  /// No description provided for @beetleFormEditTitle.
  ///
  /// In zh, this message translates to:
  /// **'编辑甲虫'**
  String get beetleFormEditTitle;

  /// No description provided for @fieldCode.
  ///
  /// In zh, this message translates to:
  /// **'编号'**
  String get fieldCode;

  /// No description provided for @fieldCodeHelper.
  ///
  /// In zh, this message translates to:
  /// **'例如 DHH-001'**
  String get fieldCodeHelper;

  /// No description provided for @fieldCodeInvalid.
  ///
  /// In zh, this message translates to:
  /// **'格式应为 种类代码-编号，例如 DHH-001'**
  String get fieldCodeInvalid;

  /// No description provided for @fieldCodeDuplicate.
  ///
  /// In zh, this message translates to:
  /// **'编号 {code} 已存在'**
  String fieldCodeDuplicate(String code);

  /// No description provided for @fieldSpecies.
  ///
  /// In zh, this message translates to:
  /// **'种类'**
  String get fieldSpecies;

  /// No description provided for @fieldSex.
  ///
  /// In zh, this message translates to:
  /// **'性别'**
  String get fieldSex;

  /// No description provided for @fieldStatus.
  ///
  /// In zh, this message translates to:
  /// **'状态'**
  String get fieldStatus;

  /// No description provided for @fieldAcquiredAt.
  ///
  /// In zh, this message translates to:
  /// **'入手日期'**
  String get fieldAcquiredAt;

  /// No description provided for @fieldHatchDate.
  ///
  /// In zh, this message translates to:
  /// **'孵化日期'**
  String get fieldHatchDate;

  /// No description provided for @fieldEstimatedHatchDate.
  ///
  /// In zh, this message translates to:
  /// **'估计孵化日期'**
  String get fieldEstimatedHatchDate;

  /// No description provided for @fieldHatchUncertainty.
  ///
  /// In zh, this message translates to:
  /// **'估计误差（± 天）'**
  String get fieldHatchUncertainty;

  /// No description provided for @fieldStage.
  ///
  /// In zh, this message translates to:
  /// **'当前阶段'**
  String get fieldStage;

  /// No description provided for @fieldL3Phase.
  ///
  /// In zh, this message translates to:
  /// **'L3 细分（观察标签）'**
  String get fieldL3Phase;

  /// No description provided for @fieldWeight.
  ///
  /// In zh, this message translates to:
  /// **'当前体重（克）'**
  String get fieldWeight;

  /// No description provided for @fieldContainer.
  ///
  /// In zh, this message translates to:
  /// **'容器容量（升）'**
  String get fieldContainer;

  /// No description provided for @fieldSubstrateType.
  ///
  /// In zh, this message translates to:
  /// **'土的类型'**
  String get fieldSubstrateType;

  /// No description provided for @fieldSubstrateBrand.
  ///
  /// In zh, this message translates to:
  /// **'土的品牌'**
  String get fieldSubstrateBrand;

  /// No description provided for @fieldSensor.
  ///
  /// In zh, this message translates to:
  /// **'温度传感器'**
  String get fieldSensor;

  /// No description provided for @fieldBreedingNotes.
  ///
  /// In zh, this message translates to:
  /// **'饲养备注'**
  String get fieldBreedingNotes;

  /// No description provided for @beetleFormInitialSection.
  ///
  /// In zh, this message translates to:
  /// **'初始记录（保存为历史事件）'**
  String get beetleFormInitialSection;

  /// No description provided for @beetleFormStageHint.
  ///
  /// In zh, this message translates to:
  /// **'阶段只根据你的记录设置，不会根据体重推断。'**
  String get beetleFormStageHint;

  /// No description provided for @beetleFormHistoryHint.
  ///
  /// In zh, this message translates to:
  /// **'体重、容器、土和阶段的后续变化请在详情页添加记录。'**
  String get beetleFormHistoryHint;

  /// No description provided for @detailOverview.
  ///
  /// In zh, this message translates to:
  /// **'概览'**
  String get detailOverview;

  /// No description provided for @detailGrowth.
  ///
  /// In zh, this message translates to:
  /// **'成长曲线'**
  String get detailGrowth;

  /// No description provided for @detailHistory.
  ///
  /// In zh, this message translates to:
  /// **'历史记录'**
  String get detailHistory;

  /// No description provided for @detailPhotos.
  ///
  /// In zh, this message translates to:
  /// **'照片'**
  String get detailPhotos;

  /// No description provided for @detailReminders.
  ///
  /// In zh, this message translates to:
  /// **'提醒'**
  String get detailReminders;

  /// No description provided for @detailAiAnalyses.
  ///
  /// In zh, this message translates to:
  /// **'AI 分析记录'**
  String get detailAiAnalyses;

  /// No description provided for @detailAddPhoto.
  ///
  /// In zh, this message translates to:
  /// **'添加照片'**
  String get detailAddPhoto;

  /// No description provided for @detailNoPhotos.
  ///
  /// In zh, this message translates to:
  /// **'暂无照片'**
  String get detailNoPhotos;

  /// No description provided for @detailNoHistory.
  ///
  /// In zh, this message translates to:
  /// **'暂无记录'**
  String get detailNoHistory;

  /// No description provided for @detailAiInterpret.
  ///
  /// In zh, this message translates to:
  /// **'AI 解读近况'**
  String get detailAiInterpret;

  /// No description provided for @detailAiInterpretDone.
  ///
  /// In zh, this message translates to:
  /// **'AI 生成了 {n} 条建议，已放入待确认列表'**
  String detailAiInterpretDone(int n);

  /// No description provided for @detailAiInterpretRejected.
  ///
  /// In zh, this message translates to:
  /// **'{n} 条 AI 输出未通过校验，已丢弃'**
  String detailAiInterpretRejected(int n);

  /// No description provided for @detailLatestWeight.
  ///
  /// In zh, this message translates to:
  /// **'最新体重'**
  String get detailLatestWeight;

  /// No description provided for @detailMaxWeight.
  ///
  /// In zh, this message translates to:
  /// **'历史最高'**
  String get detailMaxWeight;

  /// No description provided for @detailChangeSincePrevious.
  ///
  /// In zh, this message translates to:
  /// **'较上次'**
  String get detailChangeSincePrevious;

  /// No description provided for @detailAvgWeekly.
  ///
  /// In zh, this message translates to:
  /// **'平均每周'**
  String get detailAvgWeekly;

  /// No description provided for @detailNeedTwoWeights.
  ///
  /// In zh, this message translates to:
  /// **'至少需要两次称重才能计算变化'**
  String get detailNeedTwoWeights;

  /// No description provided for @detailHatch.
  ///
  /// In zh, this message translates to:
  /// **'孵化'**
  String get detailHatch;

  /// No description provided for @detailEstimatedHatch.
  ///
  /// In zh, this message translates to:
  /// **'约 {date}（±{days} 天）'**
  String detailEstimatedHatch(String date, int days);

  /// No description provided for @detailAcquired.
  ///
  /// In zh, this message translates to:
  /// **'入手'**
  String get detailAcquired;

  /// No description provided for @detailContainer.
  ///
  /// In zh, this message translates to:
  /// **'容器'**
  String get detailContainer;

  /// No description provided for @detailSubstrate.
  ///
  /// In zh, this message translates to:
  /// **'土'**
  String get detailSubstrate;

  /// No description provided for @detailChangeStatus.
  ///
  /// In zh, this message translates to:
  /// **'更改状态'**
  String get detailChangeStatus;

  /// No description provided for @detailAvgNote.
  ///
  /// In zh, this message translates to:
  /// **'平均值只反映首末两次记录，生长并非线性。'**
  String get detailAvgNote;

  /// No description provided for @recordsEmpty.
  ///
  /// In zh, this message translates to:
  /// **'暂无记录'**
  String get recordsEmpty;

  /// No description provided for @recordsAdd.
  ///
  /// In zh, this message translates to:
  /// **'添加记录'**
  String get recordsAdd;

  /// No description provided for @chooseRecordType.
  ///
  /// In zh, this message translates to:
  /// **'选择记录类型'**
  String get chooseRecordType;

  /// No description provided for @chooseBeetle.
  ///
  /// In zh, this message translates to:
  /// **'选择甲虫'**
  String get chooseBeetle;

  /// No description provided for @weightGrams.
  ///
  /// In zh, this message translates to:
  /// **'体重（克）'**
  String get weightGrams;

  /// No description provided for @weightDisturbWarning.
  ///
  /// In zh, this message translates to:
  /// **'该个体当前记录为预蛹或蛹。此阶段翻动和称重可能造成伤害。'**
  String get weightDisturbWarning;

  /// No description provided for @observationCategory.
  ///
  /// In zh, this message translates to:
  /// **'类别'**
  String get observationCategory;

  /// No description provided for @observationDescription.
  ///
  /// In zh, this message translates to:
  /// **'描述'**
  String get observationDescription;

  /// No description provided for @substrateQuantity.
  ///
  /// In zh, this message translates to:
  /// **'用量（升）'**
  String get substrateQuantity;

  /// No description provided for @substrateBatch.
  ///
  /// In zh, this message translates to:
  /// **'批次'**
  String get substrateBatch;

  /// No description provided for @weightDuringChange.
  ///
  /// In zh, this message translates to:
  /// **'更换时体重（克）'**
  String get weightDuringChange;

  /// No description provided for @observedCondition.
  ///
  /// In zh, this message translates to:
  /// **'观察到的状况'**
  String get observedCondition;

  /// No description provided for @nextPlannedAt.
  ///
  /// In zh, this message translates to:
  /// **'下次计划检查/换土'**
  String get nextPlannedAt;

  /// No description provided for @containerPrevious.
  ///
  /// In zh, this message translates to:
  /// **'原容器（升，留空则取上次记录）'**
  String get containerPrevious;

  /// No description provided for @containerNew.
  ///
  /// In zh, this message translates to:
  /// **'新容器（升）'**
  String get containerNew;

  /// No description provided for @stageNew.
  ///
  /// In zh, this message translates to:
  /// **'新阶段'**
  String get stageNew;

  /// No description provided for @stageIsEstimated.
  ///
  /// In zh, this message translates to:
  /// **'日期为估计值'**
  String get stageIsEstimated;

  /// No description provided for @temperatureCelsius.
  ///
  /// In zh, this message translates to:
  /// **'温度（°C）'**
  String get temperatureCelsius;

  /// No description provided for @noSensors.
  ///
  /// In zh, this message translates to:
  /// **'请先在设置中添加温度传感器'**
  String get noSensors;

  /// No description provided for @noBeetles.
  ///
  /// In zh, this message translates to:
  /// **'请先添加甲虫'**
  String get noBeetles;

  /// No description provided for @addPhotos.
  ///
  /// In zh, this message translates to:
  /// **'添加照片'**
  String get addPhotos;

  /// No description provided for @photosSelected.
  ///
  /// In zh, this message translates to:
  /// **'已选 {n} 张照片'**
  String photosSelected(int n);

  /// No description provided for @photoFromCamera.
  ///
  /// In zh, this message translates to:
  /// **'拍照'**
  String get photoFromCamera;

  /// No description provided for @photoFromGallery.
  ///
  /// In zh, this message translates to:
  /// **'从相册选择'**
  String get photoFromGallery;

  /// No description provided for @suggestionsCreated.
  ///
  /// In zh, this message translates to:
  /// **'已保存。生成了 {n} 条待确认建议'**
  String suggestionsCreated(int n);

  /// No description provided for @remindersTabSuggested.
  ///
  /// In zh, this message translates to:
  /// **'待确认'**
  String get remindersTabSuggested;

  /// No description provided for @remindersTabUpcoming.
  ///
  /// In zh, this message translates to:
  /// **'已确认'**
  String get remindersTabUpcoming;

  /// No description provided for @remindersTabHistory.
  ///
  /// In zh, this message translates to:
  /// **'历史'**
  String get remindersTabHistory;

  /// No description provided for @remindersEmptySuggested.
  ///
  /// In zh, this message translates to:
  /// **'没有待确认的建议'**
  String get remindersEmptySuggested;

  /// No description provided for @remindersEmptyUpcoming.
  ///
  /// In zh, this message translates to:
  /// **'没有已确认的提醒'**
  String get remindersEmptyUpcoming;

  /// No description provided for @remindersEmptyHistory.
  ///
  /// In zh, this message translates to:
  /// **'暂无历史'**
  String get remindersEmptyHistory;

  /// No description provided for @reminderNew.
  ///
  /// In zh, this message translates to:
  /// **'新建提醒'**
  String get reminderNew;

  /// No description provided for @reminderTitleField.
  ///
  /// In zh, this message translates to:
  /// **'标题'**
  String get reminderTitleField;

  /// No description provided for @reminderMessageField.
  ///
  /// In zh, this message translates to:
  /// **'内容'**
  String get reminderMessageField;

  /// No description provided for @reminderDueAt.
  ///
  /// In zh, this message translates to:
  /// **'提醒时间'**
  String get reminderDueAt;

  /// No description provided for @reminderBeetleOptional.
  ///
  /// In zh, this message translates to:
  /// **'关联甲虫（可选）'**
  String get reminderBeetleOptional;

  /// No description provided for @reminderAccept.
  ///
  /// In zh, this message translates to:
  /// **'接受'**
  String get reminderAccept;

  /// No description provided for @reminderReject.
  ///
  /// In zh, this message translates to:
  /// **'拒绝'**
  String get reminderReject;

  /// No description provided for @reminderPostpone.
  ///
  /// In zh, this message translates to:
  /// **'推迟'**
  String get reminderPostpone;

  /// No description provided for @reminderPostponeDays.
  ///
  /// In zh, this message translates to:
  /// **'推迟 {days} 天'**
  String reminderPostponeDays(int days);

  /// No description provided for @reminderDisableSimilar.
  ///
  /// In zh, this message translates to:
  /// **'不再提示类似建议'**
  String get reminderDisableSimilar;

  /// No description provided for @reminderDisableSimilarConfirm.
  ///
  /// In zh, this message translates to:
  /// **'将不再生成此类建议（{event}）。可在设置中恢复。'**
  String reminderDisableSimilarConfirm(String event);

  /// No description provided for @reminderComplete.
  ///
  /// In zh, this message translates to:
  /// **'完成'**
  String get reminderComplete;

  /// No description provided for @reminderCancel.
  ///
  /// In zh, this message translates to:
  /// **'取消提醒'**
  String get reminderCancel;

  /// No description provided for @reminderReason.
  ///
  /// In zh, this message translates to:
  /// **'原因'**
  String get reminderReason;

  /// No description provided for @reminderRecommendation.
  ///
  /// In zh, this message translates to:
  /// **'建议'**
  String get reminderRecommendation;

  /// No description provided for @reminderEvidence.
  ///
  /// In zh, this message translates to:
  /// **'依据 {n} 条记录'**
  String reminderEvidence(int n);

  /// No description provided for @reminderNeedsConfirmation.
  ///
  /// In zh, this message translates to:
  /// **'只有你确认后才会安排通知'**
  String get reminderNeedsConfirmation;

  /// No description provided for @reminderReview.
  ///
  /// In zh, this message translates to:
  /// **'确认提醒'**
  String get reminderReview;

  /// No description provided for @reminderAcceptEdited.
  ///
  /// In zh, this message translates to:
  /// **'接受（含修改）'**
  String get reminderAcceptEdited;

  /// No description provided for @notificationsDenied.
  ///
  /// In zh, this message translates to:
  /// **'通知权限未开启：提醒已保存，但不会弹出系统通知。'**
  String get notificationsDenied;

  /// No description provided for @notificationsRationale.
  ///
  /// In zh, this message translates to:
  /// **'为了在设定时间提醒你，需要通知权限。'**
  String get notificationsRationale;

  /// No description provided for @remindersDeferred.
  ///
  /// In zh, this message translates to:
  /// **'{n} 个较远的提醒会在临近时安排（系统通知数量限制）'**
  String remindersDeferred(int n);

  /// No description provided for @remindersInexact.
  ///
  /// In zh, this message translates to:
  /// **'未授予精确闹钟权限，通知时间可能略有延迟。'**
  String get remindersInexact;

  /// No description provided for @reminderOverdue.
  ///
  /// In zh, this message translates to:
  /// **'已逾期'**
  String get reminderOverdue;

  /// No description provided for @ruleWeightChangeTitle.
  ///
  /// In zh, this message translates to:
  /// **'{code} 体重变化 {percent}%'**
  String ruleWeightChangeTitle(String code, String percent);

  /// No description provided for @ruleWeightChangeMessage.
  ///
  /// In zh, this message translates to:
  /// **'复查 {code} 的体重与状态。'**
  String ruleWeightChangeMessage(String code);

  /// No description provided for @ruleWeightChangeReason.
  ///
  /// In zh, this message translates to:
  /// **'最近两次记录的体重从 {from} g 变为 {to} g（{percent}%）。'**
  String ruleWeightChangeReason(String from, String percent, String to);

  /// No description provided for @ruleWeightLossRecommendation.
  ///
  /// In zh, this message translates to:
  /// **'一周后复称，并检查土和温度。L3 后期体重下降可能与准备化蛹有关，也可能另有原因；请避免频繁翻动。'**
  String get ruleWeightLossRecommendation;

  /// No description provided for @ruleWeightGainRecommendation.
  ///
  /// In zh, this message translates to:
  /// **'按常规继续记录即可。'**
  String get ruleWeightGainRecommendation;

  /// No description provided for @ruleOverdueTitle.
  ///
  /// In zh, this message translates to:
  /// **'为 {code} 称重'**
  String ruleOverdueTitle(String code);

  /// No description provided for @ruleOverdueMessage.
  ///
  /// In zh, this message translates to:
  /// **'距离上次称重已较久，可在换土时顺便称重。'**
  String get ruleOverdueMessage;

  /// No description provided for @ruleOverdueReasonDays.
  ///
  /// In zh, this message translates to:
  /// **'已有 {days} 天没有体重记录。'**
  String ruleOverdueReasonDays(int days);

  /// No description provided for @ruleOverdueReasonNever.
  ///
  /// In zh, this message translates to:
  /// **'还没有任何体重记录。'**
  String get ruleOverdueReasonNever;

  /// No description provided for @ruleOverdueRecommendation.
  ///
  /// In zh, this message translates to:
  /// **'幼虫期可在方便时称重；预蛹或蛹期请勿为称重而翻动。'**
  String get ruleOverdueRecommendation;

  /// No description provided for @ruleSubstrateTitle.
  ///
  /// In zh, this message translates to:
  /// **'检查 {code} 的土'**
  String ruleSubstrateTitle(String code);

  /// No description provided for @ruleSubstrateMessage.
  ///
  /// In zh, this message translates to:
  /// **'按计划检查土的状态。'**
  String get ruleSubstrateMessage;

  /// No description provided for @ruleSubstrateReason.
  ///
  /// In zh, this message translates to:
  /// **'距离上次换土已 {days} 天，已到你设定的计划时间。'**
  String ruleSubstrateReason(int days);

  /// No description provided for @ruleSubstrateRecommendation.
  ///
  /// In zh, this message translates to:
  /// **'先从外部观察；如有蛹室迹象，请不要更换。'**
  String get ruleSubstrateRecommendation;

  /// No description provided for @ruleTempTitle.
  ///
  /// In zh, this message translates to:
  /// **'温度超出设定：{sensor}'**
  String ruleTempTitle(String sensor);

  /// No description provided for @ruleTempMessage.
  ///
  /// In zh, this message translates to:
  /// **'{sensor} 实测 {celsius}°C。'**
  String ruleTempMessage(String celsius, String sensor);

  /// No description provided for @ruleTempReason.
  ///
  /// In zh, this message translates to:
  /// **'实测 {celsius}°C 超出你设定的范围（{range}）。这是实测值，不是 AI 预测。'**
  String ruleTempReason(String celsius, String range);

  /// No description provided for @ruleTempRecommendation.
  ///
  /// In zh, this message translates to:
  /// **'检查环境温度和温控设备。'**
  String get ruleTempRecommendation;

  /// No description provided for @rulePrepupaTitle.
  ///
  /// In zh, this message translates to:
  /// **'观察 {code} 状态'**
  String rulePrepupaTitle(String code);

  /// No description provided for @rulePrepupaMessage.
  ///
  /// In zh, this message translates to:
  /// **'检查外部可观察的变化，避免不必要的翻动。'**
  String get rulePrepupaMessage;

  /// No description provided for @rulePrepupaReason.
  ///
  /// In zh, this message translates to:
  /// **'近期记录到体色变化或蛹室相关观察，但证据不足以确认进入预蛹。'**
  String get rulePrepupaReason;

  /// No description provided for @rulePrepupaRecommendation.
  ///
  /// In zh, this message translates to:
  /// **'从外部观察，不要打扰可能存在的蛹室。'**
  String get rulePrepupaRecommendation;

  /// No description provided for @ruleEmergenceTitle.
  ///
  /// In zh, this message translates to:
  /// **'{code} 预期羽化窗口'**
  String ruleEmergenceTitle(String code);

  /// No description provided for @ruleEmergenceMessage.
  ///
  /// In zh, this message translates to:
  /// **'按你设定的蛹期（{min}–{max} 天），开始留意羽化。'**
  String ruleEmergenceMessage(int max, int min);

  /// No description provided for @ruleEmergenceReason.
  ///
  /// In zh, this message translates to:
  /// **'已记录进入蛹期；你为该种类设定的蛹期为 {min}–{max} 天。'**
  String ruleEmergenceReason(int max, int min);

  /// No description provided for @ruleEmergenceRecommendation.
  ///
  /// In zh, this message translates to:
  /// **'外部观察即可。羽化后成虫需要时间硬化，请勿过早取出。'**
  String get ruleEmergenceRecommendation;

  /// No description provided for @assistantHint.
  ///
  /// In zh, this message translates to:
  /// **'询问你的饲养记录…'**
  String get assistantHint;

  /// No description provided for @assistantEmptyTitle.
  ///
  /// In zh, this message translates to:
  /// **'问问你的饲养记录'**
  String get assistantEmptyTitle;

  /// No description provided for @assistantEmptyBody.
  ///
  /// In zh, this message translates to:
  /// **'AI 会先查询你的记录再回答，并标注哪些是记录、计算、推测或建议。'**
  String get assistantEmptyBody;

  /// No description provided for @assistantExample1.
  ///
  /// In zh, this message translates to:
  /// **'CCK-001 最近一个月生长正常吗？'**
  String get assistantExample1;

  /// No description provided for @assistantExample2.
  ///
  /// In zh, this message translates to:
  /// **'比较 DHH-001 和 DHH-002 最近三个月的成长速度。'**
  String get assistantExample2;

  /// No description provided for @assistantExample3.
  ///
  /// In zh, this message translates to:
  /// **'为什么我的幼虫最近重量下降？'**
  String get assistantExample3;

  /// No description provided for @assistantNoProvider.
  ///
  /// In zh, this message translates to:
  /// **'当前没有可用的 AI 模型，因此无法回答。记录、提醒和分析功能不受影响。'**
  String get assistantNoProvider;

  /// No description provided for @assistantProviderMac.
  ///
  /// In zh, this message translates to:
  /// **'Mac 本地 AI'**
  String get assistantProviderMac;

  /// No description provided for @assistantProviderMobile.
  ///
  /// In zh, this message translates to:
  /// **'手机本地 AI'**
  String get assistantProviderMobile;

  /// No description provided for @assistantFallback.
  ///
  /// In zh, this message translates to:
  /// **'已回退到 {provider}'**
  String assistantFallback(String provider);

  /// No description provided for @assistantConsentTitle.
  ///
  /// In zh, this message translates to:
  /// **'允许发送数据到你的 Mac？'**
  String get assistantConsentTitle;

  /// No description provided for @assistantConsentBody.
  ///
  /// In zh, this message translates to:
  /// **'回答问题时，应用会把相关饲养记录发送到你配置的 Mac AI 网关（{host}）。不会发送到任何云服务。你可以随时在设置中撤销。'**
  String assistantConsentBody(String host);

  /// No description provided for @assistantConsentPublicWarning.
  ///
  /// In zh, this message translates to:
  /// **'警告：该地址不是本机或局域网 / VPN 地址。请确认它是你自己的设备。'**
  String get assistantConsentPublicWarning;

  /// No description provided for @assistantConsentAllow.
  ///
  /// In zh, this message translates to:
  /// **'允许'**
  String get assistantConsentAllow;

  /// No description provided for @assistantEvidence.
  ///
  /// In zh, this message translates to:
  /// **'基于 {n} 条记录'**
  String assistantEvidence(int n);

  /// No description provided for @assistantToolsUsed.
  ///
  /// In zh, this message translates to:
  /// **'查询数据 {n} 次'**
  String assistantToolsUsed(int n);

  /// No description provided for @assistantReminderDraft.
  ///
  /// In zh, this message translates to:
  /// **'AI 提议的提醒（尚未创建）'**
  String get assistantReminderDraft;

  /// No description provided for @assistantReviewDraft.
  ///
  /// In zh, this message translates to:
  /// **'查看并确认'**
  String get assistantReviewDraft;

  /// No description provided for @assistantFeedbackHelpful.
  ///
  /// In zh, this message translates to:
  /// **'有帮助'**
  String get assistantFeedbackHelpful;

  /// No description provided for @assistantFeedbackNotHelpful.
  ///
  /// In zh, this message translates to:
  /// **'没帮助'**
  String get assistantFeedbackNotHelpful;

  /// No description provided for @assistantError.
  ///
  /// In zh, this message translates to:
  /// **'请求失败：{error}'**
  String assistantError(String error);

  /// No description provided for @assistantThinking.
  ///
  /// In zh, this message translates to:
  /// **'正在查询记录并思考…'**
  String get assistantThinking;

  /// No description provided for @assistantGoToSettings.
  ///
  /// In zh, this message translates to:
  /// **'前往设置'**
  String get assistantGoToSettings;

  /// No description provided for @assistantNewChat.
  ///
  /// In zh, this message translates to:
  /// **'新对话'**
  String get assistantNewChat;

  /// No description provided for @assistantToolLoop.
  ///
  /// In zh, this message translates to:
  /// **'AI 查询次数过多，已停止。请换个更具体的问题。'**
  String get assistantToolLoop;

  /// No description provided for @assistantImageUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'图像分析暂不可用：尚未集成并验证多模态模型。'**
  String get assistantImageUnavailable;

  /// No description provided for @claimVerified.
  ///
  /// In zh, this message translates to:
  /// **'已记录'**
  String get claimVerified;

  /// No description provided for @claimCalculated.
  ///
  /// In zh, this message translates to:
  /// **'计算'**
  String get claimCalculated;

  /// No description provided for @claimObservation.
  ///
  /// In zh, this message translates to:
  /// **'观察'**
  String get claimObservation;

  /// No description provided for @claimHypothesis.
  ///
  /// In zh, this message translates to:
  /// **'推测'**
  String get claimHypothesis;

  /// No description provided for @claimRecommendation.
  ///
  /// In zh, this message translates to:
  /// **'建议'**
  String get claimRecommendation;

  /// No description provided for @claimUnknown.
  ///
  /// In zh, this message translates to:
  /// **'未知'**
  String get claimUnknown;

  /// No description provided for @claimUnclassified.
  ///
  /// In zh, this message translates to:
  /// **'未标注'**
  String get claimUnclassified;

  /// No description provided for @unavailableDisabled.
  ///
  /// In zh, this message translates to:
  /// **'未启用'**
  String get unavailableDisabled;

  /// No description provided for @unavailableNotConfigured.
  ///
  /// In zh, this message translates to:
  /// **'未配置地址或访问令牌'**
  String get unavailableNotConfigured;

  /// No description provided for @unavailableConsent.
  ///
  /// In zh, this message translates to:
  /// **'需要你同意发送数据'**
  String get unavailableConsent;

  /// No description provided for @unavailableUnreachable.
  ///
  /// In zh, this message translates to:
  /// **'无法连接'**
  String get unavailableUnreachable;

  /// No description provided for @unavailableUnauthorized.
  ///
  /// In zh, this message translates to:
  /// **'访问令牌无效'**
  String get unavailableUnauthorized;

  /// No description provided for @unavailableInsecure.
  ///
  /// In zh, this message translates to:
  /// **'需要 HTTPS（自签名证书需填写指纹）'**
  String get unavailableInsecure;

  /// No description provided for @unavailableModelMissing.
  ///
  /// In zh, this message translates to:
  /// **'模型不可用'**
  String get unavailableModelMissing;

  /// No description provided for @unavailableNotBundled.
  ///
  /// In zh, this message translates to:
  /// **'此版本未包含手机本地模型'**
  String get unavailableNotBundled;

  /// No description provided for @analyticsWeightComparison.
  ///
  /// In zh, this message translates to:
  /// **'体重对比'**
  String get analyticsWeightComparison;

  /// No description provided for @analyticsSelectBeetles.
  ///
  /// In zh, this message translates to:
  /// **'选择要对比的甲虫'**
  String get analyticsSelectBeetles;

  /// No description provided for @analyticsTemperatureTrends.
  ///
  /// In zh, this message translates to:
  /// **'温度趋势（7 天）'**
  String get analyticsTemperatureTrends;

  /// No description provided for @analyticsSubstrateHistory.
  ///
  /// In zh, this message translates to:
  /// **'换土记录'**
  String get analyticsSubstrateHistory;

  /// No description provided for @analyticsAiHistory.
  ///
  /// In zh, this message translates to:
  /// **'AI 观察记录'**
  String get analyticsAiHistory;

  /// No description provided for @analyticsCorrelationNote.
  ///
  /// In zh, this message translates to:
  /// **'图表只展示记录数据；同时发生的变化不代表因果关系。'**
  String get analyticsCorrelationNote;

  /// No description provided for @analyticsNoData.
  ///
  /// In zh, this message translates to:
  /// **'暂无数据'**
  String get analyticsNoData;

  /// No description provided for @analyticsMinMax.
  ///
  /// In zh, this message translates to:
  /// **'当前 {current}°C · 最低 {low}°C · 最高 {high}°C'**
  String analyticsMinMax(String current, String high, String low);

  /// No description provided for @analyticsTarget.
  ///
  /// In zh, this message translates to:
  /// **'目标 {target}°C · 阈值 {range}'**
  String analyticsTarget(String range, String target);

  /// No description provided for @analyticsRecentMeasurements.
  ///
  /// In zh, this message translates to:
  /// **'最近称重'**
  String get analyticsRecentMeasurements;

  /// No description provided for @settingsAppearance.
  ///
  /// In zh, this message translates to:
  /// **'外观'**
  String get settingsAppearance;

  /// No description provided for @settingsTheme.
  ///
  /// In zh, this message translates to:
  /// **'主题'**
  String get settingsTheme;

  /// No description provided for @themeSystem.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In zh, this message translates to:
  /// **'浅色'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In zh, this message translates to:
  /// **'深色'**
  String get themeDark;

  /// No description provided for @settingsLanguage.
  ///
  /// In zh, this message translates to:
  /// **'语言'**
  String get settingsLanguage;

  /// No description provided for @settingsAi.
  ///
  /// In zh, this message translates to:
  /// **'AI'**
  String get settingsAi;

  /// No description provided for @settingsMacGateway.
  ///
  /// In zh, this message translates to:
  /// **'Mac AI 网关'**
  String get settingsMacGateway;

  /// No description provided for @settingsGatewayUrl.
  ///
  /// In zh, this message translates to:
  /// **'网关地址'**
  String get settingsGatewayUrl;

  /// No description provided for @settingsGatewayUrlHelper.
  ///
  /// In zh, this message translates to:
  /// **'例如 https://my-mac.local:8443'**
  String get settingsGatewayUrlHelper;

  /// No description provided for @settingsGatewayUrlInvalid.
  ///
  /// In zh, this message translates to:
  /// **'请输入 https:// 开头的地址'**
  String get settingsGatewayUrlInvalid;

  /// No description provided for @settingsGatewayToken.
  ///
  /// In zh, this message translates to:
  /// **'访问令牌'**
  String get settingsGatewayToken;

  /// No description provided for @settingsGatewayTokenHelper.
  ///
  /// In zh, this message translates to:
  /// **'在 Mac 上运行 make gateway-token 生成；保存在系统钥匙串中'**
  String get settingsGatewayTokenHelper;

  /// No description provided for @settingsGatewayTokenSet.
  ///
  /// In zh, this message translates to:
  /// **'已保存（不显示）'**
  String get settingsGatewayTokenSet;

  /// No description provided for @settingsCertFingerprint.
  ///
  /// In zh, this message translates to:
  /// **'证书 SHA-256 指纹'**
  String get settingsCertFingerprint;

  /// No description provided for @settingsCertFingerprintHelper.
  ///
  /// In zh, this message translates to:
  /// **'使用自签名证书时必填（make gateway-cert 会输出）'**
  String get settingsCertFingerprintHelper;

  /// No description provided for @settingsCertFingerprintInvalid.
  ///
  /// In zh, this message translates to:
  /// **'应为 64 位十六进制'**
  String get settingsCertFingerprintInvalid;

  /// No description provided for @settingsModel.
  ///
  /// In zh, this message translates to:
  /// **'模型'**
  String get settingsModel;

  /// No description provided for @settingsTimeout.
  ///
  /// In zh, this message translates to:
  /// **'超时（秒）'**
  String get settingsTimeout;

  /// No description provided for @settingsTestConnection.
  ///
  /// In zh, this message translates to:
  /// **'测试连接'**
  String get settingsTestConnection;

  /// No description provided for @settingsConnectionOk.
  ///
  /// In zh, this message translates to:
  /// **'连接成功'**
  String get settingsConnectionOk;

  /// No description provided for @settingsEnabled.
  ///
  /// In zh, this message translates to:
  /// **'启用'**
  String get settingsEnabled;

  /// No description provided for @settingsRouting.
  ///
  /// In zh, this message translates to:
  /// **'AI 路由'**
  String get settingsRouting;

  /// No description provided for @routingAuto.
  ///
  /// In zh, this message translates to:
  /// **'自动（优先 Mac）'**
  String get routingAuto;

  /// No description provided for @routingMac.
  ///
  /// In zh, this message translates to:
  /// **'仅 Mac'**
  String get routingMac;

  /// No description provided for @routingMobile.
  ///
  /// In zh, this message translates to:
  /// **'仅手机'**
  String get routingMobile;

  /// No description provided for @settingsMobileAi.
  ///
  /// In zh, this message translates to:
  /// **'手机本地 AI'**
  String get settingsMobileAi;

  /// No description provided for @settingsMobileAiStatus.
  ///
  /// In zh, this message translates to:
  /// **'在本机离线运行小模型（实验性）'**
  String get settingsMobileAiStatus;

  /// No description provided for @settingsVision.
  ///
  /// In zh, this message translates to:
  /// **'图像分析'**
  String get settingsVision;

  /// No description provided for @settingsAutoAi.
  ///
  /// In zh, this message translates to:
  /// **'保存记录后自动请求 AI 解读'**
  String get settingsAutoAi;

  /// No description provided for @settingsAutoAiHelper.
  ///
  /// In zh, this message translates to:
  /// **'会把该甲虫的相关记录发送到 Mac 网关；结果只会作为待确认建议'**
  String get settingsAutoAiHelper;

  /// No description provided for @settingsRevokeConsent.
  ///
  /// In zh, this message translates to:
  /// **'撤销数据发送授权'**
  String get settingsRevokeConsent;

  /// No description provided for @settingsConsentGranted.
  ///
  /// In zh, this message translates to:
  /// **'已授权：{date}'**
  String settingsConsentGranted(String date);

  /// No description provided for @settingsCareRules.
  ///
  /// In zh, this message translates to:
  /// **'主动关怀规则'**
  String get settingsCareRules;

  /// No description provided for @ruleWeightPercent.
  ///
  /// In zh, this message translates to:
  /// **'体重变化提示阈值（%）'**
  String get ruleWeightPercent;

  /// No description provided for @ruleGapDays.
  ///
  /// In zh, this message translates to:
  /// **'多久未称重时提示（天）'**
  String get ruleGapDays;

  /// No description provided for @ruleSubstrateInterval.
  ///
  /// In zh, this message translates to:
  /// **'换土检查间隔（天，留空关闭）'**
  String get ruleSubstrateInterval;

  /// No description provided for @ruleSuggestionExpiry.
  ///
  /// In zh, this message translates to:
  /// **'未处理建议过期（天）'**
  String get ruleSuggestionExpiry;

  /// No description provided for @settingsSpecies.
  ///
  /// In zh, this message translates to:
  /// **'种类管理'**
  String get settingsSpecies;

  /// No description provided for @speciesAdd.
  ///
  /// In zh, this message translates to:
  /// **'添加种类'**
  String get speciesAdd;

  /// No description provided for @speciesCode.
  ///
  /// In zh, this message translates to:
  /// **'种类代码（2–8 位大写字母/数字）'**
  String get speciesCode;

  /// No description provided for @speciesScientific.
  ///
  /// In zh, this message translates to:
  /// **'学名'**
  String get speciesScientific;

  /// No description provided for @speciesCommon.
  ///
  /// In zh, this message translates to:
  /// **'俗名'**
  String get speciesCommon;

  /// No description provided for @speciesPupaMin.
  ///
  /// In zh, this message translates to:
  /// **'蛹期最短（天）'**
  String get speciesPupaMin;

  /// No description provided for @speciesPupaMax.
  ///
  /// In zh, this message translates to:
  /// **'蛹期最长（天）'**
  String get speciesPupaMax;

  /// No description provided for @speciesPupaHelper.
  ///
  /// In zh, this message translates to:
  /// **'留空表示未知；仅用于预期羽化窗口提醒'**
  String get speciesPupaHelper;

  /// No description provided for @speciesBuiltin.
  ///
  /// In zh, this message translates to:
  /// **'内置'**
  String get speciesBuiltin;

  /// No description provided for @speciesRangeInvalid.
  ///
  /// In zh, this message translates to:
  /// **'最短不能大于最长'**
  String get speciesRangeInvalid;

  /// No description provided for @settingsSensors.
  ///
  /// In zh, this message translates to:
  /// **'温度传感器'**
  String get settingsSensors;

  /// No description provided for @sensorAdd.
  ///
  /// In zh, this message translates to:
  /// **'添加传感器'**
  String get sensorAdd;

  /// No description provided for @sensorName.
  ///
  /// In zh, this message translates to:
  /// **'名称'**
  String get sensorName;

  /// No description provided for @sensorLocation.
  ///
  /// In zh, this message translates to:
  /// **'位置'**
  String get sensorLocation;

  /// No description provided for @sensorKind.
  ///
  /// In zh, this message translates to:
  /// **'类型'**
  String get sensorKind;

  /// No description provided for @sensorManual.
  ///
  /// In zh, this message translates to:
  /// **'手动记录'**
  String get sensorManual;

  /// No description provided for @sensorBluetooth.
  ///
  /// In zh, this message translates to:
  /// **'蓝牙（尚未支持）'**
  String get sensorBluetooth;

  /// No description provided for @sensorWifi.
  ///
  /// In zh, this message translates to:
  /// **'Wi-Fi（尚未支持）'**
  String get sensorWifi;

  /// No description provided for @sensorMin.
  ///
  /// In zh, this message translates to:
  /// **'最低阈值（°C）'**
  String get sensorMin;

  /// No description provided for @sensorMax.
  ///
  /// In zh, this message translates to:
  /// **'最高阈值（°C）'**
  String get sensorMax;

  /// No description provided for @sensorTarget.
  ///
  /// In zh, this message translates to:
  /// **'目标温度（°C）'**
  String get sensorTarget;

  /// No description provided for @sensorThresholdHelper.
  ///
  /// In zh, this message translates to:
  /// **'适宜温度因种类和阶段而异，请按你的饲养方案设定。'**
  String get sensorThresholdHelper;

  /// No description provided for @settingsSuppressions.
  ///
  /// In zh, this message translates to:
  /// **'已关闭的建议类型'**
  String get settingsSuppressions;

  /// No description provided for @suppressionAllBeetles.
  ///
  /// In zh, this message translates to:
  /// **'所有甲虫'**
  String get suppressionAllBeetles;

  /// No description provided for @settingsBackup.
  ///
  /// In zh, this message translates to:
  /// **'备份与恢复'**
  String get settingsBackup;

  /// No description provided for @backupExport.
  ///
  /// In zh, this message translates to:
  /// **'导出备份'**
  String get backupExport;

  /// No description provided for @backupExportHelper.
  ///
  /// In zh, this message translates to:
  /// **'包含所有记录和照片；不包含访问令牌'**
  String get backupExportHelper;

  /// No description provided for @backupImport.
  ///
  /// In zh, this message translates to:
  /// **'从备份恢复'**
  String get backupImport;

  /// No description provided for @backupRestoreConfirm.
  ///
  /// In zh, this message translates to:
  /// **'将按记录 ID 合并备份数据：新记录会被添加，较新的修改会覆盖较旧的版本，不会产生重复。继续？'**
  String get backupRestoreConfirm;

  /// No description provided for @backupRestored.
  ///
  /// In zh, this message translates to:
  /// **'恢复完成：新增 {inserted}，更新 {updated}，跳过 {skipped}'**
  String backupRestored(int inserted, int skipped, int updated);

  /// No description provided for @backupErrorNotBackup.
  ///
  /// In zh, this message translates to:
  /// **'不是有效的备份文件'**
  String get backupErrorNotBackup;

  /// No description provided for @backupErrorVersion.
  ///
  /// In zh, this message translates to:
  /// **'备份版本不受支持（可能来自更新的应用版本）'**
  String get backupErrorVersion;

  /// No description provided for @backupErrorCorrupted.
  ///
  /// In zh, this message translates to:
  /// **'备份文件已损坏（完整性校验失败）'**
  String get backupErrorCorrupted;

  /// No description provided for @backupErrorAlready.
  ///
  /// In zh, this message translates to:
  /// **'该备份已经恢复过'**
  String get backupErrorAlready;

  /// No description provided for @backupErrorConflict.
  ///
  /// In zh, this message translates to:
  /// **'编号冲突：{codes}。本机已有相同编号的不同记录，未做任何更改。'**
  String backupErrorConflict(String codes);

  /// No description provided for @settingsAiMemory.
  ///
  /// In zh, this message translates to:
  /// **'AI 记忆'**
  String get settingsAiMemory;

  /// No description provided for @aiMemoryEmpty.
  ///
  /// In zh, this message translates to:
  /// **'暂无 AI 分析记录'**
  String get aiMemoryEmpty;

  /// No description provided for @aiMemoryDeleteAll.
  ///
  /// In zh, this message translates to:
  /// **'删除全部 AI 分析'**
  String get aiMemoryDeleteAll;

  /// No description provided for @aiMemoryDeleteConfirm.
  ///
  /// In zh, this message translates to:
  /// **'只删除 AI 生成的分析，不会删除任何饲养记录。'**
  String get aiMemoryDeleteConfirm;

  /// No description provided for @aiMemoryOutcome.
  ///
  /// In zh, this message translates to:
  /// **'预测结果'**
  String get aiMemoryOutcome;

  /// No description provided for @outcomeNotApplicable.
  ///
  /// In zh, this message translates to:
  /// **'不适用'**
  String get outcomeNotApplicable;

  /// No description provided for @outcomePending.
  ///
  /// In zh, this message translates to:
  /// **'待验证'**
  String get outcomePending;

  /// No description provided for @outcomeCorrect.
  ///
  /// In zh, this message translates to:
  /// **'正确'**
  String get outcomeCorrect;

  /// No description provided for @outcomeIncorrect.
  ///
  /// In zh, this message translates to:
  /// **'不正确'**
  String get outcomeIncorrect;

  /// No description provided for @aiMemoryQuestion.
  ///
  /// In zh, this message translates to:
  /// **'问题'**
  String get aiMemoryQuestion;

  /// No description provided for @settingsPrivacy.
  ///
  /// In zh, this message translates to:
  /// **'隐私'**
  String get settingsPrivacy;

  /// No description provided for @privacyBody.
  ///
  /// In zh, this message translates to:
  /// **'所有数据保存在本机。无需账户，没有统计分析。只有在你同意后，数据才会发送到你自己的 Mac 网关，绝不会发送到云服务。'**
  String get privacyBody;

  /// No description provided for @settingsAbout.
  ///
  /// In zh, this message translates to:
  /// **'关于'**
  String get settingsAbout;

  /// No description provided for @aboutVersion.
  ///
  /// In zh, this message translates to:
  /// **'版本 {version}'**
  String aboutVersion(String version);

  /// No description provided for @parentsSection.
  ///
  /// In zh, this message translates to:
  /// **'父母'**
  String get parentsSection;

  /// No description provided for @parentsHint.
  ///
  /// In zh, this message translates to:
  /// **'可选择饲养列表中的个体，或填写不在列表中的种虫信息。'**
  String get parentsHint;

  /// No description provided for @fieldSire.
  ///
  /// In zh, this message translates to:
  /// **'父本'**
  String get fieldSire;

  /// No description provided for @fieldDam.
  ///
  /// In zh, this message translates to:
  /// **'母本'**
  String get fieldDam;

  /// No description provided for @parentNotInCollection.
  ///
  /// In zh, this message translates to:
  /// **'不在列表中'**
  String get parentNotInCollection;

  /// No description provided for @fieldSireNote.
  ///
  /// In zh, this message translates to:
  /// **'父本信息'**
  String get fieldSireNote;

  /// No description provided for @fieldDamNote.
  ///
  /// In zh, this message translates to:
  /// **'母本信息'**
  String get fieldDamNote;

  /// No description provided for @parentNoteHelper.
  ///
  /// In zh, this message translates to:
  /// **'例如：WD 150 mm，瓜德罗普'**
  String get parentNoteHelper;

  /// No description provided for @parentUnknown.
  ///
  /// In zh, this message translates to:
  /// **'未记录'**
  String get parentUnknown;

  /// No description provided for @offspringSection.
  ///
  /// In zh, this message translates to:
  /// **'子代（{count}）'**
  String offspringSection(int count);

  /// No description provided for @parentErrorSelf.
  ///
  /// In zh, this message translates to:
  /// **'个体不能是自己的父母'**
  String get parentErrorSelf;

  /// No description provided for @parentErrorSame.
  ///
  /// In zh, this message translates to:
  /// **'父本和母本必须是不同个体'**
  String get parentErrorSame;

  /// No description provided for @parentErrorNotFound.
  ///
  /// In zh, this message translates to:
  /// **'所选父母已不存在'**
  String get parentErrorNotFound;

  /// No description provided for @parentErrorWrongSex.
  ///
  /// In zh, this message translates to:
  /// **'父本须为雄性，母本须为雌性'**
  String get parentErrorWrongSex;

  /// No description provided for @parentErrorCycle.
  ///
  /// In zh, this message translates to:
  /// **'这会让个体成为自己的祖先'**
  String get parentErrorCycle;

  /// No description provided for @parentErrorSexConflict.
  ///
  /// In zh, this message translates to:
  /// **'该个体已有子代记录，不能改为此性别'**
  String get parentErrorSexConflict;

  /// No description provided for @onDeviceIntro.
  ///
  /// In zh, this message translates to:
  /// **'在手机上运行 {model}。无需网络，记录不会离开本机。速度比 Mac AI 慢，回答也更不可靠。'**
  String onDeviceIntro(String model);

  /// No description provided for @onDeviceExperimental.
  ///
  /// In zh, this message translates to:
  /// **'实验性：小模型可能用错查询工具，请对照记录核实回答。'**
  String get onDeviceExperimental;

  /// No description provided for @onDeviceDownloadHint.
  ///
  /// In zh, this message translates to:
  /// **'下载大小 {size}。请使用 Wi-Fi，并在下载时保持应用打开；中断后可继续下载。'**
  String onDeviceDownloadHint(String size);

  /// No description provided for @onDeviceDownload.
  ///
  /// In zh, this message translates to:
  /// **'下载模型'**
  String get onDeviceDownload;

  /// No description provided for @onDeviceResume.
  ///
  /// In zh, this message translates to:
  /// **'继续下载'**
  String get onDeviceResume;

  /// No description provided for @onDeviceDownloading.
  ///
  /// In zh, this message translates to:
  /// **'正在下载… {percent}%'**
  String onDeviceDownloading(int percent);

  /// No description provided for @onDeviceVerifying.
  ///
  /// In zh, this message translates to:
  /// **'正在校验文件…'**
  String get onDeviceVerifying;

  /// No description provided for @onDeviceReady.
  ///
  /// In zh, this message translates to:
  /// **'模型已下载并通过校验'**
  String get onDeviceReady;

  /// No description provided for @onDeviceDelete.
  ///
  /// In zh, this message translates to:
  /// **'删除模型'**
  String get onDeviceDelete;

  /// No description provided for @onDeviceDeleteConfirm.
  ///
  /// In zh, this message translates to:
  /// **'删除已下载的模型？之后可以重新下载。'**
  String get onDeviceDeleteConfirm;

  /// No description provided for @onDeviceNeedsModel.
  ///
  /// In zh, this message translates to:
  /// **'请先下载模型'**
  String get onDeviceNeedsModel;

  /// No description provided for @onDeviceErrorNetwork.
  ///
  /// In zh, this message translates to:
  /// **'下载失败，请检查网络后继续下载'**
  String get onDeviceErrorNetwork;

  /// No description provided for @onDeviceErrorChecksum.
  ///
  /// In zh, this message translates to:
  /// **'文件校验失败，已删除，请重新下载'**
  String get onDeviceErrorChecksum;

  /// No description provided for @onDeviceErrorDiskFull.
  ///
  /// In zh, this message translates to:
  /// **'存储空间不足'**
  String get onDeviceErrorDiskFull;

  /// No description provided for @providerExperimental.
  ///
  /// In zh, this message translates to:
  /// **'实验性'**
  String get providerExperimental;

  /// No description provided for @pastRecordsTitle.
  ///
  /// In zh, this message translates to:
  /// **'补录历史记录'**
  String get pastRecordsTitle;

  /// No description provided for @pastRecordsShortcut.
  ///
  /// In zh, this message translates to:
  /// **'补录历史'**
  String get pastRecordsShortcut;

  /// No description provided for @pastRecordsIntro.
  ///
  /// In zh, this message translates to:
  /// **'补录使用本应用之前的饲养记录。每行一个日期，可以只填体重或只填阶段。保存后会按日期排进成长路线图。'**
  String get pastRecordsIntro;

  /// No description provided for @pastRecordsRow.
  ///
  /// In zh, this message translates to:
  /// **'第 {n} 条'**
  String pastRecordsRow(int n);

  /// No description provided for @pastRecordsAddRow.
  ///
  /// In zh, this message translates to:
  /// **'添加一行'**
  String get pastRecordsAddRow;

  /// No description provided for @pastRecordsDate.
  ///
  /// In zh, this message translates to:
  /// **'日期'**
  String get pastRecordsDate;

  /// No description provided for @pastRecordsWeight.
  ///
  /// In zh, this message translates to:
  /// **'体重（克，可选）'**
  String get pastRecordsWeight;

  /// No description provided for @pastRecordsStage.
  ///
  /// In zh, this message translates to:
  /// **'阶段（可选）'**
  String get pastRecordsStage;

  /// No description provided for @pastRecordsNote.
  ///
  /// In zh, this message translates to:
  /// **'备注（可选）'**
  String get pastRecordsNote;

  /// No description provided for @pastRecordsApprox.
  ///
  /// In zh, this message translates to:
  /// **'日期是大概的'**
  String get pastRecordsApprox;

  /// No description provided for @pastRecordsApproxNote.
  ///
  /// In zh, this message translates to:
  /// **'日期为估计'**
  String get pastRecordsApproxNote;

  /// No description provided for @pastRecordsSaved.
  ///
  /// In zh, this message translates to:
  /// **'已补录 {count} 条记录'**
  String pastRecordsSaved(int count);

  /// No description provided for @pastRecordsNothing.
  ///
  /// In zh, this message translates to:
  /// **'没有可保存的内容'**
  String get pastRecordsNothing;

  /// No description provided for @pastRecordsMissingDate.
  ///
  /// In zh, this message translates to:
  /// **'请选择日期'**
  String get pastRecordsMissingDate;

  /// No description provided for @pastRecordsFutureDate.
  ///
  /// In zh, this message translates to:
  /// **'不能是未来的日期'**
  String get pastRecordsFutureDate;

  /// No description provided for @pastRecordsNeedValue.
  ///
  /// In zh, this message translates to:
  /// **'请填写体重或阶段'**
  String get pastRecordsNeedValue;

  /// No description provided for @pastRecordsBadWeight.
  ///
  /// In zh, this message translates to:
  /// **'体重须大于 0 且小于 1000 克'**
  String get pastRecordsBadWeight;

  /// No description provided for @pastRecordsSaveFailed.
  ///
  /// In zh, this message translates to:
  /// **'保存失败，记录没有改动，请重试'**
  String get pastRecordsSaveFailed;

  /// No description provided for @languageSystem.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get languageSystem;

  /// No description provided for @dashboardNeedsAttention.
  ///
  /// In zh, this message translates to:
  /// **'需要处理'**
  String get dashboardNeedsAttention;

  /// No description provided for @dashboardToday.
  ///
  /// In zh, this message translates to:
  /// **'今天的照料'**
  String get dashboardToday;

  /// No description provided for @dashboardSoon.
  ///
  /// In zh, this message translates to:
  /// **'接下来 7 天'**
  String get dashboardSoon;

  /// No description provided for @dashboardAllClear.
  ///
  /// In zh, this message translates to:
  /// **'今天没有待办，一切正常'**
  String get dashboardAllClear;

  /// No description provided for @dashboardOverdueCount.
  ///
  /// In zh, this message translates to:
  /// **'已逾期 {count} 项'**
  String dashboardOverdueCount(int count);

  /// No description provided for @dashboardSuggestionsToReview.
  ///
  /// In zh, this message translates to:
  /// **'{count} 条照料建议待确认'**
  String dashboardSuggestionsToReview(int count);

  /// No description provided for @dashboardQuickRecord.
  ///
  /// In zh, this message translates to:
  /// **'快速记录'**
  String get dashboardQuickRecord;

  /// No description provided for @dashboardCollection.
  ///
  /// In zh, this message translates to:
  /// **'我的饲养'**
  String get dashboardCollection;

  /// No description provided for @reminderMarkDone.
  ///
  /// In zh, this message translates to:
  /// **'标记完成'**
  String get reminderMarkDone;

  /// No description provided for @commonActionFailed.
  ///
  /// In zh, this message translates to:
  /// **'操作未完成，没有任何改动，请重试'**
  String get commonActionFailed;

  /// No description provided for @roadmapTitle.
  ///
  /// In zh, this message translates to:
  /// **'成长路线'**
  String get roadmapTitle;

  /// No description provided for @roadmapCurrent.
  ///
  /// In zh, this message translates to:
  /// **'当前阶段'**
  String get roadmapCurrent;

  /// No description provided for @roadmapRecorded.
  ///
  /// In zh, this message translates to:
  /// **'已记录'**
  String get roadmapRecorded;

  /// No description provided for @roadmapNotRecorded.
  ///
  /// In zh, this message translates to:
  /// **'未记录'**
  String get roadmapNotRecorded;

  /// No description provided for @roadmapUpcoming.
  ///
  /// In zh, this message translates to:
  /// **'尚未到达'**
  String get roadmapUpcoming;

  /// No description provided for @roadmapSince.
  ///
  /// In zh, this message translates to:
  /// **'自 {date} 起'**
  String roadmapSince(String date);

  /// No description provided for @roadmapPeriod.
  ///
  /// In zh, this message translates to:
  /// **'{start} → 下一条记录 {end}'**
  String roadmapPeriod(String start, String end);

  /// No description provided for @roadmapApprox.
  ///
  /// In zh, this message translates to:
  /// **'约'**
  String get roadmapApprox;

  /// No description provided for @roadmapWeights.
  ///
  /// In zh, this message translates to:
  /// **'{count} 次称重'**
  String roadmapWeights(int count);

  /// No description provided for @roadmapLatestWeight.
  ///
  /// In zh, this message translates to:
  /// **'最近 {weight}（{date}）'**
  String roadmapLatestWeight(String weight, String date);

  /// No description provided for @roadmapNeedsReview.
  ///
  /// In zh, this message translates to:
  /// **'阶段顺序异常，请检查记录'**
  String get roadmapNeedsReview;

  /// No description provided for @roadmapBeforeFirst.
  ///
  /// In zh, this message translates to:
  /// **'首个阶段记录之前有 {count} 次称重（阶段未知）'**
  String roadmapBeforeFirst(int count);

  /// No description provided for @roadmapEndNote.
  ///
  /// In zh, this message translates to:
  /// **'结束日期为下一条阶段记录的日期，不代表确切的蜕变时间。'**
  String get roadmapEndNote;

  /// No description provided for @roadmapNoWeights.
  ///
  /// In zh, this message translates to:
  /// **'此阶段没有称重记录'**
  String get roadmapNoWeights;

  /// No description provided for @roadmapNoStages.
  ///
  /// In zh, this message translates to:
  /// **'还没有阶段记录。添加阶段变化后会显示路线。'**
  String get roadmapNoStages;

  /// No description provided for @roadmapStageEvents.
  ///
  /// In zh, this message translates to:
  /// **'阶段记录'**
  String get roadmapStageEvents;

  /// No description provided for @detailAddRecord.
  ///
  /// In zh, this message translates to:
  /// **'添加记录'**
  String get detailAddRecord;

  /// No description provided for @detailTabOverview.
  ///
  /// In zh, this message translates to:
  /// **'概览'**
  String get detailTabOverview;

  /// No description provided for @detailTabRecords.
  ///
  /// In zh, this message translates to:
  /// **'记录'**
  String get detailTabRecords;

  /// No description provided for @detailTabPhotos.
  ///
  /// In zh, this message translates to:
  /// **'照片'**
  String get detailTabPhotos;

  /// No description provided for @photoDelete.
  ///
  /// In zh, this message translates to:
  /// **'删除照片'**
  String get photoDelete;

  /// No description provided for @photoActions.
  ///
  /// In zh, this message translates to:
  /// **'照片操作'**
  String get photoActions;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'th', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'th':
      return AppLocalizationsTh();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

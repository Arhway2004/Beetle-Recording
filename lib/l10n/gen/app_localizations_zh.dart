// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '甲虫饲养助手';

  @override
  String get navDashboard => '首页';

  @override
  String get navBeetles => '甲虫';

  @override
  String get navRecords => '记录';

  @override
  String get navAssistant => 'AI 助手';

  @override
  String get navReminders => '提醒';

  @override
  String get navAnalytics => '分析';

  @override
  String get navSettings => '设置';

  @override
  String get commonSave => '保存';

  @override
  String get commonCancel => '取消';

  @override
  String get commonDelete => '删除';

  @override
  String get commonEdit => '编辑';

  @override
  String get commonConfirm => '确认';

  @override
  String get commonRetry => '重试';

  @override
  String get commonClose => '关闭';

  @override
  String get commonAdd => '添加';

  @override
  String get commonAll => '全部';

  @override
  String get commonNone => '无';

  @override
  String get commonOptional => '可选';

  @override
  String get commonRequired => '必填';

  @override
  String get commonInvalidNumber => '请输入有效的数字';

  @override
  String get commonMustBePositive => '必须大于 0';

  @override
  String get commonErrorTitle => '出错了';

  @override
  String get commonSaved => '已保存';

  @override
  String get commonNotes => '备注';

  @override
  String get commonDateTime => '时间';

  @override
  String get commonDeleteConfirmTitle => '确认删除？';

  @override
  String get commonDeleteRecordMessage =>
      '该记录会被标记为已删除（保留审计痕迹），甲虫的当前状态会回退到上一条记录。';

  @override
  String get commonNotSet => '未设定';

  @override
  String get sexMale => '公';

  @override
  String get sexFemale => '母';

  @override
  String get sexUnknown => '未知';

  @override
  String get stageL1 => 'L1 幼虫';

  @override
  String get stageL2 => 'L2 幼虫';

  @override
  String get stageL3 => 'L3 幼虫';

  @override
  String get stagePrepupa => '预蛹';

  @override
  String get stagePupa => '蛹';

  @override
  String get stageAdult => '成虫';

  @override
  String get stageUnset => '阶段未记录';

  @override
  String get l3Early => '前期';

  @override
  String get l3Middle => '中期';

  @override
  String get l3Late => '后期';

  @override
  String get statusActive => '饲养中';

  @override
  String get statusDeceased => '已死亡';

  @override
  String get statusTransferred => '已转让';

  @override
  String get statusArchived => '已归档';

  @override
  String get obsGeneral => '一般';

  @override
  String get obsColorChange => '体色变化';

  @override
  String get obsActivity => '活动';

  @override
  String get obsFeeding => '进食';

  @override
  String get obsPupalChamber => '蛹室';

  @override
  String get obsMolt => '蜕皮';

  @override
  String get obsHealth => '健康';

  @override
  String get obsBehavior => '行为';

  @override
  String get reminderStatusSuggested => '待确认';

  @override
  String get reminderStatusConfirmed => '已确认';

  @override
  String get reminderStatusScheduled => '已安排';

  @override
  String get reminderStatusCompleted => '已完成';

  @override
  String get reminderStatusCancelled => '已取消';

  @override
  String get reminderStatusExpired => '已过期';

  @override
  String get severityInfo => '信息';

  @override
  String get severityObservation => '观察';

  @override
  String get severityWarning => '注意';

  @override
  String get severityAlert => '警报';

  @override
  String confidenceLabel(String level) {
    return '置信度：$level';
  }

  @override
  String get confidenceLow => '低';

  @override
  String get confidenceMedium => '中';

  @override
  String get confidenceHigh => '高';

  @override
  String get basisMeasured => '实测超限';

  @override
  String get basisCalculated => '计算结果';

  @override
  String get basisAiInference => 'AI 推测';

  @override
  String get sourceUser => '用户创建';

  @override
  String get sourceRule => '规则检测';

  @override
  String get sourceAi => 'AI 建议';

  @override
  String get recordWeight => '体重';

  @override
  String get recordObservation => '观察';

  @override
  String get recordSubstrate => '换土';

  @override
  String get recordContainer => '换盒';

  @override
  String get recordLifeStage => '阶段变化';

  @override
  String get recordTemperature => '温度';

  @override
  String get eventSignificantWeightChange => '体重显著变化';

  @override
  String get eventWeightLoss => '体重下降';

  @override
  String get eventMeasurementOverdue => '长时间未称重';

  @override
  String get eventSubstrateInspection => '检查/更换土';

  @override
  String get eventContainerReview => '评估容器';

  @override
  String get eventTemperatureOutOfRange => '温度超出范围';

  @override
  String get eventPossiblePrepupa => '可能进入预蛹';

  @override
  String get eventPossiblePupation => '可能化蛹';

  @override
  String get eventExpectedEmergenceWindow => '预期羽化窗口';

  @override
  String get eventOutdatedReminder => '过期提醒';

  @override
  String get eventGeneralObservation => '一般观察';

  @override
  String get eventCustom => '自定义';

  @override
  String get dashboardActiveBeetles => '饲养中';

  @override
  String get dashboardPendingSuggestions => '待确认建议';

  @override
  String get dashboardUpcoming => '即将到来的提醒';

  @override
  String get dashboardRecent => '最近记录';

  @override
  String get dashboardEmptyTitle => '还没有甲虫';

  @override
  String get dashboardEmptyBody => '添加第一只甲虫，开始记录它的成长。';

  @override
  String get dashboardAddBeetle => '添加甲虫';

  @override
  String get dashboardBySpecies => '按种类';

  @override
  String get dashboardByStage => '按阶段';

  @override
  String get dashboardNoUpcoming => '暂无提醒';

  @override
  String dashboardTemperatureAlert(String celsius, String sensor) {
    return '$sensor：$celsius°C 超出你设定的范围';
  }

  @override
  String get dashboardReviewSuggestions => '查看';

  @override
  String get beetlesSearchHint => '搜索编号或备注';

  @override
  String get beetlesEmpty => '没有符合条件的甲虫';

  @override
  String get filterSpecies => '种类';

  @override
  String get filterSex => '性别';

  @override
  String get filterStage => '阶段';

  @override
  String get filterStatus => '状态';

  @override
  String get beetleFormNewTitle => '新增甲虫';

  @override
  String get beetleFormEditTitle => '编辑甲虫';

  @override
  String get fieldCode => '编号';

  @override
  String get fieldCodeHelper => '例如 DHH-001';

  @override
  String get fieldCodeInvalid => '格式应为 种类代码-编号，例如 DHH-001';

  @override
  String fieldCodeDuplicate(String code) {
    return '编号 $code 已存在';
  }

  @override
  String get fieldSpecies => '种类';

  @override
  String get fieldSex => '性别';

  @override
  String get fieldStatus => '状态';

  @override
  String get fieldAcquiredAt => '入手日期';

  @override
  String get fieldHatchDate => '孵化日期';

  @override
  String get fieldEstimatedHatchDate => '估计孵化日期';

  @override
  String get fieldHatchUncertainty => '估计误差（± 天）';

  @override
  String get fieldStage => '当前阶段';

  @override
  String get fieldL3Phase => 'L3 细分（观察标签）';

  @override
  String get fieldWeight => '当前体重（克）';

  @override
  String get fieldContainer => '容器容量（升）';

  @override
  String get fieldSubstrateType => '土的类型';

  @override
  String get fieldSubstrateBrand => '土的品牌';

  @override
  String get fieldSensor => '温度传感器';

  @override
  String get fieldBreedingNotes => '饲养备注';

  @override
  String get beetleFormInitialSection => '初始记录（保存为历史事件）';

  @override
  String get beetleFormStageHint => '阶段只根据你的记录设置，不会根据体重推断。';

  @override
  String get beetleFormHistoryHint => '体重、容器、土和阶段的后续变化请在详情页添加记录。';

  @override
  String get detailOverview => '概览';

  @override
  String get detailGrowth => '成长曲线';

  @override
  String get detailHistory => '历史记录';

  @override
  String get detailPhotos => '照片';

  @override
  String get detailReminders => '提醒';

  @override
  String get detailAiAnalyses => 'AI 分析记录';

  @override
  String get detailAddPhoto => '添加照片';

  @override
  String get detailNoPhotos => '暂无照片';

  @override
  String get detailNoHistory => '暂无记录';

  @override
  String get detailAiInterpret => 'AI 解读近况';

  @override
  String detailAiInterpretDone(int n) {
    return 'AI 生成了 $n 条建议，已放入待确认列表';
  }

  @override
  String detailAiInterpretRejected(int n) {
    return '$n 条 AI 输出未通过校验，已丢弃';
  }

  @override
  String get detailLatestWeight => '最新体重';

  @override
  String get detailMaxWeight => '历史最高';

  @override
  String get detailChangeSincePrevious => '较上次';

  @override
  String get detailAvgWeekly => '平均每周';

  @override
  String get detailNeedTwoWeights => '至少需要两次称重才能计算变化';

  @override
  String get detailHatch => '孵化';

  @override
  String detailEstimatedHatch(String date, int days) {
    return '约 $date（±$days 天）';
  }

  @override
  String get detailAcquired => '入手';

  @override
  String get detailContainer => '容器';

  @override
  String get detailSubstrate => '土';

  @override
  String get detailChangeStatus => '更改状态';

  @override
  String get detailAvgNote => '平均值只反映首末两次记录，生长并非线性。';

  @override
  String get recordsEmpty => '暂无记录';

  @override
  String get recordsAdd => '添加记录';

  @override
  String get chooseRecordType => '选择记录类型';

  @override
  String get chooseBeetle => '选择甲虫';

  @override
  String get weightGrams => '体重（克）';

  @override
  String get weightDisturbWarning => '该个体当前记录为预蛹或蛹。此阶段翻动和称重可能造成伤害。';

  @override
  String get observationCategory => '类别';

  @override
  String get observationDescription => '描述';

  @override
  String get substrateQuantity => '用量（升）';

  @override
  String get substrateBatch => '批次';

  @override
  String get weightDuringChange => '更换时体重（克）';

  @override
  String get observedCondition => '观察到的状况';

  @override
  String get nextPlannedAt => '下次计划检查/换土';

  @override
  String get containerPrevious => '原容器（升，留空则取上次记录）';

  @override
  String get containerNew => '新容器（升）';

  @override
  String get stageNew => '新阶段';

  @override
  String get stageIsEstimated => '日期为估计值';

  @override
  String get temperatureCelsius => '温度（°C）';

  @override
  String get noSensors => '请先在设置中添加温度传感器';

  @override
  String get noBeetles => '请先添加甲虫';

  @override
  String get addPhotos => '添加照片';

  @override
  String photosSelected(int n) {
    return '已选 $n 张照片';
  }

  @override
  String get photoFromCamera => '拍照';

  @override
  String get photoFromGallery => '从相册选择';

  @override
  String suggestionsCreated(int n) {
    return '已保存。生成了 $n 条待确认建议';
  }

  @override
  String get remindersTabSuggested => '待确认';

  @override
  String get remindersTabUpcoming => '已确认';

  @override
  String get remindersTabHistory => '历史';

  @override
  String get remindersEmptySuggested => '没有待确认的建议';

  @override
  String get remindersEmptyUpcoming => '没有已确认的提醒';

  @override
  String get remindersEmptyHistory => '暂无历史';

  @override
  String get reminderNew => '新建提醒';

  @override
  String get reminderTitleField => '标题';

  @override
  String get reminderMessageField => '内容';

  @override
  String get reminderDueAt => '提醒时间';

  @override
  String get reminderBeetleOptional => '关联甲虫（可选）';

  @override
  String get reminderAccept => '接受';

  @override
  String get reminderReject => '拒绝';

  @override
  String get reminderPostpone => '推迟';

  @override
  String reminderPostponeDays(int days) {
    return '推迟 $days 天';
  }

  @override
  String get reminderDisableSimilar => '不再提示类似建议';

  @override
  String reminderDisableSimilarConfirm(String event) {
    return '将不再生成此类建议（$event）。可在设置中恢复。';
  }

  @override
  String get reminderComplete => '完成';

  @override
  String get reminderCancel => '取消提醒';

  @override
  String get reminderReason => '原因';

  @override
  String get reminderRecommendation => '建议';

  @override
  String reminderEvidence(int n) {
    return '依据 $n 条记录';
  }

  @override
  String get reminderNeedsConfirmation => '只有你确认后才会安排通知';

  @override
  String get reminderReview => '确认提醒';

  @override
  String get reminderAcceptEdited => '接受（含修改）';

  @override
  String get notificationsDenied => '通知权限未开启：提醒已保存，但不会弹出系统通知。';

  @override
  String get notificationsRationale => '为了在设定时间提醒你，需要通知权限。';

  @override
  String remindersDeferred(int n) {
    return '$n 个较远的提醒会在临近时安排（系统通知数量限制）';
  }

  @override
  String get remindersInexact => '未授予精确闹钟权限，通知时间可能略有延迟。';

  @override
  String get reminderOverdue => '已逾期';

  @override
  String ruleWeightChangeTitle(String code, String percent) {
    return '$code 体重变化 $percent%';
  }

  @override
  String ruleWeightChangeMessage(String code) {
    return '复查 $code 的体重与状态。';
  }

  @override
  String ruleWeightChangeReason(String from, String percent, String to) {
    return '最近两次记录的体重从 $from g 变为 $to g（$percent%）。';
  }

  @override
  String get ruleWeightLossRecommendation =>
      '一周后复称，并检查土和温度。L3 后期体重下降可能与准备化蛹有关，也可能另有原因；请避免频繁翻动。';

  @override
  String get ruleWeightGainRecommendation => '按常规继续记录即可。';

  @override
  String ruleOverdueTitle(String code) {
    return '为 $code 称重';
  }

  @override
  String get ruleOverdueMessage => '距离上次称重已较久，可在换土时顺便称重。';

  @override
  String ruleOverdueReasonDays(int days) {
    return '已有 $days 天没有体重记录。';
  }

  @override
  String get ruleOverdueReasonNever => '还没有任何体重记录。';

  @override
  String get ruleOverdueRecommendation => '幼虫期可在方便时称重；预蛹或蛹期请勿为称重而翻动。';

  @override
  String ruleSubstrateTitle(String code) {
    return '检查 $code 的土';
  }

  @override
  String get ruleSubstrateMessage => '按计划检查土的状态。';

  @override
  String ruleSubstrateReason(int days) {
    return '距离上次换土已 $days 天，已到你设定的计划时间。';
  }

  @override
  String get ruleSubstrateRecommendation => '先从外部观察；如有蛹室迹象，请不要更换。';

  @override
  String ruleTempTitle(String sensor) {
    return '温度超出设定：$sensor';
  }

  @override
  String ruleTempMessage(String celsius, String sensor) {
    return '$sensor 实测 $celsius°C。';
  }

  @override
  String ruleTempReason(String celsius, String range) {
    return '实测 $celsius°C 超出你设定的范围（$range）。这是实测值，不是 AI 预测。';
  }

  @override
  String get ruleTempRecommendation => '检查环境温度和温控设备。';

  @override
  String rulePrepupaTitle(String code) {
    return '观察 $code 状态';
  }

  @override
  String get rulePrepupaMessage => '检查外部可观察的变化，避免不必要的翻动。';

  @override
  String get rulePrepupaReason => '近期记录到体色变化或蛹室相关观察，但证据不足以确认进入预蛹。';

  @override
  String get rulePrepupaRecommendation => '从外部观察，不要打扰可能存在的蛹室。';

  @override
  String ruleEmergenceTitle(String code) {
    return '$code 预期羽化窗口';
  }

  @override
  String ruleEmergenceMessage(int max, int min) {
    return '按你设定的蛹期（$min–$max 天），开始留意羽化。';
  }

  @override
  String ruleEmergenceReason(int max, int min) {
    return '已记录进入蛹期；你为该种类设定的蛹期为 $min–$max 天。';
  }

  @override
  String get ruleEmergenceRecommendation => '外部观察即可。羽化后成虫需要时间硬化，请勿过早取出。';

  @override
  String get assistantHint => '询问你的饲养记录…';

  @override
  String get assistantEmptyTitle => '问问你的饲养记录';

  @override
  String get assistantEmptyBody => 'AI 会先查询你的记录再回答，并标注哪些是记录、计算、推测或建议。';

  @override
  String get assistantExample1 => 'CCK-001 最近一个月生长正常吗？';

  @override
  String get assistantExample2 => '比较 DHH-001 和 DHH-002 最近三个月的成长速度。';

  @override
  String get assistantExample3 => '为什么我的幼虫最近重量下降？';

  @override
  String get assistantNoProvider => '当前没有可用的 AI 模型，因此无法回答。记录、提醒和分析功能不受影响。';

  @override
  String get assistantProviderMac => 'Mac 本地 AI';

  @override
  String get assistantProviderMobile => '手机本地 AI';

  @override
  String assistantFallback(String provider) {
    return '已回退到 $provider';
  }

  @override
  String get assistantConsentTitle => '允许发送数据到你的 Mac？';

  @override
  String assistantConsentBody(String host) {
    return '回答问题时，应用会把相关饲养记录发送到你配置的 Mac AI 网关（$host）。不会发送到任何云服务。你可以随时在设置中撤销。';
  }

  @override
  String get assistantConsentPublicWarning =>
      '警告：该地址不是本机或局域网 / VPN 地址。请确认它是你自己的设备。';

  @override
  String get assistantConsentAllow => '允许';

  @override
  String assistantEvidence(int n) {
    return '基于 $n 条记录';
  }

  @override
  String assistantToolsUsed(int n) {
    return '查询数据 $n 次';
  }

  @override
  String get assistantReminderDraft => 'AI 提议的提醒（尚未创建）';

  @override
  String get assistantReviewDraft => '查看并确认';

  @override
  String get assistantFeedbackHelpful => '有帮助';

  @override
  String get assistantFeedbackNotHelpful => '没帮助';

  @override
  String assistantError(String error) {
    return '请求失败：$error';
  }

  @override
  String get assistantThinking => '正在查询记录并思考…';

  @override
  String get assistantGoToSettings => '前往设置';

  @override
  String get assistantNewChat => '新对话';

  @override
  String get assistantToolLoop => 'AI 查询次数过多，已停止。请换个更具体的问题。';

  @override
  String get assistantImageUnavailable => '图像分析暂不可用：尚未集成并验证多模态模型。';

  @override
  String get claimVerified => '已记录';

  @override
  String get claimCalculated => '计算';

  @override
  String get claimObservation => '观察';

  @override
  String get claimHypothesis => '推测';

  @override
  String get claimRecommendation => '建议';

  @override
  String get claimUnknown => '未知';

  @override
  String get claimUnclassified => '未标注';

  @override
  String get unavailableDisabled => '未启用';

  @override
  String get unavailableNotConfigured => '未配置地址或访问令牌';

  @override
  String get unavailableConsent => '需要你同意发送数据';

  @override
  String get unavailableUnreachable => '无法连接';

  @override
  String get unavailableUnauthorized => '访问令牌无效';

  @override
  String get unavailableInsecure => '需要 HTTPS（自签名证书需填写指纹）';

  @override
  String get unavailableModelMissing => '模型不可用';

  @override
  String get unavailableNotBundled => '此版本未包含手机本地模型';

  @override
  String get analyticsWeightComparison => '体重对比';

  @override
  String get analyticsSelectBeetles => '选择要对比的甲虫';

  @override
  String get analyticsTemperatureTrends => '温度趋势（7 天）';

  @override
  String get analyticsSubstrateHistory => '换土记录';

  @override
  String get analyticsAiHistory => 'AI 观察记录';

  @override
  String get analyticsCorrelationNote => '图表只展示记录数据；同时发生的变化不代表因果关系。';

  @override
  String get analyticsNoData => '暂无数据';

  @override
  String analyticsMinMax(String current, String high, String low) {
    return '当前 $current°C · 最低 $low°C · 最高 $high°C';
  }

  @override
  String analyticsTarget(String range, String target) {
    return '目标 $target°C · 阈值 $range';
  }

  @override
  String get analyticsRecentMeasurements => '最近称重';

  @override
  String get settingsAppearance => '外观';

  @override
  String get settingsTheme => '主题';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsAi => 'AI';

  @override
  String get settingsMacGateway => 'Mac AI 网关';

  @override
  String get settingsGatewayUrl => '网关地址';

  @override
  String get settingsGatewayUrlHelper => '例如 https://my-mac.local:8443';

  @override
  String get settingsGatewayUrlInvalid => '请输入 https:// 开头的地址';

  @override
  String get settingsGatewayToken => '访问令牌';

  @override
  String get settingsGatewayTokenHelper =>
      '在 Mac 上运行 make gateway-token 生成；保存在系统钥匙串中';

  @override
  String get settingsGatewayTokenSet => '已保存（不显示）';

  @override
  String get settingsCertFingerprint => '证书 SHA-256 指纹';

  @override
  String get settingsCertFingerprintHelper =>
      '使用自签名证书时必填（make gateway-cert 会输出）';

  @override
  String get settingsCertFingerprintInvalid => '应为 64 位十六进制';

  @override
  String get settingsModel => '模型';

  @override
  String get settingsTimeout => '超时（秒）';

  @override
  String get settingsTestConnection => '测试连接';

  @override
  String get settingsConnectionOk => '连接成功';

  @override
  String get settingsEnabled => '启用';

  @override
  String get settingsRouting => 'AI 路由';

  @override
  String get routingAuto => '自动（优先 Mac）';

  @override
  String get routingMac => '仅 Mac';

  @override
  String get routingMobile => '仅手机';

  @override
  String get settingsMobileAi => '手机本地 AI';

  @override
  String get settingsMobileAiStatus => '在本机离线运行小模型（实验性）';

  @override
  String get settingsVision => '图像分析';

  @override
  String get settingsAutoAi => '保存记录后自动请求 AI 解读';

  @override
  String get settingsAutoAiHelper => '会把该甲虫的相关记录发送到 Mac 网关；结果只会作为待确认建议';

  @override
  String get settingsRevokeConsent => '撤销数据发送授权';

  @override
  String settingsConsentGranted(String date) {
    return '已授权：$date';
  }

  @override
  String get settingsCareRules => '主动关怀规则';

  @override
  String get ruleWeightPercent => '体重变化提示阈值（%）';

  @override
  String get ruleGapDays => '多久未称重时提示（天）';

  @override
  String get ruleSubstrateInterval => '换土检查间隔（天，留空关闭）';

  @override
  String get ruleSuggestionExpiry => '未处理建议过期（天）';

  @override
  String get settingsSpecies => '种类管理';

  @override
  String get speciesAdd => '添加种类';

  @override
  String get speciesCode => '种类代码（2–8 位大写字母/数字）';

  @override
  String get speciesScientific => '学名';

  @override
  String get speciesCommon => '俗名';

  @override
  String get speciesPupaMin => '蛹期最短（天）';

  @override
  String get speciesPupaMax => '蛹期最长（天）';

  @override
  String get speciesPupaHelper => '留空表示未知；仅用于预期羽化窗口提醒';

  @override
  String get speciesBuiltin => '内置';

  @override
  String get speciesRangeInvalid => '最短不能大于最长';

  @override
  String get settingsSensors => '温度传感器';

  @override
  String get sensorAdd => '添加传感器';

  @override
  String get sensorName => '名称';

  @override
  String get sensorLocation => '位置';

  @override
  String get sensorKind => '类型';

  @override
  String get sensorManual => '手动记录';

  @override
  String get sensorBluetooth => '蓝牙（尚未支持）';

  @override
  String get sensorWifi => 'Wi-Fi（尚未支持）';

  @override
  String get sensorMin => '最低阈值（°C）';

  @override
  String get sensorMax => '最高阈值（°C）';

  @override
  String get sensorTarget => '目标温度（°C）';

  @override
  String get sensorThresholdHelper => '适宜温度因种类和阶段而异，请按你的饲养方案设定。';

  @override
  String get settingsSuppressions => '已关闭的建议类型';

  @override
  String get suppressionAllBeetles => '所有甲虫';

  @override
  String get settingsBackup => '备份与恢复';

  @override
  String get backupExport => '导出备份';

  @override
  String get backupExportHelper => '包含所有记录和照片；不包含访问令牌';

  @override
  String get backupImport => '从备份恢复';

  @override
  String get backupRestoreConfirm =>
      '将按记录 ID 合并备份数据：新记录会被添加，较新的修改会覆盖较旧的版本，不会产生重复。继续？';

  @override
  String backupRestored(int inserted, int skipped, int updated) {
    return '恢复完成：新增 $inserted，更新 $updated，跳过 $skipped';
  }

  @override
  String get backupErrorNotBackup => '不是有效的备份文件';

  @override
  String get backupErrorVersion => '备份版本不受支持（可能来自更新的应用版本）';

  @override
  String get backupErrorCorrupted => '备份文件已损坏（完整性校验失败）';

  @override
  String get backupErrorAlready => '该备份已经恢复过';

  @override
  String backupErrorConflict(String codes) {
    return '编号冲突：$codes。本机已有相同编号的不同记录，未做任何更改。';
  }

  @override
  String get settingsAiMemory => 'AI 记忆';

  @override
  String get aiMemoryEmpty => '暂无 AI 分析记录';

  @override
  String get aiMemoryDeleteAll => '删除全部 AI 分析';

  @override
  String get aiMemoryDeleteConfirm => '只删除 AI 生成的分析，不会删除任何饲养记录。';

  @override
  String get aiMemoryOutcome => '预测结果';

  @override
  String get outcomeNotApplicable => '不适用';

  @override
  String get outcomePending => '待验证';

  @override
  String get outcomeCorrect => '正确';

  @override
  String get outcomeIncorrect => '不正确';

  @override
  String get aiMemoryQuestion => '问题';

  @override
  String get settingsPrivacy => '隐私';

  @override
  String get privacyBody =>
      '所有数据保存在本机。无需账户，没有统计分析。只有在你同意后，数据才会发送到你自己的 Mac 网关，绝不会发送到云服务。';

  @override
  String get settingsAbout => '关于';

  @override
  String aboutVersion(String version) {
    return '版本 $version';
  }

  @override
  String get parentsSection => '父母';

  @override
  String get parentsHint => '可选择饲养列表中的个体，或填写不在列表中的种虫信息。';

  @override
  String get fieldSire => '父本';

  @override
  String get fieldDam => '母本';

  @override
  String get parentNotInCollection => '不在列表中';

  @override
  String get fieldSireNote => '父本信息';

  @override
  String get fieldDamNote => '母本信息';

  @override
  String get parentNoteHelper => '例如：WD 150 mm，瓜德罗普';

  @override
  String get parentUnknown => '未记录';

  @override
  String offspringSection(int count) {
    return '子代（$count）';
  }

  @override
  String get parentErrorSelf => '个体不能是自己的父母';

  @override
  String get parentErrorSame => '父本和母本必须是不同个体';

  @override
  String get parentErrorNotFound => '所选父母已不存在';

  @override
  String get parentErrorWrongSex => '父本须为雄性，母本须为雌性';

  @override
  String get parentErrorCycle => '这会让个体成为自己的祖先';

  @override
  String get parentErrorSexConflict => '该个体已有子代记录，不能改为此性别';

  @override
  String onDeviceIntro(String model) {
    return '在手机上运行 $model。无需网络，记录不会离开本机。速度比 Mac AI 慢，回答也更不可靠。';
  }

  @override
  String get onDeviceExperimental => '实验性：小模型可能用错查询工具，请对照记录核实回答。';

  @override
  String onDeviceDownloadHint(String size) {
    return '下载大小 $size。请使用 Wi-Fi，并在下载时保持应用打开；中断后可继续下载。';
  }

  @override
  String get onDeviceDownload => '下载模型';

  @override
  String get onDeviceResume => '继续下载';

  @override
  String onDeviceDownloading(int percent) {
    return '正在下载… $percent%';
  }

  @override
  String get onDeviceVerifying => '正在校验文件…';

  @override
  String get onDeviceReady => '模型已下载并通过校验';

  @override
  String get onDeviceDelete => '删除模型';

  @override
  String get onDeviceDeleteConfirm => '删除已下载的模型？之后可以重新下载。';

  @override
  String get onDeviceNeedsModel => '请先下载模型';

  @override
  String get onDeviceErrorNetwork => '下载失败，请检查网络后继续下载';

  @override
  String get onDeviceErrorChecksum => '文件校验失败，已删除，请重新下载';

  @override
  String get onDeviceErrorDiskFull => '存储空间不足';

  @override
  String get providerExperimental => '实验性';
}

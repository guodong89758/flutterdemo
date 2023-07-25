import 'package:flutter/foundation.dart';

class Config {
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction = kReleaseMode;

  static bool isDriverTest = false;

  /// 应用主题
  static const String KEY_APP_THEME = 'key_app_theme';

  /// 应用语言
  static const String KEY_APP_LOCALE = 'key_app_locale';

  /// 应用提醒设置选项
  static const String keyAppAlarmChannels = 'key_app_alarm_channels';

  /// 选择的报警铃声
  static const String keyUserRinging = 'key_user_ringing';

  /// 强提醒开关(android 浮窗强提醒弹窗)
  static const String keySwitchStrongPush = 'key_switch_strong_push';

  /// 常驻通知栏
  static const String keySwitchNotifyService = 'key_switch_notify_service';

  /// 资产显示隐藏
  static const String keyAssetsVisible = 'key_assets_visible';

  /// 交易-现货
  static const String tradeSpot = 'spot';

  /// 交易-现货
  static const String transfer = 'transfer';
  /// 交易-合约
  static const String tradeContract = 'contract';

  /// 交易-仓位模式
  static const String tradePositionMode = 'trade_position_mode';
  /// 双向持仓
  static const String positionBoth = 'both';
  /// 单向持仓
  static const String positionSingle = 'single';

  /// 交易-资产模式
  static const String tradeAssetMode = 'trade_asset_mode';
  /// 联合保证金模式
  static const String assetMulti = 'multi';
  /// 单币保证金模式
  static const String assetSingle = 'single';

  /// 市价委托
  static const String orderMarket = 'market';

  /// 限价委托
  static const String orderLimit = 'limit';

  /// 计划委托
  static const String orderTrigger = 'trigger';

  /// 最近一次所选择的合约交易tab
  static const String keyLastContractTab = 'key_last_contract_tab';

  /// 最近一次所选择的合约交易板块
  static const String keyLastContractArea = 'key_last_contract_area';

  /// 最近一次所选择的合约交易所
  static const String keyLastContractExchange = 'key_last_contract_exchange';

  /// 最近一次所选择的合约交易对
  static const String keyLastContractSymbol = 'key_last_contract_symbol';

  /// 最近一次所选择的合约交易对类型
  static const String keyLastContractType = 'key_last_contract_type';

  /// 最近一次所选择的现货交易板块
  static const String keyLastSpotTab = 'key_last_spot_tab';

  /// 最近一次所选择的现货交易板块
  static const String keyLastSpotArea = 'key_last_spot_area';

  /// 最近一次所选择的现货交易所
  static const String keyLastSpotExchange = 'key_last_spot_exchange';

  /// 最近一次所选择的现货交易对
  static const String keyLastSpotSymbol = 'key_last_spot_symbol';
}

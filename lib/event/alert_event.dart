import 'package:bitfrog/model/alert_index_entity.dart';
import 'package:bitfrog/model/alert_phone_entity.dart';
import 'package:bitfrog/model/sharp_entity.dart';
import 'package:bitfrog/model/symbol_entity.dart';

/// 提醒设置列表刷新
class AlertRefreshEvent {}

/// 价格提醒当前历史列表刷新
class AlertPriceRefreshEvent {}

/// 价格提醒页-删除价格提醒
class AlertPriceDeleteEvent {
  int? alert_id;

  AlertPriceDeleteEvent(this.alert_id);
}

/// 选择交易对
class AlertSymbolEvent {
  BFSymbol? symbol;

  AlertSymbolEvent(this.symbol);
}

/// 设置急涨急跌
class AlertSharpSetEvent {
  SharpEntity? sharp;

  AlertSharpSetEvent(this.sharp);
}

/// 设置指标提醒
class AlertIndexEvent {
  AlertIndexEntity? index;
  Period? period;

  AlertIndexEvent(this.index, this.period);
}

/// 修改电话提醒开关状态
class AlertPhoneEvent {
  PhoneItem? item;

  AlertPhoneEvent(this.item);
}

/// 历史提醒类型选择
class AlertHistoryTypeEvent {}

/// 行情顶部tab选择
class AlertTabEvent {
  String? type;
  String? index;

  AlertTabEvent(this.type,this.index);
}
/// 提醒tab选择
class RemindTabEvent {
  String? index;
  RemindTabEvent(this.index);
}

/// 提醒订阅刷新
class AlertSubscribeEvent {}

/// 推送刷新
class PushRefreshEvent {}

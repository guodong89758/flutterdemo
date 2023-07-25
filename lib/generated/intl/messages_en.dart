// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "action_alert": MessageLookupByLibrary.simpleMessage("提醒"),
        "action_quick_share": MessageLookupByLibrary.simpleMessage("立即分享"),
        "action_set": MessageLookupByLibrary.simpleMessage("设置"),
        "action_to_deposit": MessageLookupByLibrary.simpleMessage("去充值"),
        "click_to_refresh": MessageLookupByLibrary.simpleMessage("点击刷新"),
        "def_delete_success": MessageLookupByLibrary.simpleMessage("删除成功"),
        "def_empty": MessageLookupByLibrary.simpleMessage("暂无数据"),
        "def_failed": MessageLookupByLibrary.simpleMessage("失败"),
        "def_finish": MessageLookupByLibrary.simpleMessage("已完成"),
        "def_loading": MessageLookupByLibrary.simpleMessage("加载中"),
        "def_symbol": MessageLookupByLibrary.simpleMessage("交易对"),
        "error_connect_timeout":
            MessageLookupByLibrary.simpleMessage("网络连接超时，请检查网络设置"),
        "error_net": MessageLookupByLibrary.simpleMessage("暂无网络，请检查网络状态"),
        "error_page": MessageLookupByLibrary.simpleMessage("未找到页面"),
        "error_parse": MessageLookupByLibrary.simpleMessage("数据解析错误"),
        "error_server": MessageLookupByLibrary.simpleMessage("服务异常"),
        "error_ssl": MessageLookupByLibrary.simpleMessage("证书错误"),
        "error_unknow": MessageLookupByLibrary.simpleMessage("未知错误"),
        "load_finish": MessageLookupByLibrary.simpleMessage("到底了"),
        "load_loading": MessageLookupByLibrary.simpleMessage("正在加载中..."),
        "load_noData": MessageLookupByLibrary.simpleMessage("没有更多数据"),
        "network_bad": MessageLookupByLibrary.simpleMessage("当前网络状况不佳"),
        "switch_network_and_retry":
            MessageLookupByLibrary.simpleMessage("请切换网络后重试")
      };
}

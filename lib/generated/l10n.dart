// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `加载中`
  String get def_loading {
    return Intl.message(
      '加载中',
      name: 'def_loading',
      desc: '',
      args: [],
    );
  }

  /// `暂无数据`
  String get def_empty {
    return Intl.message(
      '暂无数据',
      name: 'def_empty',
      desc: '',
      args: [],
    );
  }

  /// `删除成功`
  String get def_delete_success {
    return Intl.message(
      '删除成功',
      name: 'def_delete_success',
      desc: '',
      args: [],
    );
  }

  /// `交易对`
  String get def_symbol {
    return Intl.message(
      '交易对',
      name: 'def_symbol',
      desc: '',
      args: [],
    );
  }

  /// `失败`
  String get def_failed {
    return Intl.message(
      '失败',
      name: 'def_failed',
      desc: '',
      args: [],
    );
  }

  /// `已完成`
  String get def_finish {
    return Intl.message(
      '已完成',
      name: 'def_finish',
      desc: '',
      args: [],
    );
  }

  /// `未找到页面`
  String get error_page {
    return Intl.message(
      '未找到页面',
      name: 'error_page',
      desc: '',
      args: [],
    );
  }

  /// `暂无网络，请检查网络状态`
  String get error_net {
    return Intl.message(
      '暂无网络，请检查网络状态',
      name: 'error_net',
      desc: '',
      args: [],
    );
  }

  /// `数据解析错误`
  String get error_parse {
    return Intl.message(
      '数据解析错误',
      name: 'error_parse',
      desc: '',
      args: [],
    );
  }

  /// `网络连接超时，请检查网络设置`
  String get error_connect_timeout {
    return Intl.message(
      '网络连接超时，请检查网络设置',
      name: 'error_connect_timeout',
      desc: '',
      args: [],
    );
  }

  /// `服务异常`
  String get error_server {
    return Intl.message(
      '服务异常',
      name: 'error_server',
      desc: '',
      args: [],
    );
  }

  /// `证书错误`
  String get error_ssl {
    return Intl.message(
      '证书错误',
      name: 'error_ssl',
      desc: '',
      args: [],
    );
  }

  /// `未知错误`
  String get error_unknow {
    return Intl.message(
      '未知错误',
      name: 'error_unknow',
      desc: '',
      args: [],
    );
  }

  /// `当前网络状况不佳`
  String get network_bad {
    return Intl.message(
      '当前网络状况不佳',
      name: 'network_bad',
      desc: '',
      args: [],
    );
  }

  /// `请切换网络后重试`
  String get switch_network_and_retry {
    return Intl.message(
      '请切换网络后重试',
      name: 'switch_network_and_retry',
      desc: '',
      args: [],
    );
  }

  /// `点击刷新`
  String get click_to_refresh {
    return Intl.message(
      '点击刷新',
      name: 'click_to_refresh',
      desc: '',
      args: [],
    );
  }

  /// `正在加载中...`
  String get load_loading {
    return Intl.message(
      '正在加载中...',
      name: 'load_loading',
      desc: '',
      args: [],
    );
  }

  /// `没有更多数据`
  String get load_noData {
    return Intl.message(
      '没有更多数据',
      name: 'load_noData',
      desc: '',
      args: [],
    );
  }

  /// `到底了`
  String get load_finish {
    return Intl.message(
      '到底了',
      name: 'load_finish',
      desc: '',
      args: [],
    );
  }

  /// `去充值`
  String get action_to_deposit {
    return Intl.message(
      '去充值',
      name: 'action_to_deposit',
      desc: '',
      args: [],
    );
  }

  /// `立即分享`
  String get action_quick_share {
    return Intl.message(
      '立即分享',
      name: 'action_quick_share',
      desc: '',
      args: [],
    );
  }

  /// `设置`
  String get action_set {
    return Intl.message(
      '设置',
      name: 'action_set',
      desc: '',
      args: [],
    );
  }

  /// `提醒`
  String get action_alert {
    return Intl.message(
      '提醒',
      name: 'action_alert',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

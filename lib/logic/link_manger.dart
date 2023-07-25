import 'package:bitfrog/app/default_app.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/alert_detail_page.dart';
import 'package:bitfrog/utils/log_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

///  链接  推送 banner  滚动公告 跳转
class LinkManger {
  static jump(
      {required String url,
      required int target,
      int? token,
      BuildContext? context}) {
    context ??= DefaultApp.navigatorKey.currentState!.overlay!.context;

    if (target == 1) {
      ///跳转外部浏览器
      jumpOutWebView(url);
    } else {
      /// 跳转APP内部页面
      if (url.startsWith('bitfrog://app.bitfrog.com/')) {
        schemeJumpUrl(url);
      } else {
        ///跳转内部浏览器
        jumpInWebView(context, url, "");
      }
    }
  }

  static jumpInWebView(
    BuildContext context,
    String url,
    String title, {
    int token = 1,
    bool useHtmlTitle = false,
  }) async {

    Parameters parameters = Parameters()
      ..putString("url", url)
      ..putString("title", title)
      ..putInt("token", token)
      ..putBool("useHtmlTitle", useHtmlTitle);
    Log.e(parameters.toString());
    Routers.navigateTo(context, Routers.mineWebViewCommonPage,
        parameters: parameters);
  }

  static jumpOutWebView(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {}
  }

  static jumpAppStore(){
    jumpOutWebView("https://apps.apple.com/app/bitfrog-trading-record-alert/id6446387745");
  }

  /// 跳转实盘
  static jumpFirmOfferDetail(BuildContext context, String uid,
      {String? apiId}) {
    Parameters parameters = Parameters();
    parameters.putString("uid", uid);
    parameters.putString("apiId", apiId ?? "");
    Routers.navigateTo(context, Routers.firmOfferDetail,
        parameters: parameters);
  }

  static schemeJumpUrl(String url) {
    schemeJump(Uri.parse(url));
  }

  static schemeJump(Uri uri) {
    if (uri == null) {
      return;
    }
    BuildContext context =
        DefaultApp.navigatorKey.currentState!.overlay!.context;
    Log.d('path = ${uri.path}');
    Log.d('query = ${uri.query}');
    Log.d('queryParameters = ${uri.queryParameters}');

    if(uri.queryParameters['login']  != null && uri.queryParameters['login']  == "1"){
      if(Routers.goLogin(context)) return;
    }

    switch (uri.path) {
      case '/home/mainactivity': //首页
        //tab值 live 实盘；follow 跟单；asset 资金；alert 行情；community动态
        Navigator.of(context).popUntil(ModalRoute.withName(Routers.homePage));
        String? tab = uri.queryParameters['tab'];
        String? type = uri.queryParameters['type'];
        String? index = uri.queryParameters['index'];
        Event.eventBus.fire(MainTabEvent(tab, type,index));
        // if (tab == 'live') {
        //   //实盘
        //   if (type == 'future') {
        //     //合约列表
        //   } else if (type == 'spot') {
        //     //现货列表
        //   } else if (type == 'rank') {
        //     //排行榜
        //   } else if (type == 'subscribe') {
        //     //订阅
        //   } else if (type == 'api') {
        //     //接入/管理
        //   }
        // } else if (tab == 'community') {
        //   //动态
        //   if (type == 'all') {
        //     //动态-广场-全部
        //   } else if (type == 'hot') {
        //     //动态-广场-热门
        //   } else if (type == 'quality') {
        //     //动态-广场-精华
        //   } else if (type == 'twitter') {
        //     //动态-广场-twitter
        //   } else if (type == 'follow') {
        //     //动态-广场-关注
        //   } else if (type == 'point') {
        //     //多空观点
        //   } else if ((type ?? '').startsWith('notice')) {
        //     //交易所公告
        //
        //     if ((type ?? '').startsWith('notice|')) {
        //       //交易所公告-交易所
        //       String exchange = (type ?? '').split('|')[1];
        //     }
        //   }
        // } else if (tab == 'alert') {
        //   //提醒
        //   if (type == 'config') {
        //     //提醒列表
        //     //动态-广场-全部
        //   } else if (type == 'phone') {
        //     //电话提醒
        //     //动态-广场-热门
        //   }
        // } else {
        //   //跳转主页
        // }
        break;
      case '/base/flutter':
        String? init_params = uri.queryParameters['init_params'];
        _widgetForRoute(context, init_params ?? '');
        break;
      case '/main/dryingmasteractivity': //实盘主页

        if(Routers.goLogin(context)) return;

        String? uid = uri.queryParameters['uid'];
        String? api_id = uri.queryParameters['api_id'];
        Routers.navigateTo(
          context,
          Routers.firmOfferDetail,
          parameters: Parameters()
            ..putString('uid', uid ?? '')
            ..putString('apiId', api_id ?? ''),
        );
        break;
      case '/main/dryingmasterpositionactivity': //合约仓位详情
        if(Routers.goLogin(context)) return;

        String? position_id = uri.queryParameters['position_id'];
        Parameters parameters = Parameters();
        parameters.putString("positionId", position_id ?? '');
        Routers.navigateTo(context, Routers.firmOfferPositionDetail,
            parameters: parameters);
        break;
      case '/main/messageactivity': // 消息中心
        if(Routers.goLogin(context)) return;
      //tab值 live 实盘；follow 跟单；asset 资金；alert 行情；community动态 系统消息 system
        String? tab = uri.queryParameters['tab'];
        Routers.navigateTo(context, Routers.messagePage,
            parameters: Parameters()..putString('tab', tab ?? ''));
        break;
      case '/user/loginactivity': //登录
        Routers.navigateTo(context, Routers.accountLoginPage);
        break;
      case '/user/securityactivity': //账户与安全
        if(Routers.goLogin(context)) return;
        Routers.navigateTo(context, Routers.mineAccountSafetyPage);
        break;
      case '/user/bindphoneactivity': //绑定手机
        if(Routers.goLogin(context)) return;
        Parameters parameter = Parameters();
        parameter.putBool('isEmail', false);

        parameter.putString('title',
            S.current.user_security_phone_subtitle);
        Routers.navigateTo(context, Routers.mineBindPhoneEmailPage,parameters: parameter);
        break;
      case '/main/pushsetupactivity': //推送设置
        Routers.navigateTo(context, Routers.minePushSet);
        break;
      case '/main/userinfoactivity': //个人信息
        Routers.navigateTo(context, Routers.mineInfoPage);
        break;

      case '/follow/futurefollowdetailactivity': //合约跟单计划详情
        if(Routers.goLogin(context)) return;
        String? planId = uri.queryParameters['plan_id'];
        Routers.navigateTo(context, Routers.copyTradeDetailPage,
            parameters: Parameters()..putString('planId', planId ?? ''));
        break;
      case '/follow/followbillactivity': //我的跟单-对应项目分润结算页面
        if(Routers.goLogin(context)) return;
        String? planId = uri.queryParameters['plan_id'];
        String? followId = uri.queryParameters['follow_id'];
        Routers.navigateTo(context, Routers.copyTradeIncomeFlowPage,
            parameters: Parameters()
              ..putString('followId', followId ?? '')
              ..putString('planId', planId ?? ''));
        break;
      case '/follow/masterplandetailactivity': //带单详情
        if(Routers.goLogin(context)) return;
        String? planId = uri.queryParameters['plan_id'];
        Routers.navigateTo(context, Routers.shareTradeDetailPage,
            parameters: Parameters()..putString('planId', planId ?? ''));
        break;
      case '/alert/details': //异常播报
        String? type = uri.queryParameters['type'];
        AlertShowTypes showType;
        if (type == '1') {
          //历史
          showType = AlertShowTypes.historyDetail;
        }else if (type == '2') {
            //事件
            showType = AlertShowTypes.eventDetail;
          } else if (type == '3') {
            //通知
            showType = AlertShowTypes.noticeDetail;
          }else {
          showType = AlertShowTypes.historyDetail;
        }
        String? id = uri.queryParameters['Id'];
        Routers.navigateTo(context, Routers.alertDetailPage,
            parameters: Parameters()..putString('id', id ?? '')..putObj('types', showType));
        break;

      case '/asset/assetdepositactivity': //充值
        if(Routers.goLogin(context)) return;
        Routers.navigateTo(context, Routers.assetsDeposit);
        break;

    }
  }

  static _widgetForRoute(BuildContext context, String route) {
    Log.d('init route = $route');
    if (route.contains("?")) {
      AppRouteMatch? match = Routers.router?.match(route);
      Log.d("path = ${match?.route.route}");
      Log.d("arguments = ${match?.parameters.toString()}");
      Parameters params = Parameters();
      match?.parameters.forEach((key, value) {
        params.putString(key, value[0]);
      });
      Routers.navigateTo(context, match?.route.route ?? '/',
          parameters: params);
    } else {
      Routers.navigateTo(context, route);
    }
  }
}

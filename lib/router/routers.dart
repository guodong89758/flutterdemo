import 'package:bitfrog/app/tab_bar.dart';
import 'package:bitfrog/plugin/flutter_pigeon_plugin.dart';
import 'package:bitfrog/router/i_router.dart';
import 'package:bitfrog/router/page_builder.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/ui/page/not_found_page.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../utils/log_utils.dart';

///使用fluro进行路由管理
class Routers {
  static FluroRouter? router;

  static Map<String, PageBuilder> pageRounters = {};

  static const String homePage = '/';

  /// 消息模块
  static const String messagePage = '/message';

  /// 实盘消息
  static const String liveMessagePage = '/message/live';

  /// 通用消息 type 1、跟单 2、资金
  static const String commonMessagePage = '/message/common';

  /// 动态消息
  static const String dynamicMessagePage = '/message/dynamic';

  /// 提醒列表
  static const String alertConfigPage = '/alert/config';

  /// 电话提醒
  static const String alertPhonePage = '/alert/phone';

  /// 历史提醒
  static const String alertHistoryPage = '/alert/history';

  /// 价格提醒
  static const String alertPricePage = '/alert/price';

  /// 选择交易对
  static const String alertSymbolPage = '/alert/symbol';

  /// 添加价格提醒
  static const String alertAddPricePage = '/alert/addprice';

  /// 急涨急跌页面
  static const String alertSharpPricePage = '/alert/sharpprice';

  /// 指标设置页面
  static const String alertIndexPage = '/alert/index';

  /// 历史提醒详情页面
  static const String alertDetailPage = '/alert/detail';

  /// 提醒配置详情
  static const String alertConfigDetailPage = '/alert/configDetail';

  ///信号预警
  static const String alertSignalPage = "/alert/signal";

  ///信号预警设置
  static const String alertSignalSetPage = "/alert/signalSet";

  /// 语音模块
  static const String voiceCountPage = '/voice/account';

  /// 加数据模块
  static const String voicePage = '/voice/recharge';

  /// 语音充值成功
  static const String voiceRechargeSuccessPage = '/voice/rechargeSuccess';

  /// 加数据完成
  static const String voicePageFinsh = '/voice/rechangeFinsh';

  /// 加数据详情
  static const String voicePageDetail = '/voice/rechangeDetail';

  /// 加数据记录
  static const String voiceRecord = '/voice/record';

  ///------------社区模块---------------
  /// 社区
  static const String communityPage = '/community';

  /// 社区广场列表
  static const String communityListPage = '/community/list';

  ///广场详情详情
  static const String communitySquareDetailPage = '/community/detail';

  ///添加广场详情
  static const String communityAddSquare = '/community/add';

  ///分享
  static const String commonShare = '/community/share';

  ///浏览图片
  static const String photoPreview = '/community/photoPreview';

  /// 动态新消息
  static const String communityDynamicNewMsg = "/community/dynamicNewMsg";
  /// 公告详情
  static const String communityNoticeDetail = "/community/noticeDetail";


  ///------------用户模块---------------
  ///关注用户
  static const String attentionListPage = '/user/attentionList';

  ///tiwtter
  static const String twitterViewPage = '/user/twitteriewpage';

  ///tiwtterList
  static const String attentionTiwtterPage = '/user/twitterList';

  ///黑名单用户
  static const String blackListPage = '/user/blackList';

  ///账户活动页
  static const String accountActivePage = '/user/accountActive';

  /// 登录页面
  static const String accountLoginPage = "/user/loginPage";

  /// 注册页面
  static const String accountRegisterPage = "/user/registerPage";

  /// 地区code页面
  static const String accountAreaCodePage = "/user/CountryCodePage";

  /// 验证码
  static const String verificationCodePage = "/user/verificationCodePage";

  /// 通用设置
  static const String generalSetPage = "/user/generalSetPage";

  /// 个人信息
  static const String mineInfoPage = "/user/mineInfoPage";

  /// 个人信息编辑
  static const String editTextPage = "/user/editTextPage";

  /// 账户与安全
  static const String mineAccountSafetyPage = "/user/mineAccountSafetyPage";

  /// 重置密码
  static const String mineResetPsdPage = "/user/mineResetPsdPage";

  /// 重置密码 验证码
  static const String mineResetPsdVerificationPage =
      "/user/mineResetPsdVerificationPage";

  /// 设置语言
  static const String mineLanguagePage = "/user/mineLanguagePage";

  /// 找回密码
  static const String mineFindPassWordPage = "/user/findPassWordPage";

  /// 找回密码设置新密码
  static const String mineFindPassWordSetPage = "/user/findPasswordSetPage";

  /// 找回密码验证码
  static const String multiVerificationCodePage =
      "/user/FindPsdVerificationCodePage";

  /// 绑定手机号码
  static const String mineBindPhonePage = "/user/MineBindPhonePage";

  /// 绑定手机号码或与邮箱
  static const String mineBindPhoneEmailPage = "/user/MineBindPhoneEmailPage";

  /// 绑定ga
  static const String mineBindGaPage = "/user/MineBindGaPage";

  /// 绑定gaNext
  static const String mineBindGaNextPage = "/user/MineBindGaNextPage";

  /// 计价列表
  static const String mineValuationPagee = "/user/ValuationPage";

  /// 绑定手机号码或与邮箱验证
  static const String mineBindPhoneEmailVerificationPage =
      "/user/MineBindPhoneEmailVerificationPage";

  /// webView
  static const String mineWebViewCommonPage = "webViewCommonPage";

  /// 绑定手机号码
  static const String mineRecharge = "/user/MineRecharge";

  /// 用户消息
  static const String mineMessagePage = "/user/MineMessagePage";

  /// 推送设置
  static const String minePushSet = "/user/pushSet";

  /// 联系我们
  static const String mineContactUs= "/user/contactUs";

  /// 消息通知设置
  static const String mineNotifySet = "/user/notifySet";

  ///------------------实盘模块------------
  ///凭码订阅
  static const String firmOfferOrderByCode = "/firmOffer/orderByCode";
  static const String firmOfferDetail = "/firmOffer/detail";

  ///仓位详情
  static const String firmOfferPositionDetail = "/firmOffer/positionDetail";

  ///现货仓位详情
  static const String firmOfferSpotPositionDetail =
      "/firmOffer/positionSpotDetailPage";

  ///我的实盘
  static const String firmOfferMine = "/firmOffer/minePage";

  ///实盘编辑
  static const String firmOfferEdit = "/firmOffer/edit";

  ///实盘更新API
  static const String firmOfferUpdate = "/firmOffer/update";

  ///实盘订阅码管理
  static const String firmOfferCode = "/firmOffer/code";

  ///实盘更多设置
  static const String firmOfferMoreSet = "/firmOffer/moreSet";

  ///实盘下线
  static const String firmOfferOffline = "/firmOffer/offline";

  ///------------------接入模块------------
  ///接入实盘名称
  static const String firmOfferName =
      "/firmOffer/accessFirmOffer/firmOfferName";

  ///接入实盘名页面
  static const String firmOfferAccessDetails =
      "/firmOffer/accessFirmOffer/firmOfferAccessDetails";

  /// 重置实盘
  static const String firmOfferCancellation = "/firmOffer/moreSet/cancellation";

  ///获取验证码
  static const String firmOfferCancellationCode =
      "/firmOffer/moreSet/cancellationCode";

  ///------------------资产模块------------
  ///资产-充值
  static const String assetsDeposit = "/assets/deposit";

  ///资产-提现
  static const String assetsWithdraw = "/assets/withdraw";

  ///资产-充提记录
  static const String assetsRecord = "/assets/record";

  ///资产-充提记录详情
  static const String assetsRecordDetail = "/assets/recordDetail";

  ///资产-资金记录
  static const String assetsSpotRecord = "/assets/spotRecord";

  ///资产-跟单记录
  static const String assetsFollowRecord = "/assets/followRecord";

  ///资产-二维码扫描
  static const String assetsQrcodeScanner = "/assets/qrcodeScanner";

  ///资产-分类页面
  static const String assetsClassify = "/assets/classify";

  ///资产-接入账户
  static const String accessTraderAccountPage = "/assets/accountPage";

  ///资产-划转
  static const String assetsTransfer = "/assets/transfer";
  ///资产-语音账户
  static const String assetsVoice = "/assets/voice";

  ///资产-划转记录
  static const String assetsTransferRecord = "/assets/transferRecord";

  ///选择币对
  static const String currencyChoiceSymbol = "/assets/currencyChoice";


  ///资产-资金记录
  static const String assetsApiAccountSpotRecord = "/assets/apiAccountSpotRecord";
  ///资产-合约记录
  static const String assetsApiAccountContractRecord = "/assets/apiAccountContractRecord";




  ///-----------------跟单模块------------
  /// 跟单设置
  static const String copyTradeSetPage = "/copyTrade/set";

  /// 跟单编辑
  static const String copyTradeEditPage = "/copyTrade/edit";

  /// 跟单调整
  static const String copyTradeUpdatePage = "/copyTrade/update";

  /// 跟单详情
  static const String copyTradeDetailPage = "/copyTrade/copyTradeDetail";

  /// 跟单 交易员搜索
  static const String copyTradeTraderSearchPage =
      "/copyTrade/copyTradeTraderSearch";

  /// 我的跟单详情
  static const String copyTradeMineDetailPage =
      "/copyTrade/copyTradeMineDetail";

  /// 资金流水
  static const String copyTradeIncomeFlowPage = "/copyTrade/incomeFlowPage";

  /// 历史仓位
  static const String copyTradeHistoryPositionPage =
      "/copyTrade/historyPositionPage";

  ///------------------------带单模块-----------------
  /// 带单详情
  static const String shareTradeDetailPage = "/shareTrade/detailPage";

  /// 分润数据
  static const String shareProfitPage = "/shareTrade/shareProfitPage";

  /// 历史仓位
  static const String shareTradeHistoryPositionPage =
      "/shareTrade/historyPositionPage";

  /// 跟随者
  static const String shareTradeFollowerPage = "/shareTrade/followerPage";

  /// 交易模块
  /// 合约-偏好设置
  static const String tradeConfig = "/trade/config";
  /// 合约-下单确认
  static const String tradeOrderConfirm = "/trade/orderConfirm";
  /// 合约-仓位模式
  static const String tradePositionMode = "/trade/positionMode";
  /// 合约-资产模式
  static const String tradeAssetMode = "/trade/assetMode";
  /// K线图
  static const String tradeKLine = "/trade/kLinePage";
  /// 合约-历史委托、资金流水
  static const String tradeContractHistory = "/trade/contractHistory";
  /// 合约-订单详情
  static const String tradeContractOrderDetail = "/trade/contractOrderDetail";
  /// 币对选择
  static const String tradeSymbol = "/trade/symbol";
  /// 现货-历史委托
  static const String tradeSpotOrderHistory = "/trade/spotOrderHistory";
  /// 现货-订单详情
  static const String tradeSpotOrderDetail = "/trade/SpotOrderDetail";

  static void init(List<IRouter> listRouter) {
    router = FluroRouter();
    configureRoutes(router!, listRouter);
  }

  ///路由配置
  static void configureRoutes(FluroRouter router, List<IRouter> listRouter) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const NotFoundPage();
    });

    PageBuilder homePageBuilder = PageBuilder(Routers.homePage, (params) {
      return TabIndex();
    });

    router.define(Routers.homePage, handler: homePageBuilder.handler);
    listRouter.forEach((routerImpl) {
      List<PageBuilder> pages = routerImpl.getPageBuilders();
      pages.forEach((page) {
        router.define(page.path, handler: page.handler);
        pageRounters[page.path] = page;
      });
    });
  }

  /**
   * 生成对应的page
   */
  static Widget? generatePage(BuildContext context, String path,
      {Parameters? parameters}) {
    PageBuilder? pageBuilder = pageRounters[path];
    if (pageBuilder != null) {
      pageBuilder.parameters = parameters ?? Parameters();
      return pageBuilder.handler!.handlerFunc(context, {});
    } else {
      return router!.notFoundHandler!.handlerFunc(context, {});
    }
  }

  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配(https://www.jianshu.com/p/e575787d173c)
  static Future navigateTo(BuildContext context, String path,
      {Parameters? parameters,
      bool clearStack = false,
        bool replace = false,
      TransitionType transition = TransitionType.native}) {
    var pageBuilder = pageRounters[path];
    if (pageBuilder != null) {
      pageBuilder.parameters = parameters ?? Parameters();
    }

    if (path == Routers.commonShare) {
      /// 分享页面设置
      transition = TransitionType.nativeModal;
    }

    return router!.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack, transition: transition);
  }

  static void navigateToResult(
      BuildContext context, String path, Function(Object) function,
      {Parameters? parameters,
      bool clearStack = false,
      TransitionType transition = TransitionType.cupertino}) {
    unfocus();
    navigateTo(context, path,
            parameters: parameters,
            clearStack: clearStack,
            transition: transition)
        .then((Object? result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((dynamic error) {
      Log.e('$error');
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    unfocus();
    ToastUtil.cancelToast();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, Object result) {
    unfocus();
    Navigator.pop<Object>(context, result);
  }

  static void unfocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }

  ///
  static void goFlutterContainerPage(
      String routerPath, Map<String, String>? params, BuildContext context) {
    /// 不使用原声容器打开flutter页面 方便热加载调试
    Parameters paramsData = Parameters();
    params?.forEach((key, value) {
      paramsData.putString(key, value);
    });
    Routers.navigateTo(context, routerPath, parameters: paramsData);
  }

  static void backFlutterContainerPage(BuildContext context) {
    Routers.goBack(context);
  }

  /// 判断是否要去登录 如果要登录返回true
  static bool goLogin(BuildContext context, {Function? beforeNav}) {
    bool isLogin = FlutterPigeonPlugin.instance.isLogin();
    if (!isLogin) {
      beforeNav?.call();

      ///没有登录 去登录界面
      Routers.navigateTo(context, Routers.accountLoginPage);
    }
    // ToastUtil.show("判断是否去登陆:${isLogin}");
    return !isLogin;
  }
}

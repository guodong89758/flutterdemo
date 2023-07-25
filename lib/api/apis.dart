// ignore_for_file: constant_identifier_names

class Apis {
  /// 消息列表
  static const String commonConfigIndex = '/app/common/config/index';
  /// 消息石=是否有已读
  static const String messageRedPointStatus = '/app/alarm/user/redPointStatus';

  /// 消息确认已读
  static const String messageRedPointDisappear = '/app/alarm/user/redPointDisappear';

  /// 消息列表
  static const String MESSAGE_LIST = '/app/alarm/user/messageList';

  /// 提醒列表
  static const String ALERT_CONFIG_LIST = '/app/alarm/user/noticeTypes';
  /// 电话提醒列表
  static const String ALERT_SUBSCRIBE_ITEMS = '/app/alarm/user/subscribeItems';
  /// 设置电话提醒状态【开启&关闭】
  static const String ALERT_UPDATE_VOICE_REMIND_SWITCH = '/app/alarm/user/updateVoiceRemindSwitch';
  /// 获取用户设置的价格提醒
  static const String ALERT_PRICE_TRIGGER_ITEMS = '/app/alarm/price/triggerItems';
  /// 获取价格提醒历史
  static const String ALERT_PRICE_TRIGGER_HISTORY = '/app/alarm/price/triggerHistory';
  /// 获取交易对列表
  static const String ALERT_SYMBOL_SEARCH = '/app/common/symbol/search';
  /// 获取交易对价格
  static const String ALERT_SYMBOL_PRICE = '/app/common/symbol/price';
  /// 获取价格提醒支持的提醒方式
  static const String ALERT_PRICE_CHANNELS = '/app/alarm/price/channels';
  /// 新增价格提醒
  static const String ALERT_PRICE_TRIGGER_SET = '/app/alarm/price/triggerSet';
  /// 删除价格提醒
  static const String ALERT_PRICE_DELETE_TRIGGER = '/app/alarm/price/deleteTrigger';
  /// 获取急涨急跌交易对
  static const String ALERT_PRICE_EXCEPTION_SYMBOL = '/app/alarm/price/exceptionSymbols';
  /// 设置急涨急跌交易对
  static const String ALERT_PRICE_EXCEPTION_MONITOR_SET = '/app/alarm/price/exceptionMonitorSet';
  /// 获取某个指标下的可设置提醒交易对
  static const String ALERT_INDICATOR_SYMBOLS = '/app/alarm/indicator/symbols';
  /// 设置指标提醒
  static const String ALERT_INDICATOR_SET = '/app/alarm/indicator/set';
  /// 历史提醒列表
  static const String ALERT_MARKET_HISTORY = '/app/alarm/user/marketHistory';
  // /// 历史提醒详情
  // static const String ALERT_DETAIL = '/app/alarm/user/detail';
  /// 历史提醒详情
  static const String ALERT_DETAIL = '/app/notify/subscribe/historyDetail';

  /// 事件详情
  static const String ALERT_EVENT_DETAIL = '/app/notify/subscribe/eventDetail';

  /// 公告详情
  static const String ALERT_NOTICE_DETAIL = '/app/square/notice/detail';


  /// 语音加数据配置
  static const String VOICE_DEPOSIT_CONFIG =
      '/app/alarm/user/voiceDepositConfig';

  /// 语音加数据记录
  static const String VOICE_DEPOSIT_RECORD = '/app/alarm/user/voiceLedgers';

  ///语音加数据记录详情
  static const String VOICE_DETAILS = '/app/alarm/user/voiceLedgerDetail';

  ///语音加数据余额
  static const String VOICE_AMOUNT = '/app/alarm/user/voiceAmount';

  ///现货余额
  static const String VOICE_SPORT = '/app/contract/finance/balance';
///获取绑定方式
  static const String VOICE_AUTHINFO = '/app/user/security/authInfo';


  /// 电话推送信息
  static const String voiceTestShowNumber = "/app/alarm/user/voiceTestShowNumber";
  /// 电话推送测试
  static const String voiceTest = "/app/alarm/user/voiceTest";
  /// 推送设置配置
  static const String alarmUserConfig = "/app/alarm/user/config";
  /// 推送设置
  static const String alarmUserSetConfig = "/app/alarm/user/setConfig";
  /// 推送测试
  static const String alarmUserPushTest = "/app/alarm/user/PushTest";




  ///----------------------社区模块------------------
   ///多空观点列表
  static const String communityOpinion = '/app/square/point/list';
  ///多空观点每天汇总
  static const String communityOpinionDateSummary = '/app/square/point/dateSummary';
  ///多空观点点赞/取消点赞
  static const String communityOpinionLike = '/app/square/point/like';

  ///交易所公告分类
  static const String communityNoticeClassify = '/app/square/notice/exchangeList';
  ///交易所公告列表
  static const String communityNotice = '/app/square/notice/index';

  ///新动态消息列表
  static const String communityNewDynamic = '/app/square/Interact/list';
  ///新动态消息通知
  static const String communityNewDynamicNotice = '/app/square/Interact/cnt';

  ///社区公告
  static const String communityNewNotice = '/app/common/config/announce';

  ///用户拉黑
  static const String communitySquareUserBlack = '/app/square/block/set';
  ///用户关注
  static const String communitySquareUserFollow = '/app/square/follow/follow';
  ///用户取消关注
  static const String communitySquareUserFollowCancel = '/app/square/follow/cancelFollow';

  ///广场列表

  static const String communitySquareList = '/app/square/analysis/index';
  ///广场列表帖子详情
  static const String communitySquareDetail = '/app/square/analysis/show';

  ///广场列表帖子点赞
  static const String communitySetLike = '/app/square/analysis/attitude';
  ///帖子投诉
  static const String communitySquarePostReport = '/app/square/analysis/complain';
  ///帖子删除
  static const String communitySquarePostDelete = '/app/square/analysis/destroy';

  ///广场评论列表
  static const String communitySquareCommentList = '/app/square/comment/index';
  ///广场发表评论
  static const String communitySquareComment = '/app/square/comment/store';
  ///广场删除评论
  static const String communitySquareCommentDelete = '/app/square/comment/destroy';



  ///广场评论回复列表
  static const String communitySquareCommentReplayList = '/app/square/comment/replyList';

  /// 上传图片
  static const String uploadImage = "/app/user/home/upLoadImg";
  /// 发布动态
  static const String publishDynamic = "/app/square/analysis/store";


  ///----------------------用户模块------------------
  /// 账户活动列表
  static const String userAcountActive = "/app/user/security/accountActive";
  /// 关注列表
  static const String userFollowList = "/app/square/follow/followList";
  /// 用户拉黑列表
  static const String blackList = "/app/square/block/list";
  ///登录 (账号密码)
  static const String loginAccount = "/app/user/login/account";
  ///退出登录
  static const String loginLogout = "/app/user/login/logout";
  ///获取极验信息
  static const String geetest = "/app/common/verify/geetest";
  ///获取地区code
  static const String countryCode = "/app/common/info/areas";
  ///获取验证码
  static const String verification = "/app/common/verify/getCode";

  ///获取用户信息
  static const String userInfo = "/app/user/home/index";
  ///获取用户鉴权信息
  static const String userAuthInfo = "/app/user/security/authInfo";
  ///修改用户信息
  static const String userInfoEdit = "/app/user/home/updateUser";
  ///重置密码 验证旧密码
  static const String comparePassword = "/app/user/security/comparePassword";
  ///重置密码
  static const String resetPassword = "/app/user/security/resetPassword";
  ///注销用户
  static const String logoffUser = "/app/user/security/logoff";
  ///注册手机
  static const String registerMobile = "/app/user/register/mobile";
  ///注册邮箱
  static const String registerEmail = "/app/user/register/email";
  ///获取绑定状态
  static const String bindStatus = "/app/user/security/bindStatus";
  ///找回密码 设置密码
  static const String findPadSetPassword = "/app/user/security/setpassword";
  ///找回密码 忘记密码验证
  static const String forgetVerify = "/app/user/security/forgetVerify";
  ///绑定手机 检查 手机号码是否绑定
  static const String checkMobile = "/app/user/security/checkMobile";

  ///绑定邮箱 检查 邮箱是否绑定
  static const String checkEmail = "/app/user/security/checkEmail";

  ///绑定手机
  static const String bindMobile = "/app/user/security/bindMobile";

  ///获取GA秘钥
  static const String getGaSecret = "/app/user/security/getGaSecret";

  ///绑定Ga
  static const String bindGa = "/app/user/security/bindGA";

  ///计价列表
  static const String currencyList = "/app/common/config/currencyList";
  ///计价设置
  static const String currencysetUnit = "/app/common/config/setUnit";


  ///充币地址
  static const String depositAddress = "/app/contract/finance/depositAddress";
  ///充币币种
  static const String depositCurrencyList = "/app/contract/finance/depositCurrencyList";
  ///充币网络 币种须知
  static const String depositCurrencyChains = "/app/contract/finance/depositCurrencyChains";
  ///充币 历史记录
  static const String depositWithdrawHistory = "/app/contract/finance/depositWithdrawHistory";

  ///语音支付
  static const String addVoiceBalance = "/app/alarm/user/addVoiceBalance";

  ///-------------实盘---------------
  ///实盘合约列表
  static const String firmOfferContractList = "/app/live/square/timeline";
  ///实盘合约列表搜索
  static const String firmOfferContractListSearch = "/app/live/square/search";
  ///实盘合约Banner
  static const String firmOfferContractBanner = "/app/common/config/banner";
  ///实盘合约广场
  static const String firmOfferContractAnnounce = "/app/common/config/announce";
  ///订阅实盘免费
  static const String firmOfferOrderFree = "/app/live/api/subscribe";
  ///订阅实盘凭订阅码
  static const String firmOfferOrderByCode = "/app/user/subscribe/code";
  ///订阅实盘订阅码详情
  static const String firmOfferOrderByCodeDetail = "/app/user/subscribe/detail";
  ///获取消息推送提醒方式
  static const String remindChannels = "/app/alarm/user/channels";
  ///取消订阅实盘
  static const String firmOfferOrderCancel = "/app/user/subscribe/cancel";
  ///设置提醒方式
  static const String firmOfferApiAlarmSet = "/app/alarm/user/userApiAlarmSet";


  ///历史持仓
  static const String positionHistory = "/app/live/position/history";
  ///当前持仓
  static const String positionHold = "/app/live/position/hold";
  ///持仓详情
  static const String positionDetail = "/app/live/position/detail";
  ///实盘交易数据
  static const String firmOfferMineTransaction = "/app/live/api/trade";
  ///实盘持仓概况
  static const String positionGeneral = "/app/live/position/futurelist";
  ///我的实盘收益日历
  static const String firmOfferProfitCalendar = "/app/live/api/profitCalendar";
  ///现货仓位详情
  static const String firmOfferSpotDetail = "/app/live/position/spotDetail";

  ///现货仓位详情仓位持仓数据
  static const String firmOfferSpotDetailAssetDistribution = "/app/live/position/assetDistribution";




  ///实盘-排行榜列表
  static const String liveApiRank = "/app/live/api/rank";
  ///用户接入过的实盘列表
  static const String liveApiList = "/app/live/api/list";
  ///实盘设置详情
  static const String liveApiDetail = "/app/live/api/detail";
  ///实盘资产详情
  static const String liveApiOverview = "/app/live/api/overview";
  ///实盘一键上线
  static const String liveApiOnline = "/app/live/api/online";
  ///实盘权限设置
  static const String liveApiSubscribeConf = "/app/live/api/subscribeConf";
  ///实盘编辑
  static const String liveApiRename = "/app/live/api/rename";
  ///实盘更新API
  static const String liveApiUpdate = "/app/live/api/update";
  ///实盘下线
  static const String liveApiOffline = "/app/live/api/offline";
  ///实盘订阅码列表
  static const String userSubscribeList = "/app/user/subscribe/list";
  ///实盘-停用订阅码
  static const String userSubscribeDisable = "/app/user/subscribe/disable";
  ///实盘-生成订阅码
  static const String userSubscribeCreate = "/app/user/subscribe/create";

  ///实盘用户详情
  static const String liveUserInfo = "/app/live/user/info";
  ///实盘最新操作
  static const String livePositionRecords = "/app/live/position/records";
  ///实盘现货最新操作
  static const String livePositionRecordsSpot = "/app/live/position/spotRecords";
  /// 实盘收益走势
  static const String liveProfitTrend = "/app/live/api/profitLiveCDN";
  /// 实盘收益信息
  static const String liveProfitInfo = "/app/live/api/profitLiveInfo";

  ///用户可以接入的交易所
  static const String liveApiExchanges = "/app/live/api/exchanges";
  ///交易员可以接入账户配置
  static const String accessApiConfig = "/app/trade/common/accessApiConfig";
  ///交易员接入账户
  static const String tradeAccessApi = "/app/trade/common/accessApi";

  ///设置实盘
  static const String liveApiAccess = "/app/live/api/set";
  ///获取绑定的邮箱和手机章台
  static const String userauthInfo = "/app/user/security/authInfo";
  ///登录状态获取验证码
  static const String userauthInfoCode = "/app/common/verify/getUserCode";
  ///绑定邮箱
  static const String userBindEmail = "/app/user/security/bindEmail";

  ///验证验证码
  static const String usercheckCode = "/app/common/verify/checkCode";
  ///注销和重置实盘
  static const String firmModify = "/app/live/api/modify";

  ///获取手机号和邮箱
  static const String bindStatusInfo = "/app/user/security/bindStatus";


  /// 实盘 -----订阅
  /// 订阅列表
  static const String firmOfferSubscriptionList = "/app/live/user/subscribelist";

  static const String firmOfferOverviewBatchList = "/app/live/user/overviewBatch";

  static const String firmOfferOverviewSituation = "/app/user/home/situation";

  ///资产
  ///资产总览
  static const String financeBalance = '/app/contract/finance/balance';
  ///资产-币种列表
  static const String financeDepositCurrencyList = '/app/contract/finance/depositCurrencyList';
  ///资产-充值币种网络+币种须知
  static const String financeDepositCurrencyChains = '/app/contract/finance/depositCurrencyChains';
  ///资产-充值信息
  static const String financeDepositAddress = '/app/contract/finance/depositAddress';
  ///资产-提现-币种网络+币种须知
  static const String financeWithdrawNetwork = '/app/contract/finance/withdrawNetwork';
  ///资产-提现
  static const String financeWithdrawApply = '/app/contract/finance/withdrawApply';
  ///资产-充提记录
  static const String financeDepositWithdrawHistory = '/app/contract/finance/depositWithdrawHistory';
  ///资产-提币-撤销提币
  static const String financeCancelWithdraw = '/app/contract/finance/cancelWithdraw';
  ///资产-财务记录-资金账户流水类型
  static const String financeSpotLedgerType = '/app/contract/finance/spotLedgerType';
  ///资产-财务记录-资金账户流水
  static const String financeSpotLedger = '/app/contract/finance/spotLedger';
  ///资产-财务记录-跟单账户流水类型
  static const String financeFollowLedgerType = '/app/contract/finance/followLedgerType';
  ///资产-财务记录-跟单账户流水
  static const String financeFollowLedger = '/app/contract/finance/followLedger';

  ///资产-划转交易对
  static const String transferCurrencies = '/app/trade/account/assetList';

  /// 划转记录币对
  static const String transferSymbolCurrencies = '/app/trade/transfer/currencies';
  ///资产-划转
  static const String transferApply = '/app/trade/transfer/apply';

  ///资产-划转选择api
  static const String transferAccountList = '/app/trade/common/accountList';

  ///TradingView
  static const String tradingConfig = 'app/notify/tv/config';
  ///TradingViewList
  static const String tradingConfigHistory = 'app/notify/tv/history';

  ///TradingView设置
  static const String tradingSetTrigger= 'app/notify/tv/setTrigger';

  ///推特数据
  static const String twitterList = '/app/square/twitter/list';
  ///推特推送设置
  static const String twitterUpdateConfig = '/app/square/twitter/updateConfig';

  ///推特推送自主关注
  static const String twitterFollow = '/app/square/twitter/follow';

  ///推特推送搜索
  static const String twitterSearch = '/app/square/twitter/search';


  ///----------获取下发域名的地址--------
  /// iOS
  static const String domainIOS1  = "https://s2.myaqi.cn/domain/iosconfig";
  static const String domainIOS2  = "https://cdn.myaqi.cn/domain/iosconfig";
  /// 安卓
  static const String domainAndroid1  = "https://s2.myaqi.cn/domain/androidconfig";
  static const String domainAndroid2  = "https://cdn.myaqi.cn/domain/androidconfig";
  /// 是否升级
  static const String infoUpgrade = "/app/common/info/upgrade";



  ///--------行情页面H5地址---------
  ///全网爆仓统计
  static const String marketLiquidationData = "https://wx.longvi.cc/market/liquidationData";
  ///全网持仓统计
  static const String marketOpenInterest = "https://wx.longvi.cc/market/openInterest";
  ///资金费率
  static const String marketCapitalRate = "https://wx.longvi.cc/market/capitalRate";
  ///USDT价格
  static const String marketUsdtPrice = "https://wx.longvi.cc/market/usdtPrice";




  static const String mineContactUs = '/app/common/config/contactUs';



}

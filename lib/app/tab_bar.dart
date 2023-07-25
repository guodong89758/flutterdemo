import 'dart:async';

import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/community_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/event/firm_offer_event.dart';
import 'package:bitfrog/event/follow_event.dart';
import 'package:bitfrog/event/trade_event.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/logic/app_config_manager.dart';
import 'package:bitfrog/logic/jpush_manger.dart';
import 'package:bitfrog/logic/master_apply_manger.dart';
import 'package:bitfrog/logic/permission_manger.dart';
import 'package:bitfrog/logic/umeng_manager.dart';
import 'package:bitfrog/logic/upgrade_manger.dart';
import 'package:bitfrog/plugin/flutter_pigeon_plugin.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/community/community_index_page.dart';
import 'package:bitfrog/ui/page/copyTrade/copy_trade_page.dart';
import 'package:bitfrog/ui/page/firmOffer/firm_offer_page.dart';
import 'package:bitfrog/ui/page/market/market_page.dart';
import 'package:bitfrog/ui/page/mine/mine_page.dart';
import 'package:bitfrog/ui/page/mine/viewModel/user_manger_model.dart';
import 'package:bitfrog/ui/page/transaction/contract_symbol_page.dart';
import 'package:bitfrog/ui/page/transaction/spot_symbol_page.dart';
import 'package:bitfrog/ui/page/transaction/theme/symbol_light_theme.dart';
import 'package:bitfrog/ui/page/transaction/transaction_page.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/app_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TabIndex extends StatefulWidget {
  const TabIndex({super.key});

  @override
  State<TabIndex> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabIndex> with TickerProviderStateMixin {
  int _currentIndex = 0;
  StreamSubscription? _reLoginEventSubscription;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  ValueNotifier<String> tradeTypeNotifier = ValueNotifier('');

  /// 底部Item的动画，数组长度与底部按钮数量一致，需要一一对应
  late final List<AnimationController> _animationControllers =
      List.generate(6, (index) {
    return AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  });

  late final List<Animation<double>> _animations = List.generate(6, (index) {
    final controller = _animationControllers[index];

    /// 多个缩放点的缩放动画
    List values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0];
    double preValue = 1.0;
    List<TweenSequenceItem<double>> tweenItems = [];
    for (int i = 0; i < values.length; i++) {
      if (i != 0) {
        tweenItems.add(TweenSequenceItem<double>(
          tween: Tween(begin: preValue, end: values[i]),
          weight: 1,
        ));
      }
      preValue = values[i];
    }
    return TweenSequence<double>(tweenItems).animate(controller);
  });

  void _runAnim(int index) {
    try {
      final animationController = _animationControllers[index];
      animationController.reset();
      animationController.forward();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// 获取交易员申请状态
  getMasterApplyStatus() {
    MasterApplyManager.instance.requestMaster();
  }

  /// 检查更新
  getUpgrade() {
    UpgradeManager.instance.requestUpgrade();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        AppConfigManager.instance.getAppConfigFromServer();
        requestPermission();
        JPushManger.instance.launchAppNotification();
      }
    });
    Event.eventBus.on<MainTabEvent>().listen((event) {
      if (event.tab == 'alert') {
        setState(() {
          _currentIndex = 0;
        });
        Future.delayed(const Duration(milliseconds: 200)).then((value) {
          Event.eventBus.fire(AlertTabEvent(event.type,event.index));
        });
      } else if (event.tab == 'live') {
        setState(() {
          _currentIndex = 1;
        });
        Future.delayed(const Duration(milliseconds: 200)).then((value) {
          Event.eventBus.fire(FirmOfferTabEvent(event.type));
        });
      } else if (event.tab == 'follow') {
        setState(() {
          _currentIndex = 2;
        });
        Future.delayed(const Duration(milliseconds: 200)).then((value) {
          Event.eventBus.fire(FollowTabEvent(event.type));
        });
      } else if (event.tab == 'community') {
        setState(() {
          _currentIndex = 3;
        });
        Future.delayed(const Duration(milliseconds: 200)).then((value) {
          Event.eventBus.fire(CommunityTabEvent(event.type));
        });
      } else if (event.tab == 'asset') {
        setState(() {
          _currentIndex = 4;
        });
      }
    });
    Event.eventBus.on<TradeSymbolEvent>().listen((event) {
      tradeTypeNotifier.value = event.type ?? '';
      _scaffoldKey.currentState?.openDrawer();
    });

    /// 需要重新登陆
    _reLoginEventSubscription =
        Event.eventBus.on<NeedLoginEvent>().listen((event) {
      if (mounted) {
        final userMangerProvider = context.read<UserMangerProvider>();
        // 仅在已登录的情况下才重新登陆
        if (userMangerProvider.getIsLogin()) {
          userMangerProvider.loginOut();
          Navigator.pushNamedAndRemoveUntil(
              context, Routers.accountLoginPage, ModalRoute.withName("/"));
          // 仅响应一次
          _reLoginEventSubscription?.cancel();
        }
      }
    });
    getMasterApplyStatus();
    getUpgrade();

    FlutterPigeonPlugin.instance.startDaemonService('true');
  }

  void requestPermission() async {
    // if (DeviceUtil.isAndroid) {
    //   await Permission.notification.request();
    // }

    PermissionManger.requestPermissionNotification();
  }

  @override
  void dispose() {
    _reLoginEventSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context);
    UserMangerProvider userMangerProvider =
        Provider.of<UserMangerProvider>(context, listen: true);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colours.white,
        shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        ),
        child: SafeArea(
          child: ValueListenableBuilder<String>(valueListenable: tradeTypeNotifier,
            builder: (BuildContext context, String value, Widget? child){
            return value == Config.tradeSpot
                ? SpotSymbolPage(theme: SymbolLightTheme())
                : ContractSymbolPage(theme: SymbolLightTheme());
          }),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            MarketPage(
              userMangerProvider: userMangerProvider,
            ),
            FirmOfferPage(userMangerProvider: userMangerProvider),
            CopyTradePage(userMangerProvider: userMangerProvider),
            const CommunityIndexPage(),
            // userMangerProvider.isLogin ? const AssetsPage() : Container(),
            TransactionPage(userMangerProvider: userMangerProvider,),
            const MinePage(),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedLabelStyle:
            TextStyle(color: Colours.text_color_2, fontSize: 10.sp),
        selectedLabelStyle: TextStyle(color: Colours.def_red, fontSize: 10.sp),
        unselectedItemColor: Colours.text_color_2,
        selectedItemColor: Colours.app_main,
        onTap: (index) {

          switch(index){
            case 0:
              UmengManager.instance.clickStatistics(UmengEvent.active_Portfolios_user);
              break;
            case 1:
              UmengManager.instance.clickStatistics(UmengEvent.active_copytrade_user);
              break;
            case 2:
              UmengManager.instance.clickStatistics(UmengEvent.active_remind_user);
              break;
            case 3:
              UmengManager.instance.clickStatistics(UmengEvent.active_dynamic_user);
              break;
          }


          if (index == 4) {
            // if (Routers.goLogin(context)) return;
          }

          if (index == 5) {
            if (FlutterPigeonPlugin.instance.isLogin()) {
              userMangerProvider.getUserInfo();
              Event.eventBus.fire(NewsIsRedEvent());
            }
          }
          setState(() {
            _currentIndex = index;
          });
          _runAnim(index);
          getMasterApplyStatus();
          getUpgrade();
        },
        type: BottomNavigationBarType.fixed,
        items: [
          AppBottomNavigationBarItem(
            icon: Image.asset(
              Assets.imagesTabRemindN,
              width: ScreenHelper.width(30),
              height: ScreenHelper.width(30),
            ),
            activeIcon: Image.asset(
              Assets.imagesTabRemindS,
              width: ScreenHelper.width(30),
              height: ScreenHelper.width(30),
            ),
            label: S.current.main_tab_alert,
            animation: _animations[0],
          ),
          AppBottomNavigationBarItem(
            icon: Image.asset(
              Assets.imagesTabFirmOfferN,
              width: ScreenHelper.width(30),
              height: ScreenHelper.width(30),
            ),
            activeIcon: Image.asset(
              Assets.imagesTabFirmOfferS,
              width: ScreenHelper.width(30),
              height: ScreenHelper.width(30),
            ),
            label: S.current.main_tab_live_name,
            animation: _animations[1],
          ),
          AppBottomNavigationBarItem(
            icon: Image.asset(
              Assets.imagesTabCopyTradeN,
              width: ScreenHelper.width(30),
              height: ScreenHelper.width(30),
            ),
            activeIcon: Image.asset(
              Assets.imagesTabCopyTradeS,
              width: ScreenHelper.width(30),
              height: ScreenHelper.width(30),
            ),
            label: S.current.main_tab_follow,
            animation: _animations[2],
          ),
          AppBottomNavigationBarItem(
            icon: Image.asset(
              Assets.imagesTabDynmicN,
              width: ScreenHelper.width(30),
              height: ScreenHelper.width(30),
            ),
            activeIcon: Image.asset(
              Assets.imagesTabDynmicS,
              width: ScreenHelper.width(30),
              height: ScreenHelper.width(30),
            ),
            label: S.current.main_tab_circle_name,
            animation: _animations[3],
          ),
          AppBottomNavigationBarItem(
            icon: Image.asset(
              Assets.imagesTabTransactionN,
              width: ScreenHelper.width(30),
              height: ScreenHelper.width(30),
            ),
            activeIcon: Image.asset(
              Assets.imagesTabTransactionS,
              width: ScreenHelper.width(30),
              height: ScreenHelper.width(30),
            ),
            label: "交易",
            animation: _animations[4],
          ),
          AppBottomNavigationBarItem(
            icon: Image.asset(
              Assets.imagesTabMineN,
              width: ScreenHelper.width(30),
              height: ScreenHelper.width(30),
            ),
            activeIcon: Image.asset(
              Assets.imagesTabMineS,
              width: ScreenHelper.width(30),
              height: ScreenHelper.width(30),
            ),
            label: S.current.main_tab_me_name,
            animation: _animations[5],
          ),
        ],
      ),
    );
  }
}

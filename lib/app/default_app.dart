import 'dart:async';
import 'dart:io';
import 'package:bitfrog/app/build_config.dart';
import 'package:bitfrog/app/route_observer.dart';
import 'package:bitfrog/app/tab_bar.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/constant/langue.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/logic/jpush_manger.dart';
import 'package:bitfrog/logic/link_manger.dart';
import 'package:bitfrog/logic/umeng_manager.dart';
import 'package:bitfrog/plugin/flutter_pigeon_plugin.dart';
import 'package:bitfrog/provider/locale_provider.dart';
import 'package:bitfrog/provider/theme_provider.dart';
import 'package:bitfrog/router/alert_router.dart';
import 'package:bitfrog/router/assets_router.dart';
import 'package:bitfrog/router/community_router.dart';
import 'package:bitfrog/router/copy_trade_router.dart';
import 'package:bitfrog/router/financial_router.dart';
import 'package:bitfrog/router/firm_offer_router.dart';
import 'package:bitfrog/router/message_router.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/router/transaction_router.dart';
import 'package:bitfrog/router/user_router.dart';
import 'package:bitfrog/ui/page/mine/viewModel/user_manger_model.dart';
import 'package:bitfrog/utils/device_util.dart';
import 'package:bitfrog/utils/handle_error_utils.dart';
import 'package:bitfrog/utils/log_utils.dart';
import 'package:bitfrog/utils/refresh_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:bitfrog/utils/user_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uni_links/uni_links.dart';


class DefaultApp {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 运行APP
  static Future<void> run(Flavor flavor) async {

    buildConfig.flavor = flavor;

    /// 确保初始化完成
   final binding =  WidgetsFlutterBinding.ensureInitialized();
    // 选择图片后返回状态栏颜色会发生变化，此处设置不自动变更
    binding.renderView.automaticSystemUiAdjustment = false;

    await initApp();
    await JPushManger.instance.initPlatform();
    UmengManager.instance.initUmeng();
    handleError(() => runApp(const MyApp()));
  }

  /// 应用初始化操作
  static Future<void> initApp() async {
    //日志初始化
    Log.init();
    if (DeviceUtil.isAndroid) {
      // 透明状态栏
      const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    SystemChrome.setPreferredOrientations([
      // 强制竖屏
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    //缓存初始化
    // SharedPreferences.setMockInitialValues({});
    await SpUtil.getInstance();

    await FlutterPigeonPlugin.instance.initConfig();

  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); //添加观察者
    late String? Valuation = UserUtil.getUserValuation() ?? '';




    if (Valuation.length <= 0) {
      UserUtil.saveUserValuation("USD");
    }

    Routers.init([
      AlertRouter(),
      MessageRouter(),
      FinancialRouter(),
      CommunityRouter(),
      UserRouter(),
      FirmOfferRouter(),
      CopyTradeRouter(),
      AssetsRouter(),
      TransactionRouter()
    ]);
    initUniLink();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this); //销毁
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      JPushManger.isAppBackground = false;
    } else if (state == AppLifecycleState.paused) {
      JPushManger.isAppBackground = true;
      JPushManger.instance.clearAllBadge();  /// 应用从后台进入前台  清空红点角标
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget3(
      model1: ThemeProvider(),
      model2: LocaleProvider(
          UserUtil.getCurrentLanguage() ?? LanguageManger.defaultLanguage),
      model3: UserMangerProvider(),
      // model2: LocaleProvider(
      //     SpUtil.getString(Config.KEY_APP_LOCALE, defValue: 'zh')!),
      builder: (context,
          ThemeProvider themeProvider,
          LocaleProvider localeProvider,
          UserMangerProvider userMangerProvider,
          _) {
        // Log.d('init route = ${window.defaultRouteName}');

        Widget child = MaterialApp(
          home: TabIndex(),
          navigatorKey: DefaultApp.navigatorKey,
          theme: themeProvider.getThemeData(),
          color: Colors.white,
          darkTheme: themeProvider.getThemeData(isDarkMode: true),
          onGenerateRoute: Routers.router!.generator,
          navigatorObservers: [
            AppRouteObserver.instance.routeObserver
          ],
          locale: localeProvider.getLocale(),
          localizationsDelegates: const [
            S.delegate,
            RefreshLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            if (localeProvider.getLocale() != null) {
              //如果已经选定语言，则不跟随系统
              return localeProvider.getLocale();
            } else {
              //跟随系统
              if (locale!=null && S.delegate.isSupported(locale)) {
                Log.e("跟随系统:${locale.toString()}");
                LanguageManger.instance.setSystemLanguage(locale.toString());
                if(LanguageManger.instance.currentLanguage == LanguageManger.zhTW){
                  return  const Locale('zh', 'TW');
                }
                return locale;
              }
              // return supportedLocales.first;
              UserUtil.saveCurrentLanguage(LanguageManger.en);
              return const Locale('en', 'US');
            }
          },
          builder: (BuildContext context, Widget? child) {
            ScreenHelper.init(context);
            return MediaQuery(
              //设置文字大小不随系统设置改变
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
        );

        // return child;

        return ToastUtil.init(RefreshUtil.init(child));
      },
    );
  }

  Future<void> initUniLink() async {
    // App未打开的状态在这个地方捕获scheme
    try {
      final initialLink = await getInitialUri();
      Log.d('initial link: $initialLink');

      if (initialLink != null) {
        LinkManger.schemeJump(initialLink);
      }
    } on PlatformException {
      // Platform messages may fail but we ignore the exception
      Log.e('Failed to get initial link.');
    } on FormatException catch (err) {
      if (!mounted) return;
      Log.e('Failed to parse the initial link as Uri.');
    }
    // App打开的状态监听scheme
    _sub = uriLinkStream.listen((Uri? uri) {
      if (!mounted || uri == null) return;
      Log.d('got uri: $uri');
      LinkManger.schemeJump(uri);
    }, onError: (Object err) {
      if (!mounted) return;
      Log.e('got err: $err');
    });
  }
}

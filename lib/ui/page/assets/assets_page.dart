import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/spot_account_page.dart';
import 'package:bitfrog/ui/page/assets/follow_account_page.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_model.dart';
import 'package:bitfrog/ui/page/financial/viewModel/voice_count_model.dart';
import 'package:bitfrog/ui/page/financial/voice_acount.dart';
import 'package:bitfrog/ui/view/main_app_bar.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:bitfrog/utils/string_util.dart';
import 'package:bitfrog/widget/sliver_persistent_header_delegate.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({Key? key}) : super(key: key);

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage>
    with
        BasePageMixin<AssetsPage>,
        AutomaticKeepAliveClientMixin<AssetsPage>,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  late AssetsModel _model;
  late TabController _tabController;
  final RefreshController _refreshController = RefreshController();
  late Animation<double> btcAnimation;
  late Animation<double> priceAnimation;
  late AnimationController btcController;
  late AnimationController priceController;
  late bool assetsVisible;
  String unit = '';
  List tabs = [
    S.current.asset_tab_finance,
    S.current.asset_tab_follow,
    S.current.asset_tab_voice,
  ];


  late VoiceCountModel voiceCountModel;

  @override
  void initState() {
    super.initState();
    LogUtil.e("AssetsPage initState");
    WidgetsBinding.instance.addObserver(this); //添加观察者
    _model = AssetsModel();
    voiceCountModel = VoiceCountModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
    _tabController = TabController(length: tabs.length, vsync: this);
    assetsVisible = SpUtil.getBool(Config.keyAssetsVisible) ?? true;
    btcController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    priceController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    btcAnimation = Tween(begin: 0.0, end: 0.0)
        .chain(CurveTween(curve: Curves.decelerate))
        .animate(btcController);
    priceAnimation = Tween(begin: 0.0, end: 0.0)
        .chain(CurveTween(curve: Curves.decelerate))
        .animate(priceController);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this); //销毁
    btcController.dispose();
    priceController.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _model.refresh();
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AssetsModel>(
      model: _model,
      builder: (context, model, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: MainAppBar(
              title: S.current.base_asset,
              bottomLine: true,
            ),
            body: SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: (){
                model.refresh();
                voiceCountModel.refresh(refreshLoading: false);
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildAssetsView()),
                  const SliverToBoxAdapter(child: Gaps.spaceView),
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: AppSliverPersistentHeaderDelegate(
                      child: _buildTabBar(),
                      maxHeight: 42.h,
                      minHeight: 42.h,
                    ),
                  ),
                  SliverFillRemaining(
                    child: TabBarView(
                      controller: _tabController,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        SpotAccountPage(model: _model),
                        FollowAccountPage(model: _model),

                        ProviderWidget<VoiceCountModel>(
                            model: voiceCountModel,
                            builder: (context, model, child) {
                              return VoiceAccountPage(
                                countModel: voiceCountModel,
                              );
                            })
                        // const VoiceAccountPage()
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  Widget _buildAssetsView() {
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.current.asset_total_subtitle,
                style: TextStyle(
                    color: Colours.text_color_4,
                    fontSize: 12.sp,
                    fontWeight: BFFontWeight.normal,
                    fontFamily: BFFontFamily.din),
              ),
              InkWell(
                splashColor: Colours.white,
                highlightColor: Colours.white,
                onTap: () {
                  SpUtil.putBool(Config.keyAssetsVisible, !assetsVisible);
                  setState(() {
                    assetsVisible = !assetsVisible;
                  });
                  if (assetsVisible) {
                    btcController.forward(from: 0);
                    priceController.forward(from: 0);
                  }
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 7.5.w, vertical: 15.h),
                  child: Image(
                    width: 12.w,
                    height: 12.h,
                    image: ImageUtil.getAssetImage(assetsVisible
                        ? Assets.imagesAssetsShow
                        : Assets.imagesAssetsHide),
                  ),
                ),
              ),
            ],
          ),
          AnimatedBuilder(
              animation: btcAnimation,
              builder: (context, child) {
                return Text(
                  assetsVisible
                      ? StringUtil.formatPrice(
                          StringUtil.formatNum('${btcAnimation.value}', 8))
                      : '******',
                  style: TextStyle(
                      color: Colours.text_color_2,
                      fontSize: 25.sp,
                      fontWeight: BFFontWeight.bold,
                      fontFamily: BFFontFamily.din),
                );
              }),
          SizedBox(height: 10.h),
          AnimatedBuilder(
              animation: priceAnimation,
              builder: (context, child) {
                return Text(
                  assetsVisible
                      ? '≈ ${StringUtil.formatPrice(StringUtil.formatNum('${priceAnimation.value}', 2))} $unit'
                      : '******',
                  style: TextStyle(
                      color: Colours.text_color_4,
                      fontSize: 12.sp,
                      fontWeight: BFFontWeight.medium,
                      fontFamily: BFFontFamily.din),
                );
              }),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: InkWell(
                      onTap: () {
                        //充值
                        Routers.navigateTo(context, Routers.assetsDeposit);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 35.h,
                        decoration: const BoxDecoration(
                          color: Colours.def_green,
                          borderRadius: BorderRadius.all(
                            Radius.circular(2),
                          ),
                        ),
                        child: Text(S.current.action_deposit,
                            style: TextStyle(
                                color: Colours.white,
                                fontSize: 14.sp,
                                fontWeight: BFFontWeight.medium)),
                      ))),
              SizedBox(width: 10.w),
              Expanded(
                  child: InkWell(
                      onTap: () {
                        //提现
                        Routers.navigateTo(context, Routers.assetsWithdraw);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 35.h,
                        decoration: const BoxDecoration(
                          color: Colours.def_view_bg_1_color,
                          borderRadius: BorderRadius.all(
                            Radius.circular(2),
                          ),
                        ),
                        child: Text(S.current.action_withdraw,
                            style: TextStyle(
                                color: Colours.text_color_2,
                                fontSize: 14.sp,
                                fontWeight: BFFontWeight.medium)),
                      )))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colours.white,
      child: Column(
        children: [
          SizedBox(
            height: 40.h,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 6.5.w),
                    child: TabBar(
                      labelStyle: TextStyle(
                          fontSize: 15.sp,
                          color: Colours.text_color_2,
                          fontWeight: BFFontWeight.medium),
                      unselectedLabelStyle: TextStyle(
                          fontSize: 15.sp,
                          color: Colours.text_color_4,
                          fontWeight: BFFontWeight.normal),
                      labelPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
                      labelColor: Colours.text_color_2,
                      unselectedLabelColor: Colours.text_color_4,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colours.text_color_2,
                      isScrollable: true,
                      controller: _tabController,
                      tabs: tabs.map((e) => Tab(text: e)).toList(),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_tabController.index == 0) {
                      //资金记录
                      Routers.navigateTo(context, Routers.assetsSpotRecord);
                    } else if (_tabController.index == 1) {
                      //跟单记录
                      Routers.navigateTo(context, Routers.assetsFollowRecord);
                    }else{
                      //语音记录
                      Routers.navigateTo(context, Routers.voiceRecord);
                    }
                  },
                  child: Container(
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    alignment: Alignment.center,
                    child: Image(
                        width: 20.w,
                        height: 20.h,
                        image:
                            ImageUtil.getAssetImage(Assets.imagesAssetsRecord)),
                  ),
                )
              ],
            ),
          ),
          Gaps.hLine,
        ],
      ),
    );
  }

  @override
  Future<void> refresh({slient = false}) {
    // _scrollController.animateTo(-0.0001, duration: Duration(milliseconds: 100), curve: Curves.linear);
    // _nestedRefreshKey.currentState?.show(atTop: true);

    if (slient) {
      return _model.refresh();
    } else {
      return Future<void>.delayed(const Duration(milliseconds: 100), () {
        // _refreshController.requestRefresh();
      });
    }
  }

  void initViewModel() {
    _model.refresh();
    _model.listenEvent();

    _model.addListener(() {
      _refreshController.refreshCompleted();
      if (_model.isFirst || _model.isBusy) {
        showProgress();
      } else {
        if (_model.isSuccess && assetsVisible) {
          unit = _model.infoData?.unit ?? '';
          btcAnimation = Tween(
                  begin: 0.0,
                  end: double.parse(_model.infoData?.balance?.btcAmount ?? '0'))
              .chain(CurveTween(curve: Curves.decelerate))
              .animate(btcController);
          priceAnimation = Tween(
                  begin: 0.0,
                  end:
                      double.parse(_model.infoData?.balance?.unitAmount ?? '0'))
              .chain(CurveTween(curve: Curves.decelerate))
              .animate(priceController);
          btcController.forward(from: 0);
          priceController.forward(from: 0);
        }
        closeProgress();
      }
    });
  }
}

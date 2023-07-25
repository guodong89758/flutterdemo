import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/assets_api_account_contract_page.dart';
import 'package:bitfrog/ui/page/assets/assets_api_account_spot_page.dart';
import 'package:bitfrog/ui/page/assets/item/number_animation_item.dart';
import 'package:bitfrog/ui/page/assets/model/asserts_account_index_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_api_account_model.dart';
import 'package:bitfrog/ui/page/mine/item/Line_view_item.dart';
import 'package:bitfrog/ui/view/base_view.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:bitfrog/widget/sliver_persistent_header_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// API账户
class AssetsApiAccountPage extends StatefulWidget {
  const AssetsApiAccountPage({Key? key, required this.apiAccountEntity})
      : super(key: key);
  final ApiAccountEntity apiAccountEntity;

  @override
  State<AssetsApiAccountPage> createState() => _AssetsApiAccountPageState();
}

class _AssetsApiAccountPageState extends State<AssetsApiAccountPage>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();

  late AssetsApiAccountModel viewModel;

  final _tabs = [
    "现货",
    "U本位合约",
  ];

  late final TabController _tabController =
  TabController(length: _tabs.length, vsync: this);

  @override
  void initState() {
    super.initState();
    viewModel = AssetsApiAccountModel(this, widget.apiAccountEntity.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AssetsApiAccountModel>(
      model: viewModel,
      builder: (context, model, child) {
        final accountId =  widget.apiAccountEntity.id ?? "";
        return BaseView(
          viewState: viewModel.viewState,
          clickRefresh: viewModel.clickRefresh,
          child: Scaffold(
            body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  _buildSliverGridHeader(),
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: AppSliverPersistentHeaderDelegate(
                      child: _buildTabBar(),
                      maxHeight: 40.h,
                      minHeight: 40.h,
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                physics: const ClampingScrollPhysics(),
                children: [
                  AssetsApiAccountSpotPage(accountId: accountId),
                  AssetsApiAccountContractPage(accountId: accountId)
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _buildSliverGridHeader() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "总资产折合(USDT)",
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
                            viewModel.hideAssets();
                          },
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 7.5.w, vertical: 15.h),
                            child: Image(
                              width: 12.w,
                              height: 12.h,
                              image: ImageUtil.getAssetImage(viewModel.assetsVisible
                                  ? Assets.imagesAssetsShow
                                  : Assets.imagesAssetsHide),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text( "${S.current.base_update_time}${viewModel.apiAccountEntity?.createdAt ?? ""}",style: TextStyle(
                        color: Colours.text_color_4,
                        fontSize: 12.sp,
                        fontFamily: BFFontFamily.din
                    ),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberAnimationItem(number: viewModel.apiAccountEntity?.btc ?? "0.0",
                        assetsVisible: viewModel.assetsVisible,
                        animationController: viewModel.btcController),
                    InkWell(
                      splashColor: Colours.white,
                      highlightColor: Colours.white,
                      onTap: () {
                        Routers.navigateTo(context, Routers.assetsApiAccountSpotRecord);
                      },
                      child: Container(
                        color: Colors.white,
                        padding:EdgeInsets.only(left: 10.w),
                        child: Image(
                          width: 20.w,
                          height: 20.h,
                          image: ImageUtil.getAssetImage(Assets.imagesCopyTradePosiitonBtn),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Visibility(
                        visible: viewModel.assetsVisible,
                        child: Padding(
                          padding:  EdgeInsets.only(right: 3.w),
                          child: Text("≈",style: TextStyle(
                              color: Colours.text_color_4,
                              fontSize: 12.sp,
                              fontWeight: BFFontWeight.medium,
                              fontFamily: BFFontFamily.din),),
                        )),
                    NumberAnimationItem(number: "0",
                        assetsVisible: viewModel.assetsVisible,
                        textStyle: TextStyle(
                            color: Colours.text_color_4,
                            fontSize: 12.sp,
                            fontWeight: BFFontWeight.medium,
                            fontFamily: BFFontFamily.din),
                        animationController: viewModel.priceController),
                    Visibility(
                        visible: viewModel.assetsVisible,
                        child: Padding(
                          padding:  EdgeInsets.only(left: 3.w),
                          child: Text("USDT",style: TextStyle(
                              color: Colours.text_color_4,
                              fontSize: 12.sp,
                              fontWeight: BFFontWeight.medium,
                              fontFamily: BFFontFamily.din),),
                        )),
                  ],
                ),
              ],
            ),
          ),
          const LineViewItem(heightAll: 1,),
          Container(
            padding: EdgeInsets.only(left: 14.w,right: 14.w,top: 10.h,bottom: 10.h),
            child: Row(
              children: [
                _item("交易所", "币安",),
                _item("账户类型", "API账户",crossAxisAlignment: CrossAxisAlignment.center),
                _item("接入时间", "2022-03-23",crossAxisAlignment: CrossAxisAlignment.end),
              ],
            ),
          ),
          const LineViewItem(heightAll: 1,),
          Container(
            padding: EdgeInsets.only(left: 14.w,right: 14.w,top: 15.h,bottom: 15.h),
            alignment: Alignment.center,
            child: InkWell(
              onTap: (){
                Routers.navigateTo(context, Routers.assetsTransfer);
              },
              child: Container(
                height: 31.h,
                decoration: BoxDecorations.cardBoxDecoration(color: Colours.def_view_bg_1_color,radius: 2),
                alignment: Alignment.center,
                child: Text("划转",style: TextStyle(
                    color: Colours.text_color_2,
                    fontWeight: BFFontWeight.medium,
                    fontSize: 14.sp
                ),),
              ),
            ),
          ),

          const LineViewItem(),
        ],
      ),
    );
  }
  Widget _item(String title,String content,{CrossAxisAlignment? crossAxisAlignment}){
    return Expanded(child: Container(
      child: Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(
              color: Colours.text_color_4,
              fontSize: 11.sp
          ),),
          Gaps.getVGap(3),
          Text(content,style: TextStyle(
              color: Colours.text_color_2,
              fontSize: 14.sp,
              fontFamily: BFFontFamily.din,
              fontWeight: BFFontWeight.medium
          ),)
        ],
      ),
    ));
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecorations.bottomLine(),
      alignment: Alignment.centerLeft,
      height: 40.h,
      padding: EdgeInsets.only(left: 4.w),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 12.w),
        indicatorColor: Colours.app_main,
        indicatorWeight: 2.h,
        unselectedLabelColor: Colours.text_color_4,
        labelPadding: EdgeInsets.symmetric(horizontal: 12.w),
        labelColor: Colours.text_color_2,
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle:
        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        tabs: _tabs.map((e) => Tab(text: e)).toList(),
      ),
    );
  }
}





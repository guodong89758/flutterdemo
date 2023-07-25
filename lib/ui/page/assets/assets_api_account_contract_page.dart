import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/item/account_api_contract_item.dart';
import 'package:bitfrog/ui/page/assets/item/account_api_spot_item.dart';
import 'package:bitfrog/ui/page/assets/item/assets_api_account_spot_search_item.dart';
import 'package:bitfrog/ui/page/assets/item/number_animation_item.dart';
import 'package:bitfrog/ui/page/assets/item/spot_account_item.dart';
import 'package:bitfrog/ui/page/assets/model/assets_info_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_api_contract_model.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_capital_model.dart';
import 'package:bitfrog/ui/page/copyTrade/item/share_trade_current_item.dart';
import 'package:bitfrog/ui/page/copyTrade/model/share_trade_data_entity.dart';
import 'package:bitfrog/ui/page/mine/item/Line_view_item.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/ui/view/refresh_head_view.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetsApiAccountContractPage extends StatefulWidget {
  final String accountId;

  const AssetsApiAccountContractPage({Key? key, required this.accountId})
      : super(key: key);

  @override
  State<AssetsApiAccountContractPage> createState() =>
      _AssetsApiAccountContractPageState();
}

class _AssetsApiAccountContractPageState extends State<AssetsApiAccountContractPage>  with AutomaticKeepAliveClientMixin ,TickerProviderStateMixin {
  late AssetsApiContractModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = AssetsApiContractModel(this, widget.accountId);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AssetsApiContractModel>(
      model: viewModel,
      builder: (context, model, child) {
        return SafeArea(
          child: FBRefreshHeadView(
            viewState: model.viewState,
            itemCount: 5,
            onRefresh: () {
              model.refresh();
            },
            enablePullUp: false,
            onLoadMore: model.loadMore,
            onClickRefresh: model.clickRefresh,
            controller: model.controller,
            placeholderHeight: ScreenHelper.screenHeight / 2.0,
            placeholderWidth: ScreenHelper.screenWidth,
            placeHoldTopHeight: 10.h,
            header: Container(),
            headView: _buildAssetsView(),
            itemBuilder: (BuildContext context, int index) {
              return AccountApiContractItem();
            },
          ),
        );
      },
    );
  }


  Widget _buildAssetsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(14.w, 15.h, 14.w, 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "总资产",
                style: TextStyle(
                    color: Colours.text_color_4,
                    fontSize: 12.sp,
                    fontWeight: BFFontWeight.normal,
                    fontFamily: BFFontFamily.din),
              ),
              Gaps.vGap10,
            Row(
              children: [
                Text(
                  viewModel.apiSpotEntity?.usdt ?? '0',
                  style: TextStyle(
                    color: Colours.text_color_2,
                    fontSize: 25.sp,
                    fontWeight: BFFontWeight.bold,),
                ),
                Text("≈",style: TextStyle(
                    color: Colours.text_color_4,
                    fontSize: 12.sp,
                    fontWeight: BFFontWeight.medium,
                    fontFamily: BFFontFamily.din),),
                Text(viewModel.apiSpotEntity?.coin ?? '',style: TextStyle(
                    color: Colours.text_color_4,
                    fontSize: 12.sp,
                    fontWeight: BFFontWeight.medium,
                    fontFamily: BFFontFamily.din),)

              ],
            ),

            ],
          ),
        ),
        const LineViewItem(heightAll: 1,),
        Container(
          padding: EdgeInsets.only(left: 14.w,right: 14.w),
          decoration: BoxDecorations.bottomLine(),
          child: Row(
            children: [
              _item("保证金余额(USDT)", "2323.33300000", "≈ \$4647.43",needLine: true),
              _item("钱包余额(USDT)", "2323.33300000", "≈ \$4647.43",crossAxisAlignment: CrossAxisAlignment.end)
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 14.w,right: 14.w,top: 10.h,bottom: 10.h),
          child: Row(
            children: [
              _item("未实现盈亏(USDT)", "2323.33300000", "≈ \$4647.43"),
            ],
          ),
        ),
        const LineViewItem(),
        Padding(
            padding: EdgeInsets.only(left: 14.w,bottom: 10.h,top: 15.h),
          child: Text("全部资产",style: TextStyle(
            color: Colours.text_color_2,
            fontSize: 15.sp,
            fontWeight: BFFontWeight.medium
          ),),
        )
      ],
    );
  }

  Widget _item(String title,String center,String down,{CrossAxisAlignment? crossAxisAlignment,bool needLine = false}) {
    return Expanded(
        child: Container(
          padding: EdgeInsets.only(top: 10.h,bottom: 10.h),
          decoration: needLine ? const BoxDecoration(
            border: Border(right: BorderSide(color: Colours.def_line_1_color,width: 1))
          ) : null,
          child: Column(
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            children: [
              Text(title,style: TextStyle(
                  color: Colours.text_color_4,
                  fontSize: 11.sp
              ),),
              Gaps.getVGap(3),
              Text(center,style: TextStyle(
                  color: Colours.text_color_2,
                  fontWeight: BFFontWeight.medium,
                  fontFamily: BFFontFamily.din,
                  fontSize: 13.sp
              ),),
              Gaps.getVGap(2),
              Text(down,style: TextStyle(
                  color: Colours.text_color_4,
                  fontWeight: BFFontWeight.medium,
                  fontFamily: BFFontFamily.din,
                  fontSize: 11.sp
              ),)
            ],
          ),
        ));
  }


}









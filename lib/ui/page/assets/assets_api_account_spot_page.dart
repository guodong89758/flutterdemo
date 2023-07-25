import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/assets/item/account_api_spot_item.dart';
import 'package:bitfrog/ui/page/assets/item/assets_api_account_spot_search_item.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_api_spot_model.dart';
import 'package:bitfrog/ui/page/mine/item/Line_view_item.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/ui/view/refresh_head_view.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetsApiAccountSpotPage extends StatefulWidget {
  final String accountId;

  const AssetsApiAccountSpotPage({Key? key, required this.accountId})
      : super(key: key);

  @override
  State<AssetsApiAccountSpotPage> createState() =>
      _AssetsApiAccountSpotPageState();
}

class _AssetsApiAccountSpotPageState extends State<AssetsApiAccountSpotPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late AssetsApiSpotModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = AssetsApiSpotModel(this, widget.accountId);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AssetsApiSpotModel>(
      model: viewModel,
      builder: (context, model, child) {
        return SafeArea(
          child: FBRefreshHeadView(
            viewState: model.viewState,
            itemCount: model.dataList.length,
            onRefresh: () {
              model.refresh();
            },
            enablePullUp: false,
            onLoadMore: model.loadMore,
            onClickRefresh: model.clickRefresh,
            controller: model.controller,
            placeholderHeight: ScreenHelper.screenHeight / 2.0,
            placeholderWidth: ScreenHelper.screenWidth,
            placeHoldTopHeight: 60.h,
            header: Container(),
            headView: _buildAssetsView(),
            itemBuilder: (BuildContext context, int index) {
              return AccountApiSpotItem(assets: model.dataList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildAssetsView() {
    final spotEntity = viewModel.apiSpotEntity;

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
                    spotEntity?.usdt ?? '-',
                    style: TextStyle(
                      color: Colours.text_color_2,
                      fontSize: 25.sp,
                      fontWeight: BFFontWeight.bold,
                    ),
                  ),
                  Text(
                    " ≈ ",
                    style: TextStyle(
                        color: Colours.text_color_4,
                        fontSize: 12.sp,
                        fontWeight: BFFontWeight.medium,
                        fontFamily: BFFontFamily.din),
                  ),
                  Text(
                    '${spotEntity?.coin ?? ''}${spotEntity?.worth}',
                    style: TextStyle(
                        color: Colours.text_color_4,
                        fontSize: 12.sp,
                        fontWeight: BFFontWeight.medium,
                        fontFamily: BFFontFamily.din),
                  )
                ],
              ),
            ],
          ),
        ),
        const LineViewItem(heightAll: 1),
        AssetsApiAccountSpotSearchItem(
          textEditingController: viewModel.textEditingController,
        )
      ],
    );
  }
}

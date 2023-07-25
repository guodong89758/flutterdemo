import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/alert/item/alert_signal_item.dart';
import 'package:bitfrog/ui/page/alert/item/alert_signal_news_item.dart';
import 'package:bitfrog/ui/page/alert/model/alert_signal_entity.dart';
import 'package:bitfrog/ui/page/alert/model/alert_signal_new_entity.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_signal_model.dart';
import 'package:bitfrog/ui/view/base_view.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:bitfrog/widget/dividers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/ui/view/refresh_head_view.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'view/alert_floating_action_add_button.dart';

class AlertSignalPage extends StatefulWidget {
  const AlertSignalPage({Key? key}) : super(key: key);

  @override
  State<AlertSignalPage> createState() => _AlertSignalPageState();
}

class _AlertSignalPageState extends State<AlertSignalPage> {
  late AlertSignalModel viewModel;
  final bgColor = Colours.def_view_bg_1_color;

  @override
  void initState() {
    super.initState();
    viewModel = AlertSignalModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: S.of(context).alert_indicator_warning),
        backgroundColor: bgColor,
        floatingActionButton: AlterFloatingActionAddButton(
          onTap: () => viewModel.addSignal(context),
        ),
        floatingActionButtonLocation: AlterFloatingActionAddButton.location,
        body: ProviderWidget<AlertSignalModel>(
          model: viewModel,
          builder: (context, model, child) {
            return SafeArea(
              minimum: EdgeInsets.only(bottom: 15.h),
              child: Container(
                margin: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecorations.cardBoxDecoration(radius: 4.r),
                child: FBRefreshHeadView(
                  viewState: model.viewState,
                  itemCount: model.dataList.length,
                  onRefresh: () {
                    model.refresh();
                    model.getSubscribed();
                  },
                  onLoadMore: model.loadMore,
                  onClickRefresh: model.clickRefresh,
                  controller: model.controller,
                  scrollController: model.scrollController,
                  placeholderHeight: ScreenHelper.screenHeight / 2.0,
                  placeholderWidth: ScreenHelper.screenWidth,
                  header: Container(),
                  placeHoldTopHeight: 100.h,
                  emptyWidget: Container(
                    color: Colors.white,
                    width: ScreenHelper.screenWidth,
                    height: ScreenHelper.screenHeight / 2.0,
                    child: Center(
                      child: BaseEmptyPage(
                        text: S.of(context).alert_text_8,
                        image: Assets.imagesAlertListEmpty,
                        imageWidth: 180.w,
                        imageHeight: 130.h,
                        imageTextSpace: 5.h,
                        onEmptyClick: () => model.clickRefresh(),
                      ),
                    ),
                  ),
                  headView: _headView(),
                  itemBuilder: (BuildContext context, int index) {
                    AlertSignalNewEntity alertSignalNewEntity =
                        model.dataList[index];
                    return AlertSignalNewsItem(
                      alertSignalNewEntity: alertSignalNewEntity,
                    );
                  },
                ),
              ),
            );
          },
        ));
  }

  Widget _headView() {
    return Container(
      color: bgColor,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: BaseView(
              viewState: viewModel.signalSubscribeViewState,
              height: 290.h,
              placeHoldTopHeight: 50.h,
              clickRefresh: viewModel.clickSubscribed,
              emptyWidget: Container(
                height: 290.h,
                width: ScreenHelper.screenWidth,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.imagesAlertPriceEmpty, width: 140.w),
                    Gaps.vGap5,
                    Text(
                      S.of(context).alert_empty,
                      style: TextStyle(
                          color: Colours.text_color_4, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ...List.generate(_getItemLength(), (index) {
                    AlertSignalEntity alertSignalEntity =
                        viewModel.itemList[index];
                    return AlertSignalItem(
                      alertSignalEntity: alertSignalEntity,
                      showBottomSpace: index + 1 != _getItemLength(),
                      handleClickDelete: () {
                        viewModel.deleteSignal(alertSignalEntity);
                      },
                    );
                  }).toList(),
                  if (!viewModel.isOpen &&
                      viewModel.itemList.length > viewModel.itemDefaultOpenMax)
                    GestureDetector(
                      onTap: () {
                        viewModel.open();
                      },
                      child: Container(
                        height: 50.h,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.current.alert_single_8,
                              style: TextStyle(
                                  color: Colours.app_main, fontSize: 13.sp),
                            ),
                            Gaps.hGap4,
                            Icon(
                              CupertinoIcons.chevron_down,
                              size: 12.w,
                              color: Colours.app_main,
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          if (viewModel.isOpen ||
              viewModel.itemList.length <= viewModel.itemDefaultOpenMax)
            Gaps.vGap10,
          Container(
            height: 40.h,
            padding: EdgeInsets.only(left: 15.w),
            decoration: BoxDecorations.topRectRound(radius: 4.r),
            alignment: Alignment.centerLeft,
            child: Text(
              S.current.alert_message,
              style: TextStyle(
                  color: Colours.text_color_2,
                  fontSize: 15.sp,
                  fontWeight: BFFontWeight.medium),
            ),
          ),
          const HDivider(),
        ],
      ),
    );
  }

  int _getItemLength() {
    if (viewModel.isOpen) {
      return viewModel.itemList.length;
    } else {
      return (viewModel.itemList.length > viewModel.itemDefaultOpenMax)
          ? viewModel.itemDefaultOpenMax
          : viewModel.itemList.length;
    }
  }
}

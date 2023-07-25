import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_classify_model.dart';
import 'package:bitfrog/ui/view/base_view.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/sheet_popup_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetsClassifyPage extends StatefulWidget {
  const AssetsClassifyPage({Key? key, this.defaultTabName}) : super(key: key);
  final String? defaultTabName;

  @override
  State<AssetsClassifyPage> createState() => _AssetsClassifyPageState();
}

class _AssetsClassifyPageState extends State<AssetsClassifyPage>
    with TickerProviderStateMixin {
  final GlobalKey sortKey = GlobalKey();
  late SheetPopupWindow typePopup;

  late AssetsClassifyModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel =
        AssetsClassifyModel(this, defaultTabName: widget.defaultTabName,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderWidget<AssetsClassifyModel>(
          model: viewModel,
          builder: (context, model, child) {
            return Scaffold(
              appBar: MyAppBar(
                key: sortKey,
                bottomLine: true,
                titleWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TabBar(
                        labelStyle: TextStyle(
                            fontSize: 17.sp,
                            color: Colours.text_color_1,
                            fontWeight: BFFontWeight.medium),
                        unselectedLabelStyle: TextStyle(
                            fontSize: 16.sp,
                            color: Colours.text_color_4,
                            fontWeight: FontWeight.normal),
                        labelPadding: EdgeInsets.symmetric(
                            vertical: 0, horizontal: 7.5.w),
                        labelColor: Colours.def_green,
                        unselectedLabelColor: Colours.text_color_4,
                        indicatorColor: Colors.transparent,
                        overlayColor:
                            MaterialStateProperty.all(Colours.transparent),
                        isScrollable: true,
                        controller: viewModel.tabController,
                        tabs: getTabs()
                            .asMap()
                            .entries
                            .map((entry) => AnimatedBuilder(
                                animation: viewModel.tabController.animation!,
                                builder: (context, snapshot) {
                                  final forward =
                                      viewModel.tabController.offset > 0;
                                  final backward =
                                      viewModel.tabController.offset < 0;
                                  int fromIndex;
                                  int toIndex;
                                  double progress;
                                  // Tab
                                  if (viewModel.tabController.indexIsChanging) {
                                    fromIndex =
                                        viewModel.tabController.previousIndex;
                                    toIndex = viewModel.tabController.index;
                                    progress = (viewModel.tabController
                                                    .animation!.value -
                                                fromIndex)
                                            .abs() /
                                        (toIndex - fromIndex).abs();
                                  } else {
                                    // Scroll
                                    fromIndex = viewModel.tabController.index;
                                    toIndex = forward
                                        ? fromIndex + 1
                                        : backward
                                            ? fromIndex - 1
                                            : fromIndex;
                                    progress = (viewModel.tabController
                                                .animation!.value -
                                            fromIndex)
                                        .abs();
                                  }
                                  var flag = entry.key == fromIndex
                                      ? 1 - progress
                                      : entry.key == toIndex
                                          ? progress
                                          : 0.0;
                                  return buildTabContainer(
                                      entry.value.text!,
                                      flag,
                                      entry.key ==
                                          viewModel.tabController.index);
                                }))
                            .toList(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showTabPopup();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 14.w, right: 5.w),
                        child: Image.asset(
                          Assets.imagesCopyTradeMenu,
                          width: 20.w,
                          height: 20.w,
                        ),
                      ),
                    )
                  ],
                ),
                titleWidgetMargin: EdgeInsets.only(left: 44.w, right: 0.w),
              ),
              body: BaseView(
                viewState: model.viewState,
                clickRefresh: model.clickRefresh,
                child: Container(
                  color: Colours.def_view_bg_1_color,
                  child: TabBarView(
                    controller: viewModel.tabController,
                    children: viewModel.tabBarViewList,
                  ),
                ),
              ),
            );
          }),
    );
  }

  List<Tab> getTabs() {
    List<Tab> tabList = [];
    for (String text in viewModel.tabs) {
      tabList.add(Tab(text: text));
    }
    return tabList;
  }

  buildTabContainer(String tabName, double alpha, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      child: AnimatedScale(
        scale: 1 + double.parse((alpha * 0.2).toStringAsFixed(2)),
        duration: const Duration(milliseconds: 100),
        child: Text(
          tabName,
          style: TextStyle(
              fontSize: ScreenHelper.sp(15),
              fontWeight: isSelected ? BFFontWeight.medium : FontWeight.normal,
              color: isSelected ? Colours.text_color_1 : Colours.text_color_4),
        ),
      ),
    );
  }

  void showTabPopup() {
    typePopup = showSheetPopupWindow(
      context,
      targetRenderBox:
          (sortKey.currentContext?.findRenderObject() as RenderBox),
      childFun: (pop) {
        return Container(
          width: ScreenHelper.screenWidth,
          key: GlobalKey(),
          color: Colors.white,
          child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: viewModel.tabs.length,
              padding: EdgeInsets.fromLTRB(14.w, 20.h, 14.w, 20.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //设置列数
                crossAxisCount: 3,
                //设置横向间距
                crossAxisSpacing: 20.w,
                //设置主轴间距
                mainAxisSpacing: 15,
                childAspectRatio: 194 / 60,
              ),
              itemBuilder: (context, position) {
                String str = viewModel.tabs[position];
                return InkWell(
                  onTap: () {
                    typePopup.dismiss(context);
                    viewModel.tabController.index = position;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: viewModel.tabController.index == position
                            ? Colours.app_main.withOpacity(0.1)
                            : Colours.white,
                        borderRadius: BorderRadius.circular(1),
                        border: Border.all(
                            color: viewModel.tabController.index == position
                                ? Colours.app_main
                                : Colours.def_line_1_color)),
                    child: Text(
                      str,
                      maxLines: 1,
                      style: TextStyle(
                              color: Colours.text_color_2, fontSize: 14.sp)
                          .copyWith(
                              color: viewModel.tabController.index == position
                                  ? Colours.app_main
                                  : null),
                    ),
                  ),
                );
              }),
        );
        // return Container(
        //   key: GlobalKey(),
        //   height: 300,
        //   child: Text("ihsihdsfd"),
        // );
      },
    );
  }
}

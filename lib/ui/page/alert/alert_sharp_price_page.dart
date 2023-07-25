import 'package:bitfrog/router/routers.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/sharp_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/ui/page/alert/item/alert_sharp_price_item.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_sharp_price_model.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/behavior/over_scroll_behavior.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:bitfrog/widget/refresh/base_loading_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///急涨急跌设置页面
class AlertSharpPricePage extends StatefulWidget {
  final String? tip;
  const AlertSharpPricePage({Key? key, this.tip}) : super(key: key);

  @override
  State<AlertSharpPricePage> createState() => _AlertSharpPricePageState();
}

class _AlertSharpPricePageState extends State<AlertSharpPricePage>
    with
        BasePageMixin<AlertSharpPricePage>,
        AutomaticKeepAliveClientMixin<AlertSharpPricePage>,
        SingleTickerProviderStateMixin {
  final RefreshController _refreshController = RefreshController();
  late AlertSharpPriceModel _sharpModel;

  @override
  void initState() {
    super.initState();
    _sharpModel = AlertSharpPriceModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AlertSharpPriceModel>(
      model: _sharpModel,
      builder: (context, model, child) {
        Widget refreshWidget = const BaseLoadingPage();
        Widget emptyWidget = BaseEmptyPage(onEmptyClick: (){
          _sharpModel.refresh();
        });
        return Scaffold(
          appBar: MyAppBar(
            title: S.current.alert_sharp_price,
            onBack: _onWillPop,
          ),
          body: Container(
              decoration:
                  const BoxDecoration(color: Colours.def_view_bg_1_color),
              child: ScrollConfiguration(
                  behavior: OverScrollBehavior(),
                  child: SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: true,
                      enablePullUp: false,
                      onRefresh: model.refresh,
                      child: model.isFirst
                          ? refreshWidget
                          : (model.isEmpty || model.isError)
                              ? emptyWidget
                              : CustomScrollView(
                                  slivers: [
                                    SliverToBoxAdapter(
                                      child:(widget.tip ?? '').isEmpty ? Gaps.empty : Container(
                                        color: Colours.white,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text(
                                                    widget.tip ?? '',
                                                    style: const TextStyle(
                                                        color: Colours
                                                            .text_color_3,
                                                        fontSize: Dimens
                                                            .font_sp14))),
                                            Container(
                                              width: ScreenHelper.screenWidth,
                                              height: ScreenHelper.height(10),
                                              color:
                                                  Colours.def_view_bg_1_color,
                                            ),
                                            SizedBox(
                                              height: ScreenHelper.height(45),
                                              child: Stack(
                                                fit: StackFit.expand,
                                                alignment:
                                                    Alignment.centerLeft,
                                                children: [
                                                  Positioned(
                                                      left: 15,
                                                      child: Text(
                                                        S.current
                                                            .alert_currency,
                                                        style: const TextStyle(
                                                            color: Colours
                                                                .text_color_4,
                                                            fontSize: Dimens
                                                                .font_sp13),
                                                      )),
                                                  Positioned(
                                                      right: 15,
                                                      child: Text(
                                                        S.current.alert_state,
                                                        style: const TextStyle(
                                                            color: Colours
                                                                .text_color_4,
                                                            fontSize: Dimens
                                                                .font_sp13),
                                                      )),
                                                  Positioned(
                                                      bottom: 0,
                                                      child: SizedBox(
                                                        height: 1,
                                                        width: ScreenHelper
                                                            .screenWidth,
                                                        child: Gaps.hLine,
                                                      ))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                        SharpEntity sharpItem =
                                            model.sharpList[index];
                                        return AlertSharpPriceItem(
                                            index: index,
                                            count: model.sharpList.length,
                                            item: sharpItem);
                                      }, childCount: model.sharpList.length),
                                    ),
                                  ],
                                )))),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> refresh({slient = false}) {
    if (slient) {
      return _sharpModel.refresh();
    } else {
      return Future<void>.delayed(const Duration(milliseconds: 100), () {
        _refreshController.requestRefresh();
      });
    }
  }

  void initViewModel() {
    _sharpModel.refresh();

    _sharpModel.addListener(() {
      _refreshController.refreshCompleted();
      if (_sharpModel.isBusy) {
        showProgress();
      } else {
        closeProgress();
      }
    });

    _sharpModel.listenEvent();
  }

  Future<bool> _onWillPop() {
    Routers.goBack(context);
    return Future.value(false);
  }
}

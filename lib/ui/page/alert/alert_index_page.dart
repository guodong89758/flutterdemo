import 'package:bitfrog/router/routers.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/alert_index_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/ui/page/alert/item/alert_index_item.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_index_model.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/behavior/over_scroll_behavior.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:bitfrog/widget/refresh/base_loading_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 指标设置页面
class AlertIndexPage extends StatefulWidget {
  final String? type;
  final String? title;
  final String? tip;

  const AlertIndexPage({Key? key, this.type, this.title, this.tip})
      : super(key: key);

  @override
  State<AlertIndexPage> createState() => _AlertIndexPageState();
}

class _AlertIndexPageState extends State<AlertIndexPage>
    with
        BasePageMixin<AlertIndexPage>,
        AutomaticKeepAliveClientMixin<AlertIndexPage>,
        SingleTickerProviderStateMixin {
  final RefreshController _refreshController = RefreshController();
  late AlertIndexModel _indexModel;

  @override
  void initState() {
    super.initState();
    _indexModel = AlertIndexModel(widget.type);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AlertIndexModel>(
      model: _indexModel,
      builder: (context, model, child) {
        Widget refreshWidget = const BaseLoadingPage();
        Widget emptyWidget = BaseEmptyPage(onEmptyClick: () {
          _indexModel.refresh();
        });
        return Scaffold(
          appBar: MyAppBar(
            title:
                '${S.current.action_set}${widget.title ?? ''}${S.current.action_alert}',
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
                                      child: (widget.tip ?? '').isEmpty
                                          ? Gaps.empty
                                          : Container(
                                              color: Colours.white,
                                              padding:
                                                  const EdgeInsets.all(15),
                                              child: Text(widget.tip ?? '',
                                                  style: const TextStyle(
                                                      color: Colours
                                                          .text_color_3,
                                                      fontSize:
                                                          Dimens.font_sp14)),
                                            ),
                                    ),
                                    SliverToBoxAdapter(
                                      child: Container(
                                        height: ScreenHelper.height(10),
                                        color: Colours.def_view_bg_1_color,
                                      ),
                                    ),
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                        AlertIndexEntity indexItem =
                                            model.indexList[index];
                                        return AlertIndexItem(
                                            index: index,
                                            count: model.indexList.length,
                                            item: indexItem);
                                      }, childCount: model.indexList.length),
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
      return _indexModel.refresh();
    } else {
      return Future<void>.delayed(const Duration(milliseconds: 100), () {
        _refreshController.requestRefresh();
      });
    }
  }

  void initViewModel() {
    _indexModel.refresh();

    _indexModel.addListener(() {
      _refreshController.refreshCompleted();
      if (_indexModel.isBusy) {
        showProgress();
      } else {
        closeProgress();
      }
    });

    _indexModel.listenEvent();
  }

  Future<bool> _onWillPop() {
    Routers.goBack(context);
    return Future.value(false);
  }
}

import 'package:flutter/material.dart';
import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/model/alert_config_entity.dart';
import 'package:bitfrog/ui/page/alert/item/alert_config_item.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_config_model.dart';
import 'package:bitfrog/widget/behavior/over_scroll_behavior.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:bitfrog/widget/refresh/base_loading_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///提醒列表页面
class AlertConfigPage extends StatefulWidget {
  const AlertConfigPage({Key? key}) : super(key: key);

  @override
  State<AlertConfigPage> createState() => _AlertConfigPageState();
}

class _AlertConfigPageState extends State<AlertConfigPage>
    with
        BasePageMixin<AlertConfigPage>,
        AutomaticKeepAliveClientMixin<AlertConfigPage>,
        SingleTickerProviderStateMixin,
        WidgetsBindingObserver {
  final RefreshController _refreshController = RefreshController();
  late AlertConfigModel _configModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); //添加观察者
    _configModel = AlertConfigModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this); //销毁
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // if (_configModel.configList.isNotEmpty) {
      //   _configModel.refresh();
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AlertConfigModel>(
      model: _configModel,
      builder: (context, model, child) {
        Widget refreshWidget = const BaseLoadingPage();
        Widget emptyWidget = BaseEmptyPage(onEmptyClick: () {
          _configModel.refresh();
        });
        return ScrollConfiguration(
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
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                  AlertConfigEntity config =
                                      model.configList[index];
                                  return AlertConfigItem(
                                      index: index,
                                      count: model.configList.length,
                                      config: config);
                                }, childCount: model.configList.length),
                              ),
                            ],
                          )));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> refresh({slient = false}) {
    if (slient) {
      return _configModel.refresh();
    } else {
      return Future<void>.delayed(const Duration(milliseconds: 100), () {
        _refreshController.requestRefresh();
      });
    }
  }

  void initViewModel() {
    _configModel.refresh();
    _configModel.listenEvent();

    _configModel.addListener(() {
      _refreshController.refreshCompleted();
    });
  }
}

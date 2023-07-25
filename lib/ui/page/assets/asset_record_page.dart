import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/ui/page/assets/item/asset_record_item.dart';
import 'package:bitfrog/ui/page/assets/model/asset_record_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/asset_record_model.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/widget/behavior/over_scroll_behavior.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:bitfrog/widget/refresh/base_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///充提记录
class AssetRecordPage extends StatefulWidget {
  const AssetRecordPage({Key? key, required this.type, required this.currency})
      : super(key: key);
  final int type; //1 充币 2 提币
  final String? currency;

  @override
  State<AssetRecordPage> createState() => _AssetRecordPageState();
}

class _AssetRecordPageState extends State<AssetRecordPage>
    with
        BasePageMixin<AssetRecordPage>,
        AutomaticKeepAliveClientMixin<AssetRecordPage> {
  final RefreshController _refreshController = RefreshController();
  late AssetRecordModel _model;

  @override
  void initState() {
    super.initState();
    _model = AssetRecordModel();
    _model.type = widget.type;
    _model.currency = widget.currency ?? 'USDT';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AssetRecordModel>(
      model: _model,
      builder: (context, model, child) {
        Widget refreshWidget = const BaseLoadingPage();
        Widget emptyWidget = BaseEmptyPage(onEmptyClick: () {
          _model.refresh();
        });
        return Scaffold(
          backgroundColor: Colours.white,
          appBar: MyAppBar(
            title: widget.type == 1
                ? S.current.asset_deposit_record
                : S.current.asset_withdraw_record,
            bottomLine: true,
          ),
          body: ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: !model.noMore,
                  onRefresh: model.refresh,
                  onLoading: model.noMore ? null : model.loadMore,
                  child: model.isFirst
                      ? refreshWidget
                      : (model.isEmpty || model.isError)
                          ? emptyWidget
                          : CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                    RecordEntity item = model.recordList[index];
                                    return AssetRecordItem(
                                        type: widget.type, item: item);
                                  }, childCount: model.recordList.length),
                                ),
                              ],
                            ))),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> refresh({slient = false}) {
    if (slient) {
      return _model.refresh();
    } else {
      return Future<void>.delayed(const Duration(milliseconds: 100), () {
        _refreshController.requestRefresh();
      });
    }
  }

  void initViewModel() {
    _model.refresh();
    _model.listenEvent();

    _model.addListener(() {
      if (_model.isError) {
        if (_model.page == 1) {
          _refreshController.refreshFailed();
        } else {
          _refreshController.loadFailed();
        }
      } else if (_model.isSuccess || _model.isEmpty) {
        if (_model.page == 1) {
          _refreshController.refreshCompleted(resetFooterState: !_model.noMore);
        } else {
          if (_model.noMore) {
            _refreshController.loadNoData();
          } else {
            _refreshController.loadComplete();
          }
        }
      }
    });
  }
}

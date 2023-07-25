import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/ui/page/alert/item/alert_list_item.dart';
import 'package:bitfrog/ui/page/alert/model/alert_type_entity.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_list_model.dart';
import 'package:bitfrog/ui/view/refresh_view.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AlertListPage extends StatefulWidget {
  const AlertListPage({Key? key, required this.tab}) : super(key: key);
  final int? tab;

  @override
  State<AlertListPage> createState() => _AlertListPageState();
}

class _AlertListPageState extends State<AlertListPage>
    with
        BasePageMixin<AlertListPage>,
        AutomaticKeepAliveClientMixin<AlertListPage> {
  final RefreshController _refreshController = RefreshController();
  late AlertListModel _model;

  @override
  void initState() {
    super.initState();
    _model = AlertListModel();
    _model.tab = widget.tab;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AlertListModel>(
      model: _model,
      builder: (context, model, child) {
        Widget emptyWidget = Container(
          color: Colors.white,
          child: Center(
            child: BaseEmptyPage(
              text: S.current.alert_text_6,
              image: Assets.imagesAlertSubscribeEmpty,
              imageWidth: 230.w,
              imageHeight: 120.h,
              onEmptyClick: () => _model.refresh(),
            ),
          ),
        );

        final itemWidth = (ScreenHelper.screenWidth - 38.w) / 2;
        final itemHeight = 102.h;
        final childAspectRatio = itemWidth / itemHeight;
        return FBRefresherView(
          backgroundColor: Colours.def_view_bg_1_color,
          viewState: model.viewState,
          emptyWidget: emptyWidget,
          controller: _refreshController,
          itemCount: model.typeList.length,
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: model.refresh,
          onClickRefresh: model.refresh,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
                sliver: SliverGrid.builder(
                    itemCount: _model.typeList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //设置列数
                      crossAxisCount: 2,
                      //设置横向间距
                      crossAxisSpacing: 10.w,
                      //设置主轴间距
                      mainAxisSpacing: 10.w,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, position) {
                      AlertTypeEntity item = _model.typeList[position];
                      return AlertListItem(
                        position: position,
                        item: item,
                        onSubscribeClick: (entity) {
                          showProgress();
                          _model.subscribeSwitch(
                            context,
                              entity.type ?? '',
                              entity.subscribeKey ?? '',
                              (entity.setCnt ?? 0) > 0 ? 0 : 1);
                        },
                      );
                    }),
              ),
            ],
          ),
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
      _refreshController.refreshCompleted();
      closeProgress();
    });
  }
}

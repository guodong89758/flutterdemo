import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/event/alert_event.dart';
import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/alert/alert_list_page.dart';
import 'package:bitfrog/ui/page/alert/alert_subscribe_page.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_model.dart';
import 'package:bitfrog/ui/view/base_view.dart';
import 'package:bitfrog/utils/log_utils.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///提醒页面
class AlertPage extends StatefulWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage>
    with
        BasePageMixin<AlertPage>,
        AutomaticKeepAliveClientMixin<AlertPage>,
        TickerProviderStateMixin {
  late AlertModel _model;
  // late TabController? _tabController;

  @override
  void initState() {
    super.initState();
    Log.d('AlertPage initState');
    _model = AlertModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
    _model.tabController = TabController(length: _model.tabList.length, vsync: this);
    Event.eventBus.on<RemindTabEvent>().listen((event) {
      if(mounted){
        _model.tabController?.index = 0;
      }
    });
    Event.eventBus.on<UserLoginEvent>().listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _model.tabController?.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.d('AlertPage build');
    return ProviderWidget<AlertModel>(
      model: _model,
      builder: (context, model, child) {
        return Scaffold(
            body: BaseView(
          viewState: _model.viewState,
          clickRefresh: (){
            _model.getAlertTab(this);
          },
          child: Column(
            children: [
              buildTitleBar(),
              Expanded(
                  child: Container(
                color: Colours.def_view_bg_1_color,
                child: TabBarView(
                    controller: _model.tabController,
                    children: _model.tabList
                        .map((e) => e.tab == 1
                            ? AlertSubscribePage(tab: e.tab)
                            : AlertListPage(tab: e.tab))
                        .toList()
                    ),
              )),
            ],
          ),
        ));
      },
    );
  }

  void initViewModel() {
    _model.getAlertTab(this);
    _model.listenEvent();

    _model.addListener(() {});
  }

  Widget buildTitleBar() {
    return Container(
        height: 40.h,
        color: Colours.white,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 6.5.w),
        child: TabBar(
          labelStyle: TextStyle(
              fontSize: ScreenHelper.sp(16),
              color: Colours.text_color_2,
              fontWeight: BFFontWeight.medium),
          unselectedLabelStyle: TextStyle(
              fontSize: ScreenHelper.sp(14),
              color: Colours.text_color_4,
              fontWeight: FontWeight.normal),
          labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 7.5.w),
          labelColor: Colours.text_color_2,
          unselectedLabelColor: Colours.text_color_4,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 7.5.w),
          indicatorColor: Colours.text_color_2,
          indicatorWeight: 2.5.h,
          isScrollable: true,
          controller: _model.tabController,
          tabs: _model.tabList.map((e) => Tab(text: e.name)).toList(),
        ));
  }

  buildTabContainer(String tabName, double alpha, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      child: AnimatedScale(
        scale: 1 + double.parse((alpha * 0.14).toStringAsFixed(2)),
        duration: const Duration(milliseconds: 100),
        child: Text(
          tabName,
          style: TextStyle(
              fontSize: ScreenHelper.sp(14),
              fontWeight:
                  isSelected ? BFFontWeight.medium : BFFontWeight.normal,
              color: isSelected ? Colours.text_color_2 : Colours.text_color_4),
        ),
      ),
    );
  }
}

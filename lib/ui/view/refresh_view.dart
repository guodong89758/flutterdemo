import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/ui/view/network_error_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:bitfrog/widget/refresh/base_loading_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum RefreshLoadStatus {
  /// Initial state, which can be triggered loading more by gesture pull up
  normal,
  loading,
  empty,
  failed
}

typedef VoidCallbackRefresh = void Function();

class FBRefresherView extends StatefulWidget {
  const FBRefresherView({
    Key? key,
    required this.viewState,
    this.child,
    required this.itemCount,
    required this.controller,
    this.itemBuilder,
    this.header,
    this.scrollController,
    this.needTop = false,
    this.enablePullUp = true,
    this.enablePullDown = true,
    this.onRefresh,
    this.onLoadMore,
    this.onClickRefresh,
    this.loadingWidget,
    this.emptyWidget,
    this.failWidget,
    this.physics,
    this.placeHoldTopHeight,
    this.backgroundColor,
    this.noMoreTest = "",
    this.darkTheme = false,
  }) : super(key: key);

  final bool needTop;
  final ViewState viewState;
  final bool enablePullUp;
  final bool enablePullDown;
  final VoidCallbackRefresh? onRefresh;
  final VoidCallbackRefresh? onLoadMore;
  final VoidCallbackRefresh? onClickRefresh;
  final Widget? child;
  final int itemCount;
  final IndexedWidgetBuilder? itemBuilder;
  final Widget? header;
  final RefreshController controller;
  final ScrollController? scrollController;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? failWidget;
  final String noMoreTest;
  final Color? backgroundColor;
  final ScrollPhysics? physics;
  final double? placeHoldTopHeight;
  final bool darkTheme;

  @override
  State<FBRefresherView> createState() => _FBRefresherState();
}

class _FBRefresherState extends State<FBRefresherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SmartRefresher(
        enablePullDown: widget.enablePullDown,
        enablePullUp: widget.enablePullUp,
        header: ClassicHeader(
          refreshingText: "",
          idleText: "",
          releaseText: "",
          releaseIcon:
              const Icon(Icons.arrow_upward, color: Colours.text_color_4),
          refreshingIcon: const SizedBox(
            width: 25.0,
            height: 25.0,
            child: CupertinoActivityIndicator(color: Colours.text_color_4),
          ),
          failedText: S.current.refresh_header_fail,
          textStyle: TextStyle(color: Colours.text_color_4, fontSize: 12.sp),
          completeText: S.current.refresh_header_success,
          completeIcon: null,
        ),
        footer: ClassicFooter(
          noDataText:
              widget.itemCount > 0 ? S.current.refresh_footer_noMore : "",
          loadingText: S.current.refresh_footer_loading,
          textStyle: TextStyle(color: Colours.text_color_4, fontSize: 12.sp),
          loadingIcon: const SizedBox(
            width: 25.0,
            height: 25.0,
            child: CupertinoActivityIndicator(color: Colours.text_color_4),
          ),
        ),
        controller: widget.controller,
        onRefresh: widget.onRefresh,
        onLoading: widget.onLoadMore,
        physics: widget.physics,
        child: (widget.viewState == ViewState.success || widget.itemCount > 0)
            ? (widget.child ??
                ListView.builder(
                  controller: widget.scrollController,
                  itemBuilder: widget.itemBuilder ?? (context, index) => Gaps.empty,
                  itemCount: widget.itemCount,
                ))
            : StatusViews(
                darkTheme: widget.darkTheme,
                viewState: widget.viewState,
                failWidget: widget.failWidget,
                emptyWidget: widget.emptyWidget,
                loadingWidget: widget.loadingWidget,
                clickRefresh: widget.onClickRefresh ?? widget.onRefresh,
                placeHoldTopHeight: widget.placeHoldTopHeight,
              ),
      ),
      floatingActionButton: widget.needTop ? buildFloatingActionButton() : null,
    );
  }

  Widget buildFloatingActionButton() {
    return FloatingActionButton(
        heroTag: '111',
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.keyboard_arrow_up),
        onPressed: () {
          widget.scrollController?.animateTo(0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        });
  }
}

class StatusViews extends StatelessWidget {
  static RefreshLoadStatus getRefreshLoadStatus(List lists) {
    RefreshLoadStatus refreshStatus = RefreshLoadStatus.loading;
    if (lists.isEmpty) {
      refreshStatus = RefreshLoadStatus.failed;
    } else if (lists.isEmpty) {
      refreshStatus = RefreshLoadStatus.empty;
    } else {
      refreshStatus = RefreshLoadStatus.normal;
    }
    return refreshStatus;
  }

  static setRefreshLoadStatus(List lists, RefreshController refreshController,
      bool refresh, int listLength) {
    RefreshLoadStatus refreshStatus = RefreshLoadStatus.loading;
    if (lists.isEmpty) {
      refreshStatus = RefreshLoadStatus.failed;
    } else if (lists.isEmpty) {
      refreshStatus = RefreshLoadStatus.empty;
    } else {
      refreshStatus = RefreshLoadStatus.normal;
    }

    if (refresh) {
      refreshController.refreshCompleted(resetFooterState: true);
    } else {
      if (listLength == 0) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    }
    return refreshStatus;
  }

  const StatusViews({
    Key? key,
    required this.viewState,
    this.onTap,
    this.loadingWidget,
    this.emptyWidget,
    this.failWidget,
    this.clickRefresh,
    this.width,
    this.placeHoldTopHeight,
    this.height,
    this.darkTheme = false,
  }) : super(key: key);

  final ViewState viewState;
  final GestureTapCallback? onTap;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? failWidget;
  final VoidCallbackRefresh? clickRefresh;

  final double? width;
  final double? height;
  final double? placeHoldTopHeight;
  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    final bgColor = darkTheme ? Colours.def_dark_bg_color : Colors.white;
    Widget widget = Container();
    switch (viewState) {
      case ViewState.error:
        widget = failWidget ??
            Container(
              color: bgColor,
              width: width,
              height: height,
              child: Center(
                child: NetworkErrorView(
                  refreshClick: () => clickRefresh?.call(),
                  topHeight: placeHoldTopHeight,
                  darkTheme: darkTheme,
                ),
              ),
            );
        break;
      case ViewState.busy:
        widget = loadingWidget ??
            Container(
              color: bgColor,
              width: width,
              height: height,
              child: Center(child: BaseLoadingPage(darkTheme: darkTheme)),
            );
        break;
      case ViewState.empty:
        widget = emptyWidget ??
            Container(
              color: bgColor,
              width: width,
              height: height,
              child: Center(
                child: BaseEmptyPage(
                  width: width,
                  height: height,
                  onEmptyClick: () => clickRefresh?.call(),
                  darkTheme: darkTheme,
                ),
              ),
            );
        break;
      default:
        widget = loadingWidget ??
            Container(
              color: bgColor,
              width: width,
              height: height,
              child: Center(child: BaseLoadingPage(darkTheme: darkTheme)),
            );
        break;
    }
    return widget;
  }
}

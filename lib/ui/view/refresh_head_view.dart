import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/ui/view/refresh_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FBRefreshHeadView extends StatefulWidget {
  const FBRefreshHeadView({Key? key,
    required this.viewState,
    required this.itemCount,
    required this.itemBuilder,
    required this.controller,
    this.scrollController,
    this.header,
    this.physics,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.enablePullUp = true,
    this.enablePullDown = true,
    this.onRefresh,
    this.onLoadMore,
    this.onClickRefresh,
    this.loadingWidget,
    this.emptyWidget,
    this.failWidget,
    this.placeholderWidth,
    this.placeholderHeight,
    this.headView,
    this.footView,
    this.placeHoldTopHeight,
    this.backgroundColor,
    this.noMoreTest = "",
    this.darkTheme = false,
  }) : super(key: key);

  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final ViewState viewState;
  final bool enablePullUp;
  final bool enablePullDown;
  final VoidCallbackRefresh? onRefresh;
  final VoidCallbackRefresh? onLoadMore;
  final VoidCallbackRefresh? onClickRefresh;
  final int? itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;
  final Widget? header;
  final RefreshController controller;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? failWidget;

  final double? placeholderWidth;
  final double? placeholderHeight;

  final Widget? headView;
  final Widget? footView;

  final Color? backgroundColor;

  final String noMoreTest;
  final double? placeHoldTopHeight;
  final bool darkTheme;

  @override
  State<FBRefreshHeadView> createState() => _FBRefreshHeadViewState();
}


class _FBRefreshHeadViewState extends State<FBRefreshHeadView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SmartRefresher(
        enablePullDown: widget.enablePullDown,
        enablePullUp: widget.enablePullUp,
        scrollController: widget.scrollController,
        physics: widget.physics,
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
          completeText: S.current.refresh_header_success,
          textStyle: TextStyle(color: Colours.text_color_4, fontSize: 12.sp),
          completeIcon: null,
        ),
        footer: ClassicFooter(
          noDataText: (widget.itemCount ?? 0) > 0
              ? S.current.refresh_footer_noMore
              : "",
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
        child: CustomScrollView(slivers: <Widget>[
          // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                widget.headView ?? Container(),

              ],
            ),
          ),
          widget.viewState == ViewState.success
              ? SliverList(
            delegate: SliverChildBuilderDelegate(widget.itemBuilder,
                childCount: widget.itemCount),
          )
              : SliverList(
              delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return StatusViews(
                      darkTheme: widget.darkTheme,
                      viewState: widget.viewState,
                      failWidget: widget.failWidget,
                      emptyWidget: widget.emptyWidget,
                      loadingWidget: widget.loadingWidget,
                      clickRefresh: widget.onClickRefresh ?? widget.onRefresh,
                      width: widget.placeholderWidth,
                      height: widget.placeholderHeight,
                      placeHoldTopHeight: widget.placeHoldTopHeight,
                    );
                  }, childCount: 1)),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                if(widget.viewState == ViewState.success || widget.viewState == ViewState.empty) widget.footView ?? Container()

              ],
            ),
          )

        ]),
      ),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }

  Widget buildFloatingActionButton() {

    return  FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.keyboard_arrow_up,
        ),
        onPressed: () {
          widget.scrollController?.animateTo(0.0,
              duration:  Duration(milliseconds: 300), curve: Curves.linear);
        });
  }
}
import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/ui/view/refresh_view.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter/cupertino.dart';

class BaseView extends StatelessWidget {
  const BaseView({
    Key? key,
    this.child,
    this.viewState,
    this.loadingWidget,
    this.emptyWidget,
    this.failWidget,
    this.height,
    this.placeHoldTopHeight,
    this.clickRefresh,
    this.darkTheme = false,
  }) : super(key: key);

  final Widget? child;
  final ViewState? viewState;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? failWidget;
  final VoidCallbackRefresh? clickRefresh;
  final double? height;
  final double? placeHoldTopHeight;
  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (viewState == ViewState.success)
          ? (child ?? Container())
          : StatusViews(
              darkTheme: darkTheme,
              width: ScreenHelper.screenWidth,
              height: height ?? ScreenHelper.screenHeight,
              viewState: viewState ?? ViewState.busy,
              failWidget: failWidget,
              placeHoldTopHeight: placeHoldTopHeight,
              emptyWidget: emptyWidget,
              loadingWidget: loadingWidget,
              clickRefresh: clickRefresh,
            ),
    );
  }
}

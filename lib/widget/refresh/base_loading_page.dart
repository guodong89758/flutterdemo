import 'package:bitfrog/widget/app_activity_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../generated/l10n.dart';
import '../../res/colors.dart';

class BaseLoadingPage extends StatelessWidget {
  const BaseLoadingPage({Key? key, this.darkTheme = false}) : super(key: key);
  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Expanded(
            flex: 2,
            child: SizedBox(),
          ),
          const SizedBox(
            width: 60.0,
            height: 60.0,
            // child: SpinKitCircle(
            //   color: Colours.def_green,
            //   size: 30.0,
            // ),
            child: AppActivityIndicator(),
          ),
          Text(
            S.of(context).def_loading,
            style: TextStyle(
              color: darkTheme ? Colours.text_color_3 : Colours.text_color_4,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.0,
              decoration: TextDecoration.none,
            ),
          ),
          const Expanded(
            flex: 3,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}

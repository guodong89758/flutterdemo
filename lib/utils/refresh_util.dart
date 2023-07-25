import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../generated/l10n.dart';

class RefreshUtil {
  RefreshUtil._internal();

  static init(Widget child) {
    return RefreshConfiguration(
        headerBuilder: () => ClassicHeader(
              textStyle: const TextStyle(color: Colours.text_color_4, fontSize: 12),
              spacing: 0,
              completeIcon: Gaps.empty,
              failedIcon: Gaps.empty,
              idleIcon: const Icon(Icons.arrow_downward,
                  color: Colours.text_color_4, size: 25),
              releaseIcon: const Icon(Icons.arrow_upward,
                  color: Colours.text_color_4, size: 25),
              releaseText: '',
              refreshingText: '',
              failedText: S.current.refresh_header_fail,
              completeText: S.current.refresh_header_success,
              idleText: '',

              refreshingIcon: const SizedBox(
                width: 25.0,
                height: 25.0,
                child: CupertinoActivityIndicator(color: Colours.text_color_4),
              ),
            ),
        footerBuilder: () => ClassicFooter(
              height: 60,
              textStyle:
                  const TextStyle(fontSize: 12, color: Colours.text_color_4),
              loadingText: S.current.load_loading,
              canLoadingText: '',
              idleText: '',
              failedText: '',
              loadingIcon:
                  const CupertinoActivityIndicator(color: Colours.text_color_4),
            ),
        child: child);
  }
}

import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/widget/behavior/over_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';
import '../../res/colors.dart';

typedef OnActionClickListener = void Function(int index, String action);

class ActionListDialog extends StatefulWidget {
  const ActionListDialog({
    Key? key,
    required this.actionList,
    required this.selectAction,
    required this.clickListener,
  }) : super(key: key);
  final List<String>? actionList;
  final String? selectAction;
  final OnActionClickListener? clickListener;

  @override
  State<ActionListDialog> createState() => _ActionListDialogState();
}

class _ActionListDialogState extends State<ActionListDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 396.h),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child: ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.actionList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildActionItem(
                        context, index, widget.actionList?[index] ?? '');
                  },
                ),
              )),
          Gaps.spaceView,
          InkWell(
            onTap: () {
              Routers.goBack(context);
            },
            child: Container(
              height: 60.h,
              alignment: Alignment.center,
              child: Text(S.current.action_cancel,
                  style:
                      TextStyle(color: Colours.text_color_4, fontSize: 16.sp)),
            ),
          )
        ],
      ),
    ));
  }

  Widget _buildActionItem(BuildContext context, int index, String action) {
    return InkWell(
        onTap: () {
          Routers.goBack(context);
          if (widget.clickListener == null) {
            return;
          }
          widget.clickListener!(index, action);
        },
        child: SizedBox(
          height: 55.h,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Center(
                child: Text(action,
                    style: TextStyle(
                        color: action == widget.selectAction
                            ? Colours.def_green
                            : Colours.text_color_3,
                        fontSize: 16.sp,
                        fontWeight: action == widget.selectAction
                            ? BFFontWeight.medium
                            : BFFontWeight.normal)),
              )),
              index == (widget.actionList?.length ?? 0) - 1
                  ? Gaps.empty
                  : Gaps.hLine
            ],
          ),
        ));
  }
}

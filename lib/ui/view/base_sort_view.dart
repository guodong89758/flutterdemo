import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseSortView extends StatefulWidget {
  const BaseSortView(
      {Key? key,
      required this.sortList,
      required this.onChanged,
      this.selection = 0})
      : super(key: key);
  final List<String>? sortList;
  final int selection;
  final ValueChanged<int> onChanged;

  @override
  State<BaseSortView> createState() => _BaseSortViewState();
}

class _BaseSortViewState extends State<BaseSortView>
    with AutomaticKeepAliveClientMixin<BaseSortView> {
  late int curIndex;
  late String curSort;

  @override
  void initState() {
    super.initState();
    curIndex = widget.selection;
    curSort = widget.sortList?[curIndex] ?? '';
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colours.white,
      width: ScreenHelper.screenWidth,
      height: 50.h * (widget.sortList?.length ?? 0),
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.sortList?.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildActionItem(
                  context, index, widget.sortList?[index] ?? '');
            },
          )),
    );
  }

  Widget _buildActionItem(BuildContext context, int index, String title) {
    return InkWell(
        onTap: () {
          setState(() {
            curIndex = index;
            curSort = title;
          });
          widget.onChanged(curIndex);
        },
        child: Container(
          height: 50.h,
          alignment: Alignment.center,
          child: Text(title,
              style: TextStyle(
                  color: curIndex == index
                      ? Colours.def_green
                      : Colours.text_color_2,
                  fontSize: 14.sp,
                  fontWeight: BFFontWeight.normal)),
        ));
  }
}

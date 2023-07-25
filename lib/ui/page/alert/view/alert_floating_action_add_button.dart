import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/ui/page/community/community_square_index_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlterFloatingActionAddButton extends StatelessWidget {
  final GestureTapCallback? onTap;

  const AlterFloatingActionAddButton({Key? key, this.onTap}) : super(key: key);

  static FloatingActionButtonLocation location = CustomFloatingActionButtonLocation(
    FloatingActionButtonLocation.endFloat,
    -14.w,
    -75.h,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 65.w,
        height: 65.h,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff73EBBB), Color(0xff16BE8C)],
            ),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFFB4E6D2),
                  offset: Offset(1, 5),
                  blurRadius: 6,
                  spreadRadius: 0)
            ]),
        child: Center(
          child: Image.asset(Assets.imagesAlertAdd, width: 26.w),
        ),
      ),
    );
  }
}

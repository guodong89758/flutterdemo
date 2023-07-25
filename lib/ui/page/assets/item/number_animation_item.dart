
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberAnimationItem extends StatelessWidget {
  const NumberAnimationItem({Key? key,
    required this.number,
    required this.animationController,
    this.textStyle,
    this.assetsVisible = false
  }) : super(key: key);

  final AnimationController animationController;
  final String number;
  final TextStyle? textStyle;
  final bool assetsVisible;

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = Tween(
        begin: 0.0,
        end:
        double.parse(number))
        .chain(CurveTween(curve: Curves.decelerate))
        .animate(animationController);
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Text(
            assetsVisible
                ? number
                : '******',
            style: textStyle ?? TextStyle(
                color: Colours.text_color_2,
                fontSize: 25.sp,
                fontWeight: BFFontWeight.bold,),
          );
        });
  }
}

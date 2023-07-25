import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/model/asset_currency_entity.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/widget/behavior/over_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetCurrencyDialog extends StatefulWidget {
  const AssetCurrencyDialog({
    Key? key,
    required this.currencyList,
    required this.onSelected,
  }) : super(key: key);
  final List<AssetCurrencyEntity>? currencyList;
  final ValueChanged<AssetCurrencyEntity>? onSelected;

  @override
  State<AssetCurrencyDialog> createState() => _AssetCurrencyDialogState();
}

class _AssetCurrencyDialogState extends State<AssetCurrencyDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      decoration: const BoxDecoration(
        color: Colours.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4), bottomRight: Radius.circular(4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 45.h,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: <Widget>[
                Center(
                    child: Text(S.current.asset_currency_selecct,
                        style: TextStyle(
                            color: Colours.text_color_2,
                            fontSize: 15.sp,
                            fontWeight: BFFontWeight.medium))),
                Positioned(
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        Routers.goBack(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        height: 45.h,
                        alignment: Alignment.center,
                        child: Image(
                            width: 20.w,
                            height: 20.h,
                            image: ImageUtil.getAssetImage(
                                Assets.imagesBaseDialogClose)),
                      ),
                    ))
              ],
            ),
          ),
          Gaps.hLine,
          Flexible(
              child: ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.currencyList?.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildActionItem(context, index,
                    widget.currencyList?[index] ?? AssetCurrencyEntity());
              },
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildActionItem(
      BuildContext context, int index, AssetCurrencyEntity currency) {
    return InkWell(
        onTap: () {
          Routers.goBack(context);
          if (widget.onSelected == null) {
            return;
          }
          widget.onSelected!(currency);
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          height: 50.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colours.def_view_bg_1_color,
                radius: 9,
                backgroundImage: ImageUtil.getImageProvider(currency.icon,
                    holderImg: Assets.imagesAlertDefault),
              ),
              SizedBox(width: 6.w),
              Text(
                currency.currency ?? '',
                style: TextStyle(
                    color: Colours.text_color_2,
                    fontSize: 14.sp,
                    fontFamily: BFFontFamily.din,
                    fontWeight: BFFontWeight.medium),
              ),
              SizedBox(width: 6.w),
              Text(currency.fullName ?? '',
                  style: TextStyle(
                      color: Colours.text_color_4,
                      fontSize: 14.sp,
                      fontFamily: BFFontFamily.din,
                      fontWeight: BFFontWeight.normal)),
            ],
          ),
        ));
  }
}

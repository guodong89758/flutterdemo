import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/model/asset_account_entity.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/widget/behavior/over_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetAccountDialog extends StatefulWidget {
  const AssetAccountDialog({
    Key? key,
    required this.accountList,
    required this.onSelected,
  }) : super(key: key);
  final List<AssetAccountEntity>? accountList;
  final ValueChanged<AssetAccountEntity>? onSelected;

  @override
  State<AssetAccountDialog> createState() => _AssetAccountDialogState();
}

class _AssetAccountDialogState extends State<AssetAccountDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 380.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 14.w),
              height: 45.h,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(S.current.asset_account_select,
                      style: TextStyle(
                          color: Colours.text_color_2,
                          fontSize: 18.sp,
                          fontWeight: BFFontWeight.medium)),
                  InkWell(
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
                  )
                ],
              ),
            ),
            Gaps.hLine,
            Flexible(
                child: ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.accountList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildAccountItem(
                      context,
                      index,
                      widget.accountList?.length ?? 0,
                      widget.accountList?[index] ?? AssetAccountEntity());
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountItem(
      BuildContext context, int index, int count, AssetAccountEntity account) {
    double topMargin = 7.5.h;
    double bottomMargin = 7.5.h;
    if (index == 0) {
      topMargin = 20.h;
    } else if (index == count - 1) {
      bottomMargin = 30.h;
    }
    return InkWell(
        onTap: () {
          Routers.goBack(context);
          if (widget.onSelected == null) {
            return;
          }
          widget.accountList?.forEach((element) {
            element.checked = false;
          });
          setState(() {
            account.checked = true;
          });
          widget.onSelected!(account);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(14.w, topMargin, 14.w, bottomMargin),
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          alignment: Alignment.centerLeft,
          height: 45.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colours.def_line_1_color, width: 1.w),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                account.name ?? '',
                style: TextStyle(
                    color: Colours.text_color_2,
                    fontSize: 14.sp,
                    fontWeight: BFFontWeight.medium),
              ),
              SizedBox(width: 6.w),
              Container(
                height: 16.h,
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    color: Colours.def_yellow_15),
                alignment: Alignment.center,
                child: Text(
                  account.type ?? '',
                  style: TextStyle(color: Colours.def_yellow, fontSize: 10.sp),
                ),
              ),
              Expanded(child: Container()),
              Visibility(
                visible: account.checked ?? false,
                child: Image(
                    width: 20.w,
                    height: 20.h,
                    image: ImageUtil.getAssetImage(
                        Assets.imagesBaseOptionSelected)),
              )
            ],
          ),
        ));
  }
}

import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/model/assets_info_entity.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowAccountItem extends StatefulWidget {
  const FollowAccountItem(
      {Key? key, required this.item, required this.assetsVisible})
      : super(key: key);
  final ContractEntity item;
  final bool assetsVisible;

  @override
  State<FollowAccountItem> createState() => _FollowAccountItemState();
}

class _FollowAccountItemState extends State<FollowAccountItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Parameters params = Parameters()
          ..putString('followId', widget.item.followId ?? '');
        Routers.navigateTo(context, Routers.copyTradeMineDetailPage,
            parameters: params);
      },
      child: Column(
        children: [
          SizedBox(height: 15.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  widget.item.planName ?? '',
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colours.text_color_2,
                    fontSize: 14.sp,
                    fontWeight: BFFontWeight.medium,
                  ),
                ),
              ),
              Image(
                width: 10.w,
                height: 10.h,
                image: ImageUtil.getAssetImage(Assets.imagesBaseArrowRight),
              ),
              SizedBox(width: 14.w),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 14.w),
              CircleAvatar(
                backgroundColor: Colours.def_view_bg_1_color,
                radius: 10,
                backgroundImage: ImageUtil.getImageProvider(
                    widget.item.masterAvatar,
                    holderImg: Assets.imagesBaseDefAvatar),
              ),
              SizedBox(width: 6.w),
              Text(
                widget.item.masterName ?? '',
                style: TextStyle(color: Colours.text_color_2, fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.assetsVisible
                          ? StringUtil.formatPrice(
                              widget.item.accountAsset ?? '')
                          : '******',
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colours.text_color_2,
                        fontSize: 15.sp,
                        fontWeight: BFFontWeight.medium,
                        fontFamily: BFFontFamily.din,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 3.h),
                        child: Text(
                            '${S.current.asset_follow_asset}(${widget.item.assetUnit})',
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colours.text_color_4,
                              fontSize: 11.sp,
                            )))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.assetsVisible
                          ? StringUtil.formatPrice(widget.item.profit ?? '')
                          : '******',
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: StringUtil.getRealColor(
                            widget.item.profit ?? '', Colours.text_color_2),
                        fontSize: 15.sp,
                        fontWeight: BFFontWeight.medium,
                        fontFamily: BFFontFamily.din,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 3.h),
                        child: Text(
                            '${S.current.base_profit}(${widget.item.profitUnit})',
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colours.text_color_4,
                              fontSize: 11.sp,
                            )))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.assetsVisible
                          ? '${widget.item.profitRatio}%'
                          : '******',
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: StringUtil.getRealColor(
                            widget.item.profitRatio ?? '',
                            Colours.text_color_2),
                        fontSize: 15.sp,
                        fontWeight: BFFontWeight.medium,
                        fontFamily: BFFontFamily.din,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 3.h),
                        child: Text(S.current.base_profit_rate,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colours.text_color_4,
                              fontSize: 11.sp,
                            )))
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.only(left: 14.w),
            child: Gaps.hLine,
          )
        ],
      ),
    );
  }
}

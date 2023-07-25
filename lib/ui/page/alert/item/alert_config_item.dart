import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/alert_config_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertConfigItem extends StatelessWidget {
  final int? index;
  final int? count;
  final AlertConfigEntity config;

  const AlertConfigItem(
      {Key? key, this.index, this.count, required this.config})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(Routers.goLogin(context)) return;
        if (index == 0) {
          Routers.navigateTo(context, Routers.alertPricePage);
        } else if (index == 1) {
          Parameters parameters = Parameters();
          parameters.putString("tip", config.set_page_desc ?? '');
          Routers.navigateTo(context, Routers.alertSharpPricePage,
              parameters: parameters);
        } else {
          Parameters parameters = Parameters();
          parameters.putString("type", config.type ?? '');
          parameters.putString("title", config.title ?? '');
          parameters.putString("tip", config.set_page_desc ?? '');
          Routers.navigateTo(context, Routers.alertIndexPage,parameters: parameters);
        }
      },
      child: SizedBox(
        width: ScreenHelper.screenWidth,
        child: IntrinsicHeight(
          child: Container(
            margin:
                EdgeInsets.fromLTRB(14, 15, 14, index == count! - 1 ? 15 : 0),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colours.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                    color: Colours.shadow_color,
                    offset: Offset(1, 1),
                    blurRadius: 7.0,
                    spreadRadius: 1)
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        width: 55.w,
                        height: 55.h,
                        imageUrl: config.icon ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Image.asset(Assets.imagesAlertDefault),
                        errorWidget: (context, url, error) =>
                            Image.asset(Assets.imagesAlertDefault),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 12),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(right: 65),
                                child: Text(config.title ?? '',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Colours.text_color_1,
                                        fontSize: Dimens.font_sp14,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                width: ScreenHelper.screenWidth -
                                    ScreenHelper.width(125),
                                margin: const EdgeInsets.only(top: 6),
                                child: Text(config.desc ?? '',
                                    style: const TextStyle(
                                        color: Colours.text_color_4,
                                        fontSize: Dimens.font_sp12,
                                        fontWeight: FontWeight.normal)),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: (config.set_cnt ?? 0) > 0
                        ? _buildCountText(config.set_cnt!)
                        : Text(S.current.alert_not_set,
                            style: const TextStyle(
                                color: Colours.text_color_4,
                                fontSize: Dimens.font_sp12,
                                fontWeight: FontWeight.normal)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountText(num setCount) {
    return RichText(
        text: TextSpan(
            text: S.current.alert_opened,
            style: const TextStyle(
                color: Colours.text_color_4,
                fontSize: Dimens.font_sp12,
                fontWeight: FontWeight.normal),
            children: [
          TextSpan(
              text: ' $setCount ',
              style: const TextStyle(
                  color: Colours.app_main,
                  fontSize: Dimens.font_sp12,
                  fontWeight: FontWeight.normal)),
          TextSpan(
              text: S.current.alert_term,
              style: const TextStyle(
                  color: Colours.text_color_4,
                  fontSize: Dimens.font_sp12,
                  fontWeight: FontWeight.normal))
        ]));
  }
}

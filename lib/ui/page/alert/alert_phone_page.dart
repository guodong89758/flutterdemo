import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/alert_phone_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/item/alert_phone_item.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_phone_model.dart';
import 'package:bitfrog/ui/view/refresh_view.dart';
import 'package:bitfrog/ui/view/show_alert_view.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:bitfrog/widget/dialog/common_dialog.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///电话提醒页面
class AlertPhonePage extends StatefulWidget {
  const AlertPhonePage({Key? key}) : super(key: key);

  @override
  State<AlertPhonePage> createState() => _AlertPhonePageState();
}

class _AlertPhonePageState extends State<AlertPhonePage>
    with
        BasePageMixin<AlertPhonePage>,
        AutomaticKeepAliveClientMixin<AlertPhonePage>,
        SingleTickerProviderStateMixin {
  final RefreshController _refreshController = RefreshController();
  late AlertPhoneModel _phoneModel;

  @override
  void initState() {
    super.initState();
    _phoneModel = AlertPhoneModel();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AlertPhoneModel>(
      model: _phoneModel,
      builder: (context, model, child) {
        String? phoneNumber = model.phoneData?.userMobile;
        bool hasPhoneNumber = phoneNumber != null && phoneNumber.isNotEmpty;

        Widget emptyWidget = BaseEmptyPage(onEmptyClick: () {
          _phoneModel.refresh();
        });
        return FBRefresherView(
            backgroundColor: Colours.def_view_bg_1_color,
            viewState: model.viewState,
            emptyWidget: emptyWidget,
            controller: _refreshController,
            itemCount: model.phoneData?.subscribes?.length ?? 0,
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: model.refresh,
            onClickRefresh: model.clickRefresh,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Card(
                      color: Colours.white,
                      shadowColor: Colours.shadow_color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: ScreenHelper.height(7),
                      margin: EdgeInsets.fromLTRB(14.w, 15.h, 14.w, 5.h),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  S.current.alert_phone_title,
                                  style: TextStyle(
                                      color: Colours.text_color_4,
                                      fontSize: 14.sp,
                                      height: 1.0),
                                ),
                                hasPhoneNumber
                                    ? Text(
                                        phoneNumber,
                                        style: TextStyle(
                                          color: Colours.text_color_2,
                                          fontSize: 14.sp,
                                          height: 1.0,
                                          fontWeight: BFFontWeight.medium,
                                        ),
                                      )
                                    : InkWell(
                                        highlightColor: Colours.transparent,
                                        splashColor: Colours.transparent,
                                        onTap: () {
                                          Parameters parameter = Parameters();
                                          parameter.putBool('isEmail', false);

                                          parameter.putString(
                                              'title',
                                              S.current
                                                  .user_security_phone_subtitle);
                                          Routers.navigateTo(context,
                                              Routers.mineBindPhoneEmailPage,
                                              parameters: parameter);
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              S.current.alert_bind_phone_no,
                                              style: const TextStyle(
                                                  color: Colours.def_yellow,
                                                  fontSize: Dimens.font_sp13,
                                                  decoration: TextDecoration
                                                      .underline,
                                                  height: 1.0),
                                            ),
                                            SizedBox(width: 6.w),
                                            Image.asset(
                                              Assets.imagesBaseBind,
                                              width: 12.w,
                                              height: 12.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                Visibility(
                                  visible: hasPhoneNumber,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      _phoneModel.phoneTestInfo(context);
                                    },
                                    child: Container(
                                      height: 18.h,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6.w),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 6.w),
                                      decoration:
                                          BoxDecorations.cardBoxDecoration(
                                        color: Colours.def_view_bg_1_color,
                                        radius: 1,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        S.current.alert_voice_test,
                                        style: TextStyle(
                                            color: Colours.text_color_3,
                                            fontSize: 11.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(child: Container()),
                                InkWell(
                                  highlightColor: Colours.transparent,
                                  splashColor: Colours.transparent,
                                  onTap: () {
                                    if (!hasPhoneNumber) {
                                      showBindPhoneDialog(
                                          S.current.alert_bind_phone);
                                      return;
                                    }
                                    Routers.navigateTo(
                                        context, Routers.voicePage);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.current.action_to_deposit,
                                        style: TextStyle(
                                          color: Colours.def_yellow,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(width: ScreenHelper.width(3)),
                                      Image(
                                          width: ScreenHelper.width(10),
                                          height: ScreenHelper.height(10),
                                          image: ImageUtil.getAssetImage(Assets
                                              .imagesBaseArrowRightYellow))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    S.current.alert_voice_count_title,
                                    style: TextStyle(
                                        color: Colours.text_color_4,
                                        fontSize: 14.sp,
                                        height: 1.0),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${_phoneModel.phoneData?.voiceAmount ?? 0}',
                                      style: TextStyle(
                                        color: Colours.text_color_2,
                                        fontSize: 14.sp,
                                        height: 1.0,
                                        fontWeight: BFFontWeight.medium,
                                      ),
                                    ),
                                  ),
                                ]),
                            SizedBox(height: 10.h),
                            Text(S.current.alert_text_7,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colours.text_color_4,
                                    fontSize: 11.sp))
                          ],
                        ),
                      )),
                ),
                // SliverToBoxAdapter(
                //     child: SizedBox(
                //   width: ScreenHelper.screenWidth,
                //   height: ScreenHelper.height(20),
                //   child: Stack(
                //     fit: StackFit.expand,
                //     alignment: Alignment.centerLeft,
                //     children: [
                //       Positioned(
                //           left: 24,
                //           child: Text(
                //             S.current.alert_info,
                //             style: TextStyle(
                //                 color: Colours.text_color_4, fontSize: 14.sp),
                //           )),
                //       Positioned(
                //           right: 24,
                //           child: Text(
                //             S.current.alert_tab_2,
                //             style: TextStyle(
                //                 color: Colours.text_color_4, fontSize: 14.sp),
                //           )),
                //     ],
                //   ),
                // )),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    PhoneType? typeItem = model.phoneData?.subscribes?[index];
                    return AlertPhoneItem(
                        index: index,
                        useDing: false,
                        count: model.phoneData?.subscribes?.length,
                        item: typeItem,
                        onChange: (phoneItem) {
                          showProgress();
                          model.setItem = phoneItem;
                          model.updateVoiceAlert(
                              phoneItem.id ?? 0, phoneItem.phoneSwitch ?? 0);
                        });
                  }, childCount: model.phoneData?.subscribes?.length),
                ),
              ],
            ));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> refresh({slient = false}) {
    if (slient) {
      return _phoneModel.refresh();
    } else {
      return Future<void>.delayed(const Duration(milliseconds: 100), () {
        _refreshController.requestRefresh();
      });
    }
  }

  void initViewModel() {
    _phoneModel.refresh();
    _phoneModel.listenEvent();
    _phoneModel.addListener(() {
      _refreshController.refreshCompleted();

      if (_phoneModel.isError) {
        closeProgress();
        setState(() {
          _phoneModel.setItem?.phoneSwitch = 0;
        });
        if (_phoneModel.viewStateError!.code == 5002) {
          //绑定手机
          showBindPhoneDialog(_phoneModel.viewStateError!.message ??
              S.current.alert_bind_phone);
        } else if (_phoneModel.viewStateError!.code == 5009) {
          //加数据语音
          showVoiceDepositDialog(_phoneModel.viewStateError!.message ??
              S.current.alert_voice_empty);
        }
      } else {
        closeProgress();
      }
    });
  }

  void showBindPhoneDialog(String msg) {
    AlertView.showAlertDig(context,
        message: msg,
        cancel: S.current.action_cancel,
        confirm: S.current.action_bind, confirmClick: () {
      // Routers.navigateTo(context, Routers.mineBindPhonePage);
      Parameters parameter = Parameters();
      parameter.putBool('isEmail', false);

      parameter.putString('title', S.current.user_security_phone_subtitle);
      Routers.navigateTo(context, Routers.mineBindPhoneEmailPage,
          parameters: parameter);
    });
    // showDialog<void>(
    //   context: context,
    //   barrierDismissible: true,
    //   // false = user must tap button, true = tap outside dialog
    //   builder: (BuildContext dialogContext) {
    //     return CommonDialog(
    //       content: msg,
    //       action2: S.current.action_bind,
    //       onCancel: () {
    //         Routers.goBack(context);
    //       },
    //       onAction: () {
    //         // FlutterPigeonPlugin.instance.gotoAppView(
    //         //     'bitfrog://app.bitfrog.com/user/bindphoneactivity');
    //         // Routers.goBack(context);
    //       },
    //     );
    //   },
    // );
  }

  void showVoiceDepositDialog(String msg) {
    showDialog<void>(
      context: context,

      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return CommonDialog(
          content: msg,
          isLongLine:true,
          action2: S.current.action_deposit,
          onCancel: () {
            Routers.goBack(context);
          },
          onAction: () {
            Routers.goBack(context);
            Routers.navigateTo(context, Routers.voicePage);
          },
        );
      },
    );
  }
}

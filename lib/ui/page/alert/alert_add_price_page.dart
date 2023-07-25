import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/logic/link_manger.dart';
import 'package:bitfrog/model/channel_entity.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/alert_symbol_page.dart';
import 'package:bitfrog/ui/page/alert/item/alert_price_item.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_add_price_model.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/utils/string_util.dart';
import 'package:bitfrog/widget/dialog/common_dialog.dart';
import 'package:bitfrog/widget/dialog/tip_dialog.dart';
import 'package:bitfrog/widget/dividers.dart';
import 'package:bitfrog/widget/precision_limit_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 添加价格提醒页面
class AlertAddPricePage extends StatefulWidget {
  final BFSymbol? symbol; //交易对信息
  const AlertAddPricePage({Key? key, this.symbol}) : super(key: key);

  @override
  State<AlertAddPricePage> createState() => _AlertAddPricePageState();
}

class _AlertAddPricePageState extends State<AlertAddPricePage>
    with
        BasePageMixin<AlertAddPricePage>,
        AutomaticKeepAliveClientMixin<AlertAddPricePage>,
        SingleTickerProviderStateMixin {
  final TextEditingController _riseController = TextEditingController();
  final TextEditingController _fallController = TextEditingController();
  final FocusNode _riseFocus = FocusNode();
  final FocusNode _fallFocus = FocusNode();
  late AlertAddPriceModel _addPriceModel;
  late bool _btnEnable = false;

  @override
  void initState() {
    super.initState();
    _addPriceModel = AlertAddPriceModel(_riseController, _fallController);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
    _riseController.addListener(() {
      refreshButton();
    });
    _fallController.addListener(() {
      refreshButton();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AlertAddPriceModel>(
      model: _addPriceModel,
      builder: (context, model, child) {
        return Scaffold(
            body: Material(
                color: Colours.white,
                child: SafeArea(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTitleBar(),
                    Expanded(child: _buildContent()),
                  ],
                ))));
      },
    );
  }

  @override
  void dispose() {
    _riseFocus.dispose();
    _fallFocus.dispose();
    _riseController.dispose();
    _fallController.dispose();
    super.dispose();
  }

  Widget _buildContent() {
    return GestureDetector(
        //表示透明也响应处理
        behavior: HitTestBehavior.translucent,
        onTap: () {
          //收起键盘
          // FocusScope.of(context).requestFocus(FocusNode());
          _riseFocus.unfocus();
          _fallFocus.unfocus();
        },
        child: Scrollbar(
            child: SingleChildScrollView(
          child: IntrinsicHeight(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAddPrice(),
              _addPriceModel.currentList.isNotEmpty
                  ? Gaps.spaceView
                  : Gaps.empty,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    _addPriceModel.currentList.length,
                    (index) => AlertPriceItem(
                      showBottomLine: false,
                      item: _addPriceModel.currentList[index],
                      onDelete: (id) {
                        if (id != null) {
                          _addPriceModel.deletePriceAlert(id);
                        }
                      },
                    ),
                  ).toList(),
                ),
              ),
            ],
          )),
        )));
  }

  /// 搜索框
  Widget _buildTitleBar() {
    return Container(
      color: Colours.white,
      width: ScreenHelper.screenWidth,
      height: Dimens.def_title_height,
      child: Stack(
        // fit: StackFit.expand,
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
              left: 0,
              child: IconButton(
                  iconSize: ScreenHelper.width(20),
                  padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Routers.goBack(context);
                    } else {
                      SystemNavigator.pop();
                    }
                  },
                  icon: Image.asset(Assets.imagesBaseBack))),
          Container(
              margin: const EdgeInsets.only(left: 50, right: 50),
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colours.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          height: ScreenHelper.screenHeight - 76,
                          decoration: const BoxDecoration(
                            color: Colours.white,
                            borderRadius: BorderRadius.only(
                                // topLeft: Radius.circular(15),
                                // topRight: Radius.circular(15)
                                ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: InkWell(
                                    onTap: () {
                                      Routers.goBack(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 15),
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                          Assets.imagesBaseDownLine,
                                          width: ScreenHelper.width(20),
                                          height: ScreenHelper.height(20)),
                                    )),
                              ),
                              const Expanded(child: AlertSymbolPage(type: 1))
                            ],
                          ),
                        );
                      });
                },
                child: Center(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                          '${_addPriceModel.curSymbol?.exchangeTitle ?? ''} ${_addPriceModel.curSymbol?.symbolTitle ?? ''}',
                          style: const TextStyle(
                              color: Colours.text_color_1,
                              fontSize: Dimens.font_sp17,
                              fontFamily: 'Din',
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Image(
                          image: ImageUtil.getAssetImage(Assets.imagesBaseDown),
                          width: ScreenHelper.width(8),
                          height: ScreenHelper.height(5.5),
                        )),
                  ],
                )),
              )),
        ],
      ),
    );
  }

  /// 添加价格提醒
  Widget _buildAddPrice() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100.h,
          alignment: Alignment.center,
          child: Text(
            StringUtil.formatPrice(_addPriceModel.curPrice ?? '0'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colours.text_color_2,
              fontSize: 33.sp,
              fontFamily: BFFontFamily.din,
              fontWeight: BFFontWeight.bold,
            ),
          ),
        ),
        Gaps.spaceView,
        Flexible(
            fit: FlexFit.loose,
            child: Container(
                padding: EdgeInsets.only(left: 14.w),
                margin: EdgeInsets.only(bottom: 8.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: ScreenHelper.height(60),
                        padding: EdgeInsets.only(right: 14.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              S.current.alert_price_rise,
                              style: const TextStyle(
                                  color: Colours.text_color_2,
                                  fontSize: Dimens.font_sp14),
                            ),
                            Expanded(
                                child: TextField(
                              controller: _riseController,
                              focusNode: _riseFocus,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9.]")),
                                LengthLimitingTextInputFormatter(30),
                                PrecisionLimitFormatter(
                                    _addPriceModel.scale) //小数精度限制
                                //限制长度
                              ],
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                hintText: S.current.alert_price_hint,
                                hintStyle: const TextStyle(
                                    color: Colours.text_color_5,
                                    fontSize: Dimens.font_sp14,
                                    fontWeight: FontWeight.normal,
                                    textBaseline: TextBaseline.alphabetic),
                                border: InputBorder.none,
                              ),
                              cursorColor: Colours.app_main,
                              // cursorHeight: ScreenHelper.height(18),
                              style: TextStyle(
                                  color: Colours.def_green,
                                  fontSize: 15.sp,
                                  fontFamily: BFFontFamily.din,
                                  fontWeight: FontWeight.bold,
                                  textBaseline: TextBaseline.alphabetic,
                                  height: 1.4),
                              minLines: 1,
                            ))
                          ],
                        ),
                      ),
                      const HDivider(),
                      Container(
                        height: ScreenHelper.height(60),
                        padding: EdgeInsets.only(right: 14.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              S.current.alert_price_fall,
                              style: const TextStyle(
                                  color: Colours.text_color_2,
                                  fontSize: Dimens.font_sp14),
                            ),
                            Expanded(
                                child: TextField(
                              controller: _fallController,
                              focusNode: _fallFocus,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9.]")),
                                LengthLimitingTextInputFormatter(30),
                                PrecisionLimitFormatter(
                                    _addPriceModel.scale) //小数精度限制
                                //限制长度
                              ],
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                hintText: S.current.alert_price_hint,
                                hintStyle: const TextStyle(
                                  color: Colours.text_color_5,
                                  fontSize: Dimens.font_sp14,
                                  fontWeight: FontWeight.normal,
                                  textBaseline: TextBaseline.alphabetic,
                                ),
                                border: InputBorder.none,
                              ),
                              cursorColor: Colours.def_red,
                              // cursorHeight: ScreenHelper.height(18),
                              style: TextStyle(
                                  color: Colours.def_red,
                                  fontSize: 15.sp,
                                  fontFamily: BFFontFamily.din,
                                  fontWeight: FontWeight.bold,
                                  textBaseline: TextBaseline.alphabetic,
                                  height: 1.4),
                              minLines: 1,
                            ))
                          ],
                        ),
                      ),
                      const HDivider(),
                      Container(
                        height: ScreenHelper.height(60),
                        padding: EdgeInsets.only(right: 14.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              S.current.alert_type,
                              style: const TextStyle(
                                  color: Colours.text_color_2,
                                  fontSize: Dimens.font_sp14),
                            ),
                            Expanded(
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: List.generate(
                                        _addPriceModel.channelList.length,
                                        (index) => _buildChannel(_addPriceModel
                                            .channelList[index])).toList()))
                          ],
                        ),
                      ),
                      const HDivider(),
                      Container(
                        height: ScreenHelper.height(60),
                        padding: EdgeInsets.only(right: 14.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => showRepeatDialog(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    S.current.alert_repeat_text,
                                    style: const TextStyle(
                                        color: Colours.text_color_2,
                                        fontSize: Dimens.font_sp14),
                                  ),
                                  SizedBox(width: 4.w),
                                  Image.asset(Assets.imagesBaseHelp, width: 14.w)
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 44.w,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: CupertinoSwitch(
                                  onChanged: (checked) {
                                    setState(() {
                                      _addPriceModel.isRepeat =
                                          !_addPriceModel.isRepeat;
                                    });
                                  },
                                  value: _addPriceModel.isRepeat,
                                  activeColor: Colours.def_green,
                                  trackColor: Colours.def_view_bg_2_color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]))),
        Container(
            width: ScreenHelper.screenWidth - 28,
            height: ScreenHelper.height(40),
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(14.w, 9.h, 14.w, 20.h),
            child: ElevatedButton(
              onPressed: () {
                if (!_btnEnable) {
                  return;
                }
                _addPriceModel.addPriceAlert();
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(
                    ScreenHelper.screenWidth - 28, ScreenHelper.height(40))),
                backgroundColor: MaterialStateProperty.all(
                    _btnEnable ? Colours.app_main : Colours.def_btn_disable),
                shadowColor: MaterialStateProperty.all(Colours.transparent),
                shape: MaterialStateProperty.all(BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(1))),
              ),
              child: Text(
                S.current.alert_price_create,
                style: TextStyle(color: Colours.white, fontSize: 15.sp),
              ),
            ))
      ],
    );
  }

  Widget _buildChannel(ChannelEntity channel) {
    return SizedBox(
      height: ScreenHelper.height(60),
      child: InkWell(
        onTap: () {
          if (channel.type == 12) {
            //APP提醒
            return;
          }
          setState(() {
            channel.checked = !channel.checked;
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image(
                  width: ScreenHelper.width(16),
                  height: ScreenHelper.height(16),
                  image: ImageUtil.getAssetImage(channel.checked
                      ? Assets.imagesBaseCheckYes
                      : Assets.imagesBaseCheckNo),
                )),
            // child: Checkbox(
            //   value: channel.checked ?? false,
            //   checkColor: Colours.white,
            //   activeColor: Colours.app_main,
            //   // fillColor: MaterialStateProperty.all(Colours.def_line_2_color),
            //   onChanged: (bool? value) {
            //     channel.checked = !(channel.checked ?? false);
            //     setState(() {});
            //   },
            // )),
            Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(channel.name ?? '',
                    style: const TextStyle(
                        color: Colours.text_color_3,
                        fontSize: Dimens.font_sp14)))
          ],
        ),
      ),
    );
  }

  void refreshButton() {
    setState(() {
      _btnEnable =
          _riseController.text.isNotEmpty || _fallController.text.isNotEmpty;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> refresh({slient = false}) {
    return Future<void>.delayed(const Duration(milliseconds: 100), () {});
  }

  void initViewModel() {
    _addPriceModel.refresh(widget.symbol);
    _addPriceModel.listenEvent();
    _addPriceModel.addListener(() {
      if (_addPriceModel.isBusy) {
        showProgress();
      } else if (_addPriceModel.isError) {
        closeProgress();
        if (_addPriceModel.viewStateError!.code == 5002) {
          //绑定手机
          showBindPhoneDialog();
        } else if (_addPriceModel.viewStateError!.code == 5009) {
          //加数据语音
          showVoiceDepositDialog(_addPriceModel.viewStateError!.message ??
              S.current.alert_voice_empty);
        }
      } else {
        closeProgress();
      }
    });
  }

  void showBindPhoneDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return CommonDialog(
          content: S.current.alert_bind_phone,
          action2: S.current.action_bind,
          onCancel: () {
            Routers.goBack(context);
          },
          onAction: () {
            Routers.goBack(context);
            LinkManger.schemeJump(
                Uri.parse('bitfrog://app.bitfrog.com/user/bindphoneactivity'));
          },
        );
      },
    );
  }

  void showVoiceDepositDialog(String msg) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return CommonDialog(
          content: msg,
          action2: S.current.action_deposit,
          onCancel: () {
            Routers.goBack(context);
          },
          onAction: () {
            Routers.goBack(context);
            Parameters params = Parameters()..putInt('type', 1);
            Routers.navigateTo(context, Routers.voicePage, parameters: params);
          },
        );
      },
    );
  }

  void showRepeatDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return TipDialog(
          title: S.current.alert_repeat_text,
          content: S.current.alert_repeat_tip,
          action: S.current.action_ok,
          onAction: () {
            Routers.goBack(context);
          },
        );
      },
    );
  }
}

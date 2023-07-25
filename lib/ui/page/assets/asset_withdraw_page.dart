import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/dialog/asset_chain_dialog.dart';
import 'package:bitfrog/ui/page/assets/dialog/asset_currency_dialog.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/asset_withdraw_model.dart';
import 'package:bitfrog/ui/page/mine/item/Line_view_item.dart';
import 'package:bitfrog/ui/page/mine/mine_bind_vercode_page.dart';
import 'package:bitfrog/ui/view/buttons.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:bitfrog/widget/dialog/common_dialog.dart';
import 'package:bitfrog/widget/dividers.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_html_css/simple_html_css.dart';

class AssetWithdrawPage extends StatefulWidget {
  const AssetWithdrawPage({Key? key}) : super(key: key);

  @override
  State<AssetWithdrawPage> createState() => _AssetWithdrawPageState();
}

class _AssetWithdrawPageState extends State<AssetWithdrawPage>
    with BasePageMixin<AssetWithdrawPage> {
  late AssetWithdrawModel _model;
  late bool btnEnable = false;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _numController = TextEditingController();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _numFocus = FocusNode();
  String receiverNum = '0';

  @override
  void initState() {
    super.initState();
    _model = AssetWithdrawModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
    _addressController.addListener(() {
      refreshButton();
    });
    _numController.addListener(() {
      refreshButton();
      if (_numController.text.isNotEmpty) {
        double curNum = double.parse(_numController.text);
        if (curNum > double.parse(_model.selectCurrency?.balance ?? '0')) {
          ToastUtil.show(S.current.asset_withdraw_toast_balance);
        }
        if (curNum <= double.parse(_model.selectChain?.withdrawFee ?? '0')) {
          receiverNum = '0';
        } else {
          receiverNum = (Decimal.parse(_numController.text) -
                  Decimal.parse(_model.selectChain?.withdrawFee ?? '0'))
              .toStringAsFixed(2);
        }
      } else {
        receiverNum = '0';
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _addressFocus.dispose();
    _numFocus.dispose();
    _addressController.dispose();
    _numController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const transparentInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    );

    return ProviderWidget<AssetWithdrawModel>(
        model: _model,
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colours.white,
            appBar: MyAppBar(
              title: S.current.action_withdraw,
              bottomLine: true,
              action: InkWell(
                onTap: () {
                  Parameters parameters = Parameters()
                    ..putInt("type", 2)
                    ..putString(
                        "currency", _model.selectCurrency?.currency ?? 'USDT');
                  Routers.navigateTo(context, Routers.assetsRecord,
                      parameters: parameters);
                },
                child: Container(
                  height: 40.h,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  alignment: Alignment.center,
                  child: Image(
                      width: 20.w,
                      height: 20.h,
                      image:
                          ImageUtil.getAssetImage(Assets.imagesAssetsRecord2)),
                ),
              ),
            ),
            body: GestureDetector(
              //表示透明也响应处理
              behavior: HitTestBehavior.translucent,
              onTap: () {
                //收起键盘
                _addressFocus.unfocus();
                _numFocus.unfocus();
              },
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 15.h, left: 14.w, bottom: 10.h),
                      child: Text(S.current.base_currency,
                          style: TextStyle(
                              fontSize: 14.sp, color: Colours.text_color_2)),
                    ),
                    InkWell(
                        onTap: () {
                          if ((_model.currencyList ?? []).isEmpty) {
                            return;
                          }
                          //选择币种
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return AssetCurrencyDialog(
                                    currencyList: _model.currencyList,
                                    onSelected: (currency) {
                                      setState(() {
                                        _model.selectCurrency = currency;
                                        _model.chainList = currency.chains;
                                        if ((_model.chainList ?? [])
                                            .isNotEmpty) {
                                          _model.selectChain =
                                              _model.chainList?[0];
                                        }
                                      });
                                    });
                              });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 14.w),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          alignment: Alignment.centerLeft,
                          height: 45.h,
                          decoration: const BoxDecoration(
                            color: Colours.def_view_bg_1_color,
                            borderRadius: BorderRadius.all(
                              Radius.circular(2),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colours.def_view_bg_1_color,
                                radius: 9,
                                backgroundImage: ImageUtil.getImageProvider(
                                    _model.selectCurrency?.icon,
                                    holderImg: Assets.imagesAlertDefault),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                _model.selectCurrency?.currency ?? '',
                                style: TextStyle(
                                    color: Colours.text_color_2,
                                    fontSize: 14.sp,
                                    fontFamily: BFFontFamily.din,
                                    fontWeight: BFFontWeight.medium),
                              ),
                              SizedBox(width: 6.w),
                              Text(_model.selectCurrency?.fullName ?? '',
                                  style: TextStyle(
                                      color: Colours.text_color_4,
                                      fontSize: 14.sp,
                                      fontFamily: BFFontFamily.din,
                                      fontWeight: BFFontWeight.normal)),
                            ],
                          ),
                        )),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 20.h, left: 14.w, bottom: 10.h),
                      child: Text(S.current.asset_chain,
                          style: TextStyle(
                              fontSize: 14.sp, color: Colours.text_color_2)),
                    ),
                    InkWell(
                        onTap: () {
                          //选择链类型
                          if ((_model.chainList ?? []).isEmpty) {
                            return;
                          }
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return AssetChainDialog(
                                    chainList: _model.chainList,
                                    onSelected: (chain) {
                                      setState(() {
                                        _model.selectChain = chain;
                                      });
                                    });
                              });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 14.w),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          alignment: Alignment.centerLeft,
                          height: 45.h,
                          decoration: const BoxDecoration(
                            color: Colours.def_view_bg_1_color,
                            borderRadius: BorderRadius.all(
                              Radius.circular(2),
                            ),
                          ),
                          child: Text(
                            _model.selectChain?.name ?? '',
                            style: TextStyle(
                                color: Colours.text_color_2,
                                fontSize: 14.sp,
                                fontFamily: BFFontFamily.din,
                                fontWeight: BFFontWeight.medium),
                          ),
                        )),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 20.h, left: 14.w, bottom: 10.h),
                      child: Text(S.current.asset_withdraw_address,
                          style: TextStyle(
                              fontSize: 14.sp, color: Colours.text_color_2)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14.w),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 12.w),
                      height: 45.h,
                      constraints: BoxConstraints(minHeight: 45.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colours.def_line_1_color, width: 1.w),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _addressController,
                              focusNode: _addressFocus,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                hintText: S.current.asset_withdraw_address_hint,
                                hintStyle: TextStyle(
                                    color: Colours.text_color_5,
                                    fontSize: 14.sp,
                                    textBaseline: TextBaseline.alphabetic),
                                border: transparentInputBorder,
                                enabledBorder: transparentInputBorder,
                                disabledBorder: transparentInputBorder,
                                focusedBorder: transparentInputBorder,
                              ),
                              cursorColor: Colours.app_main,
                              style: TextStyle(
                                  color: Colours.text_color_2,
                                  fontSize: 14.sp,
                                  textBaseline: TextBaseline.alphabetic,
                                  height: 1.4),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              ClipboardData? data =
                                  await Clipboard.getData(Clipboard.kTextPlain);
                              if ((data?.text ?? '').isNotEmpty) {
                                _addressController.text = data!.text!;
                              }
                            },
                            child: Container(
                              height: 45.h,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              alignment: Alignment.center,
                              child: Image(
                                  width: 18.w,
                                  height: 18.h,
                                  image: ImageUtil.getAssetImage(
                                      Assets.imagesBaseCopy)),
                            ),
                          ),
                          VDivider(
                              color: Colours.def_line_2_color,
                              height: 22.h,
                              width: 1),
                          InkWell(
                              onTap: () {
                                //扫描二维码
                                Routers.navigateTo(
                                        context, Routers.assetsQrcodeScanner)
                                    .then((result) {
                                  if (result != null &&
                                      result.toString().isNotEmpty) {
                                    _addressController.text = result.toString();
                                  }
                                });
                              },
                              child: Container(
                                height: 45.h,
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                alignment: Alignment.center,
                                child: Image(
                                  width: 18.w,
                                  height: 18.h,
                                  image: ImageUtil.getAssetImage(
                                      Assets.imagesAssetQrcode),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 20.h, left: 14.w, bottom: 10.h),
                      child: Text(S.current.asset_withdraw_amount,
                          style: TextStyle(
                              fontSize: 14.sp, color: Colours.text_color_2)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14.w),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 12.w),
                      constraints: BoxConstraints(minHeight: 45.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colours.def_line_1_color, width: 1.w),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _numController,
                              focusNode: _numFocus,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9.]"))
                              ],
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                hintText:
                                    '${S.current.asset_withdraw_amount_hint}${_model.selectChain?.withdrawMin}',
                                hintStyle: TextStyle(
                                    color: Colours.text_color_5,
                                    fontSize: 14.sp,
                                    textBaseline: TextBaseline.alphabetic),
                                border: transparentInputBorder,
                                enabledBorder: transparentInputBorder,
                                disabledBorder: transparentInputBorder,
                                focusedBorder: transparentInputBorder,
                              ),
                              cursorColor: Colours.app_main,
                              // cursorHeight: ScreenHelper.height(18),
                              style: TextStyle(
                                  color: Colours.text_color_2,
                                  fontSize: 14.sp,
                                  textBaseline: TextBaseline.alphabetic,
                                  height: 1.4),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(_model.selectCurrency?.currency ?? '',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colours.text_color_3)),
                          ),
                          VDivider(
                              color: Colours.def_line_2_color,
                              height: 22.h,
                              width: 1),
                          InkWell(
                              onTap: () {
                                _numController.text =
                                    _model.selectCurrency?.balance ?? '0';
                              },
                              child: Container(
                                height: 45.h,
                                padding: EdgeInsets.symmetric(horizontal: 11.w),
                                alignment: Alignment.center,
                                child: Text(S.current.action_all,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colours.app_main)),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 14.w, top: 6.h, right: 14.w),
                        child: Text(
                            '${S.current.asset_withdraw_balance} ${_model.selectCurrency?.balance ?? '0'} ${_model.selectCurrency?.currency}',
                            style: TextStyle(
                                fontSize: 12.sp, color: Colours.text_color_4))),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(S.current.asset_record_detail_fee,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colours.text_color_4)),
                          Text(
                              '${_model.selectChain?.withdrawFee ?? '0'} ${_model.selectCurrency?.currency}',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colours.text_color_2,
                                  fontWeight: BFFontWeight.medium,
                                  fontFamily: BFFontFamily.din))
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(S.current.asset_withdraw_arrival,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colours.text_color_4)),
                          Text(
                              '$receiverNum ${_model.selectCurrency?.currency}',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colours.text_color_2,
                                  fontWeight: BFFontWeight.medium,
                                  fontFamily: BFFontFamily.din))
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Gaps.spaceView,
                    Padding(
                      padding:
                          EdgeInsets.only(top: 15.h, left: 14.w, bottom: 10.h),
                      child: Text(S.current.asset_withdraw_tip,
                          style: TextStyle(
                              fontSize: 14.sp, color: Colours.text_color_2)),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Builder(builder: (context) {
                          return HTML.toRichText(
                            context,
                            _model.selectChain?.withdrawDesc ?? '',
                            defaultTextStyle: TextStyle(
                                color: Colours.text_color_4,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                height: 2.0),
                          );
                        })),
                    SizedBox(height: 35.h),
                    InkWell(
                        onTap: applyWithdraw,
                        child: Container(
                            height: 45.h,
                            margin: EdgeInsets.only(
                                left: 14.w, right: 14.w, bottom: 40.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _model.infoData?.enable == 0
                                  ? Colours.def_view_bg_1_color
                                  : btnEnable
                                      ? Colours.def_green
                                      : Colours.def_btn_disable,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            child: Text(
                              _model.infoData?.enable == 0
                                  ? S.current.asset_withdraw_forbid
                                  : S.current.action_withdraw,
                              style: TextStyle(
                                  color: Colours.white, fontSize: 16.sp),
                            )))
                  ],
                ),
              ),
            ),
          );
        });
  }

  void initViewModel() {
    showProgress();
    _model.getWithdrawCurrencyChains();

    _model.addListener(() {
      if (_model.isSuccess) {
        closeProgress();
        if ((_model.infoData?.isMobile == 1 &&
                _model.infoData?.isEmail != 1 &&
                _model.infoData?.isGa != 1) ||
            (_model.infoData?.isMobile != 1 &&
                _model.infoData?.isEmail == 1 &&
                _model.infoData?.isGa != 1) ||
            (_model.infoData?.isMobile != 1 &&
                _model.infoData?.isEmail != 1 &&
                _model.infoData?.isGa != 1)) {
          showBindDialog();
          return;
        }
        if (_model.infoData?.enable == 0) {
          ToastUtil.show(_model.infoData?.enableMsg);
        }
      } else if (_model.isBusy) {
        showProgress();
      } else {
        closeProgress();
      }
    });
  }

  void refreshButton() {
    setState(() {
      btnEnable =
          _addressController.text.isNotEmpty && _numController.text.isNotEmpty;
    });
  }

  ///提现
  void applyWithdraw() {
    if (!btnEnable) {
      return;
    }
    if (_model.infoData?.enable == 0) {
      return;
    }
    if (_model.selectChain?.withdrawEnable != 1) {
      return;
    }
    if ((_model.infoData?.isMobile == 1 &&
            _model.infoData?.isEmail != 1 &&
            _model.infoData?.isGa != 1) ||
        (_model.infoData?.isMobile != 1 &&
            _model.infoData?.isEmail == 1 &&
            _model.infoData?.isGa != 1) ||
        (_model.infoData?.isMobile != 1 &&
            _model.infoData?.isEmail != 1 &&
            _model.infoData?.isGa != 1)) {
      showBindDialog();
      return;
    }
    double curNum = double.parse(_numController.text);
    if (curNum > double.parse(_model.selectCurrency?.balance ?? '0')) {
      ToastUtil.show(S.current.asset_withdraw_toast_balance);
      return;
    }
    if (curNum < double.parse(_model.selectChain?.withdrawMin ?? '0')) {
      ToastUtil.show(
          '${S.current.asset_withdraw_amount_hint}${_model.selectChain?.withdrawMin}');
      return;
    }
    List<Map<String, dynamic>> list = [
      {
        "title": S.of(context).asset_withdraw_address,
        "content": _addressController.text
      },
      {
        "title": S.of(context).asset_chain,
        "content": _model.selectChain?.name ?? ''
      },
      {
        "title": S.of(context).asset_withdraw_amount,
        "content": '${_numController.text} ${_model.selectCurrency?.currency}',
      },
      {
        "title": S.of(context).asset_record_detail_fee,
        "content":
            '${_model.selectChain?.withdrawFee ?? '0'} ${_model.selectCurrency?.currency}',
      }
    ];
    applyWithdrawShow(context,amount: receiverNum,unit: _model.selectCurrency?.currency ?? "",list: list);
  }
  applyWithdrawConfirm(){
    Parameters parameters = Parameters();
    parameters.putString("currency", _model.selectCurrency?.currency ?? '');
    parameters.putString("chain", _model.selectChain?.network ?? '');
    parameters.putString("amount", _numController.text);
    parameters.putString("address", _addressController.text);
    parameters.putString("memo", _model.selectChain?.memo ?? '');
    parameters.putObj(
        "verificationCodeActions", VerificationCodeActions.withdraw);
    parameters.putObj("verificationCodeTypes", VerificationCodeTypes.withdraw);
    Routers.navigateTo(context, Routers.mineBindPhoneEmailVerificationPage,
        parameters: parameters);

    // Map<String, dynamic> params = {};
    //
    // params["currency"] = _model.selectCurrency?.currency ?? '';
    // params["chain"] =  _model.selectChain?.network ?? '';
    // params["amount"] = _numController.text;
    // params["address"] = _addressController.text;
    // params["memo"] = _model.selectChain?.memo ?? '';
    //
    // BitFrogApi.instance.requestCommon(Apis.bindStatus, params: params,showLoading: true,
    //     onSuccess: (dynamic data) {
    //       BindStatusEntity bindStatusEntity = BindStatusEntity.fromJson(data);
    //       Parameters parameters = Parameters();
    //       parameters.putMap("params", params);
    //       parameters.putObj("bindStatusModel", bindStatusEntity.data);
    //       parameters.putObj("multiVerificationCodeActionType", MultiVerificationCodeActionType.withdraw);
    //       Routers.navigateTo(context, Routers.multiVerificationCodePage,
    //           parameters: parameters);
    //     });
  }

  void showBindDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return CommonDialog(
          content: S.current.asset_withdraw_security_toast,
          action2: S.current.asset_withdraw_security_bind,
          onCancel: () {
            Routers.goBack(context);
          },
          onAction: () {
            Routers.goBack(context);
            Routers.navigateTo(context, Routers.mineAccountSafetyPage);
          },
        );
      },
    );
  }
  applyWithdrawShow(BuildContext context,
      {String amount = "",String unit = "", List<Map<String, dynamic>>? list}) {
    if (list == null) {
      return;
    }

    List<Widget> items = [];
    for (int i = 0; i < list.length; i++) {
      Map<String, dynamic> map = list[i];
      String title = map["title"];
      String content = map["content"];
      Widget item = Container(
        padding: EdgeInsets.only(top: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colours.text_color_4,
                fontSize: 13.sp,
              ),
            ),
            Text(
              content,
              style: TextStyle(
                  color: Colours.text_color_2,
                  fontSize: 13.sp,
                  fontWeight: BFFontWeight.medium),
            )
          ],
        ),
      );
      items.add(item);
    }

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(left: 14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).assets_withdrawal_confirm,
                      style: TextStyle(
                          color: Colours.text_color_2,
                          fontSize: 15.sp,
                          fontWeight: BFFontWeight.medium),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            right: 14.w, top: 10.h, bottom: 10.h, left: 10.w),
                        child: Image.asset(
                          Assets.imagesBaseClose,
                          width: 20.w,
                          height: 20.w,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const LineViewItem(
                heightAll: 1,
              ),
              Gaps.vGap30,
              Container(
                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).assets_withdraw_you_receive,
                      style: TextStyle(
                          color: Colours.text_color_4, fontSize: 14.sp),
                    ),
                    Gaps.vGap20,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(amount,
                          style: TextStyle(
                            color: Colours.text_color_2,
                            fontSize: 30.sp,
                          height: 0.2,
                          fontWeight: BFFontWeight.medium,
                          fontFamily: BFFontFamily.din
                        ),
                        ),
                        Gaps.hGap5,
                        Text(unit,style: TextStyle(
                            color: Colours.text_color_3,
                            fontSize: 14.sp
                        ),),
                      ],
                    ),
                    Column(
                      children: items,
                    ),
                    Gaps.vGap15,
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: const BoxDecoration(
                          color: Colours.def_view_bg_3_color,
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                      child: Text(
                       S.of(context).assets_withdraw_tip,
                        style: TextStyle(
                            color: Colours.text_color_4, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.vGap20,
              const LineViewItem(heightAll: 1),
              Gaps.vGap12,
              BottomButton(
                text: S.current.action_ok,
                padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 25.h),
                onPressed: () {
                  Navigator.pop(context);
                  applyWithdrawConfirm();
                },
              ),
            ],
          );
        },
        isDismissible: true,
        enableDrag: false);
  }
}

import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/dialog/asset_account_dialog.dart';
import 'package:bitfrog/ui/page/assets/dialog/asset_add_account_dialog.dart';
import 'package:bitfrog/ui/page/assets/model/currency_choose_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/asset_transfer_model.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:bitfrog/widget/dividers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetTransferPage extends StatefulWidget {
  const AssetTransferPage({Key? key}) : super(key: key);

  @override
  State<AssetTransferPage> createState() => _AssetTransferPageState();
}

class _AssetTransferPageState extends State<AssetTransferPage>
    with BasePageMixin<AssetTransferPage>, TickerProviderStateMixin {
  late AssetTransferModel _model;
  final TextEditingController _numController = TextEditingController();
  final FocusNode _numFocus = FocusNode();
  late AnimationController fromController;
  late AnimationController toController;
  bool isChange = false;

  @override
  void initState() {
    super.initState();
    _model = AssetTransferModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
    fromController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    toController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _numController.addListener(() {
      if (_numController.text.isNotEmpty) {
        double curNum = double.parse(_numController.text);
        if (curNum > double.parse(_model.balanceMax)) {
          ToastUtil.show(S.current.asset_withdraw_toast_balance);
          return;
        }else{
         _model.balance =  _numController.text;
        }
      }
      setState(() {});
    });
  }



  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    _numFocus.dispose();
    _numController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const transparentInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    );

    return ProviderWidget<AssetTransferModel>(
        model: _model,
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colours.white,
            appBar: MyAppBar(
              title: S.current.action_transfer,
              bottomLine: true,
              action: InkWell(
                onTap: () {
                  Routers.navigateTo(context, Routers.assetsTransferRecord);
                },
                child: Container(
                  height: 44.h,
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
                _numFocus.unfocus();
              },
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15.h, left: 14.w, bottom: 10.h),
                            child: Text(S.current.asset_transfer_account,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colours.text_color_4)),
                          ),
                          InkWell(
                              onTap: () {
                                //选择划转账户
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return _model.accountList.isEmpty
                                          ? const AssetAddAccountDialog()
                                          : AssetAccountDialog(
                                              accountList: _model.accountList,
                                              onSelected: (account) {
                                                setState(() {
                                                  _model.selectAccount =
                                                      account;
                                                  String type ='spot';
                                                  if(isChange){

                                                    type ='swap';
                                                  }else{
                                                    type ='spot';
                                                  }
                                                  _model.currency = '';
                                                  _model.getCurrenys(_model.selectAccount?.id ?? '',type);
                                                });
                                              });
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 14.w),
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                alignment: Alignment.centerLeft,
                                height: 45.h,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colours.def_line_1_color,
                                        width: 1.w),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(4),
                                    )),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      _model.selectAccount?.name ?? '',
                                      style: TextStyle(
                                          color: Colours.text_color_2,
                                          fontSize: 14.sp,
                                          fontWeight: BFFontWeight.medium),
                                    ),
                                    SizedBox(width: 6.w),
                                    Container(
                                      height: 16.h,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 6.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(1),
                                          color: Colours.def_yellow_15),
                                      alignment: Alignment.center,
                                      child: Text(
                                        _model.selectAccount?.type ?? '',
                                        style: TextStyle(
                                            color: Colours.def_yellow,
                                            fontSize: 10.sp),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Image(
                                        width: 15.w,
                                        height: 15.h,
                                        image: ImageUtil.getAssetImage(
                                            Assets.imagesBaseArrowRight))
                                  ],
                                ),
                              )),
                          SizedBox(height: 15.h),
                          Gaps.spaceView,
                          Padding(
                            padding: EdgeInsets.only(top: 15.h, left: 14.w),
                            child: Text(S.current.asset_transfer_direction,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colours.text_color_4)),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 42.w,
                                margin: EdgeInsets.symmetric(vertical: 20.h),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(S.current.asset_transfer_from,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colours.text_color_4)),
                                    Image(
                                        width: 1.5.w,
                                        height: 33.h,
                                        image: ImageUtil.getAssetImage(
                                            Assets.imagesAssetTransferLine)),
                                    SizedBox(height: 3.5.h),
                                    Text(S.current.asset_transfer_to,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colours.text_color_4)),
                                  ],
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                  child: Column(children: [
                                SlideTransition(
                                  position: Tween(
                                          begin: const Offset(0, 0),
                                          end: const Offset(0, 1))
                                      .chain(CurveTween(curve: Curves.linear))
                                      .animate(fromController),
                                  child: Container(
                                    height: 60.h,
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('资金账户',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colours.text_color_2,
                                                fontWeight:
                                                    BFFontWeight.medium)),
                                        Image(
                                            width: 15.w,
                                            height: 15.h,
                                            image: ImageUtil.getAssetImage(
                                                Assets.imagesBaseArrowRight)),
                                      ],
                                    ),
                                  ),
                                ),
                                Gaps.hLines,
                                SlideTransition(
                                  position: Tween(
                                          begin: const Offset(0, 0),
                                          end: const Offset(0, -1))
                                      .chain(CurveTween(curve: Curves.linear))
                                      .animate(toController),
                                  child: Container(
                                    height: 60.h,
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('U本位合约账户',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colours.text_color_2,
                                                fontWeight:
                                                    BFFontWeight.medium)),
                                        Image(
                                            width: 15.w,
                                            height: 15.h,
                                            image: ImageUtil.getAssetImage(
                                                Assets.imagesBaseArrowRight)),
                                      ],
                                    ),
                                  ),
                                ),
                              ])),
                              SizedBox(width: 20.w),
                              InkWell(
                                onTap: () {
                                  if (!isChange) {
                                    fromController.forward();
                                    toController.forward();
                                  } else {
                                    fromController.reverse();
                                    toController.reverse();
                                  }
                                  isChange = !isChange;
                                  String type ='spot';
                                  if(isChange){
                                    type ='swap';
                                    _model.to_type = 'spot';
                                    _model.from_type = 'swap';
                                  }else{
                                    type ='spot';
                                    _model.to_type = 'swap';
                                    _model.from_type = 'spot';
                                  }
                                  _model.getCurrenys(_model.selectAccount?.id ?? '', type);
                                  _numController.text = '';
                                },
                                child: Image(
                                    width: 36.w,
                                    height: 36.h,
                                    image: ImageUtil.getAssetImage(
                                        Assets.imagesAssetTransferChange)),
                              ),
                              SizedBox(width: 20.w),
                            ],
                          ),
                          Gaps.spaceView,
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15.h, left: 14.w, bottom: 10.h),
                            child: Text(S.current.asset_currency,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colours.text_color_4)),
                          ),
                          InkWell(
                              onTap: () {
                                // 选择币种
                                Parameters para = Parameters();
                                if(isChange){
                                  para.putString('type', 'swap');
                                }else{
                                  para.putString('type', 'spot');
                                }

                                para.putString('apiId',  _model.selectAccount?.id ?? '');
                                Routers.navigateToResult(
                                    context, Routers.currencyChoiceSymbol,
                                    (result) {
                                      SymbolCurrency modelSymbol = result as SymbolCurrency;
                                  setState(() {
                                    _model.currency =
                                        modelSymbol.currency ?? '';
                                    _model.balanceMax = modelSymbol.withdrawAvailable?.amount ?? '0';
                                    _numController.text = '';
                                  });
                                },parameters:para );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 14.w),
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                alignment: Alignment.centerLeft,
                                height: 45.h,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colours.def_line_1_color,
                                        width: 1.w),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(4),
                                    )),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _model.currency,
                                      style: TextStyle(
                                          color: Colours.text_color_2,
                                          fontSize: 14.sp,
                                          fontWeight: BFFontWeight.medium),
                                    ),
                                    Image(
                                        width: 15.w,
                                        height: 15.h,
                                        image: ImageUtil.getAssetImage(
                                            Assets.imagesBaseArrowDown))
                                  ],
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.h, left: 14.w, bottom: 10.h),
                            child: Text(S.current.asset_transfer_count,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colours.text_color_4)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 14.w),
                            padding: EdgeInsets.only(left: 12.w),
                            constraints: BoxConstraints(minHeight: 45.h),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colours.def_line_1_color, width: 1.w),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4),
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
                                          const EdgeInsets.symmetric(
                                              vertical: 0),
                                      hintText: '最多可划转${_model.balanceMax}${_model.currency}',
                                      hintStyle: TextStyle(
                                          color: Colours.text_color_5,
                                          fontSize: 14.sp,
                                          textBaseline:
                                              TextBaseline.alphabetic),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Text(_model.currency,
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
                                      _numController.text = _model.balanceMax;
                                    },
                                    child: Container(
                                      height: 45.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11.w),
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
                            padding: EdgeInsets.only(
                                left: 14.w, top: 6.h, right: 14.w),
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: S.current.asset_transfer_max,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colours.text_color_4)),
                              TextSpan(
                                  text: '${_model.balanceMax} ${_model.currency}',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colours.text_color_2))
                            ])),
                          ),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colours.white,
                    child: InkWell(
                        onTap: transferClick,
                        child: Container(
                            height: 45.h,
                            margin: EdgeInsets.only(
                                left: 14.w,
                                top: 15.h,
                                right: 14.w,
                                bottom: 35.h),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colours.def_green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            child: Text(
                              S.current.action_transfer,
                              style: TextStyle(
                                  color: Colours.white,
                                  fontSize: 16.sp,
                                  fontWeight: BFFontWeight.medium),
                            ))),
                  )
                ],
              ),
            ),
          );
        });
  }

  void initViewModel() {
    // showProgress();
    _model.getTransferAccount();

    // _model.addListener(() {
    //   if (_model.isSuccess || _model.isEmpty || _model.isError) {
    //     closeProgress();
    //   }
    // });
  }

  ///划转
  void transferClick() {
    if(isChange){
      _model.from_type =  'swap';
      // para.putString('type', 'swap');
      _model.balance =_numController.text;
    }else{
      _model.from_type =  'spot';
      _model.balance =_numController.text;
    }
   _model.transferPlay(onSuccess: () {
     ToastUtil.show(S.current.access_transaction_account14);
     // Event.eventBus.fire(AccessSuccessEvent());
     // 返回根路由，实盘管理页面
     Navigator.pop(context);
     // Navigator.of(context).popUntil(ModalRoute.withName('/'));
   });
  }
}

import 'package:bitfrog/event/event.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/ui/page/assets/item/%20Access_trader_item.dart';
import 'package:bitfrog/ui/page/assets/model/access_trader_account_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/access_trader_account_model.dart';
import 'package:bitfrog/ui/page/firmOffer/model/access_api_entity.dart';
import 'package:bitfrog/ui/view/buttons.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/keyboard_util.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:bitfrog/base/base_page.dart';

typedef mycallBack = Function(int count);

class AccessTraderAccountPage extends StatefulWidget {
  const AccessTraderAccountPage({Key? key}) : super(key: key);

  @override
  State<AccessTraderAccountPage> createState() =>
      _AccessTraderAccountPageState();
}

class _AccessTraderAccountPageState extends State<AccessTraderAccountPage>
    with BasePageMixin<AccessTraderAccountPage>, WidgetsBindingObserver {
  final RefreshController _refreshController = RefreshController();
  late AccessTraderAccountModel _managerModel;
  int selectedIndex = 0;

  final TextEditingController userPhraseController = TextEditingController();
  final TextEditingController apiKeyController = TextEditingController();
  final TextEditingController secretKeyController = TextEditingController();
  final TextEditingController passPhraseController = TextEditingController();

  final TextEditingController userUidPhraseController = TextEditingController();
  final TextEditingController userContentPhraseController =
      TextEditingController();
  final FocusNode userPhraseNode = FocusNode();
  final FocusNode passPhraseNode = FocusNode();
  final FocusNode apiKeyNode = FocusNode();
  final FocusNode secretKeyNode = FocusNode();
  final FocusNode userUidPhraseNode = FocusNode();
  final FocusNode userContentPhraseNode = FocusNode();
  late bool showPassPhrase = true;
  late bool showIp = true;
  late bool showBit = false;
  late int contractString = 1;
  bool hideSet = true;

  // GlobalKey<_TextWidgetState> textKey = GlobalKey();

  bool _enableButton = false;

  // 底部按钮是否启用
  void _checkEnableButton() {
    setState(() {
      bool enable = apiKeyController.text.isNotEmpty &&
          secretKeyController.text.isNotEmpty &&
          userPhraseController.text.isNotEmpty &&
          userUidPhraseController.text.isNotEmpty &&
          userContentPhraseController.text.isNotEmpty;
      if (showPassPhrase) {
        enable = enable && passPhraseController.text.isNotEmpty;
      }
      _enableButton = enable;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); //添加观察者
    _managerModel = AccessTraderAccountModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // if (mounted) {
      initViewModel();
      // }
    });

    passPhraseController.addListener(() {
      _checkEnableButton();
    });
    apiKeyController.addListener(() {
      _checkEnableButton();
    });
    secretKeyController.addListener(() {
      _checkEnableButton();
    });
    userUidPhraseController.addListener(() {
      _checkEnableButton();
    });
    userContentPhraseController.addListener(() {
      _checkEnableButton();
    });
    userPhraseController.addListener(() {
      _checkEnableButton();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AccessTraderAccountModel>(
      model: _managerModel,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: MyAppBar(
              title: S.current.access_transaction_account,
              onBack: () {
                Routers.goBack(context);
              },
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: scrollView(context)),
                  bottomView(context)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget inPutViewApi() {
    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(visible: showPassPhrase, child: SizedBox(height: 15.h)),
          Visibility(
              visible: showPassPhrase,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.access_transaction_account3,
                    style:
                        TextStyle(fontSize: 14.sp, color: Colours.text_color_2),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextField(
                    focusNode: userPhraseNode,
                    controller: userPhraseController,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colours.text_color_2,
                        textBaseline: TextBaseline.alphabetic,
                        height: 1.4),
                    decoration: InputDecoration(
                      isDense: true,
                      //添加这个以后才可以修改内间距
                      contentPadding: EdgeInsets.only(
                          left: 12.w, top: 12.5.h, right: 12.w, bottom: 12.5.h),
                      hintText: S.current.access_transaction_account6,
                      hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.text_color_5,
                          textBaseline: TextBaseline.alphabetic),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          borderSide: BorderSide(
                              color: Colours.def_line_2_color, width: 1)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          borderSide: BorderSide(
                              color: Colours.def_line_2_color, width: 1)),
                    ),
                    maxLines: 1,
                    cursorColor: Colours.app_main,
                  )
                ],
              )),
          SizedBox(height: 15.h),
          Text(
            S.current.access_transaction_account4,
            style: TextStyle(fontSize: 14.sp, color: Colours.text_color_2),
          ),
          SizedBox(height: 15.h),
          TextField(
            focusNode: apiKeyNode,
            controller: apiKeyController,
            style: TextStyle(
                fontSize: 14.sp,
                color: Colours.text_color_2,
                textBaseline: TextBaseline.alphabetic,
                height: 1.4),
            decoration: InputDecoration(
              isDense: true,
              //添加这个以后才可以修改内间距
              contentPadding: EdgeInsets.only(
                  left: 12.w, top: 12.5.h, right: 12.w, bottom: 12.5.h),
              hintText: S.current.drying_access_join_key_hint,
              hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colours.text_color_5,
                  textBaseline: TextBaseline.alphabetic),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  borderSide:
                      BorderSide(color: Colours.def_line_2_color, width: 1)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  borderSide:
                      BorderSide(color: Colours.def_line_2_color, width: 1)),
            ),
            maxLines: 1,
            cursorColor: Colours.app_main,
          ),
          SizedBox(height: 15.h),
          TextField(
            focusNode: secretKeyNode,
            controller: secretKeyController,
            style: TextStyle(
                fontSize: 14.sp,
                color: Colours.text_color_2,
                textBaseline: TextBaseline.alphabetic,
                height: 1.4),
            decoration: InputDecoration(
              isDense: true,
              //添加这个以后才可以修改内间距
              contentPadding: EdgeInsets.only(
                  left: 12.w, top: 12.5.h, right: 12.w, bottom: 12.5.h),
              hintText: S.current.drying_access_join_secret_hint,
              hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colours.text_color_5,
                  textBaseline: TextBaseline.alphabetic),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  borderSide:
                      BorderSide(color: Colours.def_line_2_color, width: 1)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  borderSide:
                      BorderSide(color: Colours.def_line_2_color, width: 1)),
            ),
            maxLines: 1,
            cursorColor: Colours.app_main,
          ),
          SizedBox(height: 15.h),
          TextField(
            focusNode: passPhraseNode,
            controller: passPhraseController,
            style: TextStyle(
                fontSize: 14.sp,
                color: Colours.text_color_2,
                textBaseline: TextBaseline.alphabetic,
                height: 1.4),
            decoration: InputDecoration(
              isDense: true,
              //添加这个以后才可以修改内间距
              contentPadding: EdgeInsets.only(
                  left: 12.w, top: 12.5.h, right: 12.w, bottom: 12.5.h),
              hintText: S.current.drying_access_join_pass_hint,
              hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colours.text_color_5,
                  textBaseline: TextBaseline.alphabetic),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  borderSide:
                      BorderSide(color: Colours.def_line_2_color, width: 1)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  borderSide:
                      BorderSide(color: Colours.def_line_2_color, width: 1)),
            ),
            maxLines: 1,
            cursorColor: Colours.app_main,
          ),
          Visibility(visible: showIp, child: SizedBox(height: 15.h)),
          Visibility(
              visible: showIp,
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: const BoxDecoration(
                  color: Colours.def_view_bg_1_color,
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        // "drying_access_join_text_3":"注：若未提供上述权限，将可能导致实盘数据出错",
                        //   "drying_access_join_text_4":"请妥善保管好API密钥等信息，不要向任何人透漏该信息",
                        child: Text.rich(TextSpan(children: [
                      TextSpan(
                          text: S.current.access_transaction_account5,
                          style: TextStyle(
                              fontSize: 12.sp, color: Colours.text_color_2)),
                      TextSpan(
                          text:
                              _managerModel.traderAccount?.ip_white_list ?? '',
                          style: TextStyle(
                              fontSize: 12.sp, color: Colours.def_yellow)),
                    ]))),
                    Visibility(
                        visible: true,
                        child: InkWell(
                            onTap: () {
                              // if ((_managerModel.curApi?.ips ?? '').isEmpty) {
                              //   return;
                              // }
                              Clipboard.setData(ClipboardData(
                                  text: _managerModel
                                          .traderAccount?.ip_white_list ??
                                      ''));
                              ToastUtil.show(S.current.copy_success);
                            },
                            child: Container(
                                height: 20.h,
                                margin: EdgeInsets.only(left: 15.w),
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                alignment: Alignment.center,
                                // decoration: const BoxDecoration(
                                //   color: Colours.black_30,
                                //   borderRadius: BorderRadius.all(
                                //     Radius.circular(1),
                                //   ),
                                // ),
                                child: Image(
                                  image: ImageUtil.getAssetImage(
                                      Assets.imagesBasePaste),
                                  width: 24,
                                  height: 24,
                                )))),
                  ],
                ),
              )),
          SizedBox(height: 15.h),
          Text(
            S.current.access_transaction_account9,
            style: TextStyle(fontSize: 14.sp, color: Colours.text_color_2),
          ),
          SizedBox(height: 15.h),
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 14.w),
            // padding: EdgeInsets.only(left: 12.w),
            constraints: BoxConstraints(minHeight: 45.h),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: Colours.def_line_1_color, width: 1.w),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: userUidPhraseController,
                    focusNode: userUidPhraseNode,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      //添加这个以后才可以修改内间距
                      contentPadding: EdgeInsets.only(
                          left: 12.w, top: 12.5.h, right: 12.w, bottom: 12.5.h),

                      hintText: '${_managerModel.curExchange?.title}UID',
                      hintStyle: TextStyle(
                          color: Colours.text_color_5,
                          fontSize: 14.sp,
                          textBaseline: TextBaseline.alphabetic),
                    ),

                    // cursorColor: Colours.app_main,
                    // cursorHeight: ScreenHelper.height(18),
                    style: TextStyle(
                        color: Colours.text_color_2,
                        fontSize: 14.sp,
                        textBaseline: TextBaseline.alphabetic,
                        height: 1.4),
                  ),
                ),
                InkWell(
                    onTap: () {
                      List<String> photoUrls  =[];
                      for(int i=0;i<1;i++){
                        photoUrls.add( _managerModel.curExchange?.exchange_uid_course_img ?? '');
                      }

                      Parameters parameters = Parameters();
                      parameters.putList("photoUrls", photoUrls);
                      parameters.putInt("index", 0);
                      Routers.navigateTo(context, Routers.photoPreview,parameters: parameters);
                    },
                    child: Container(
                      height: 45.h,
                      padding: EdgeInsets.symmetric(horizontal: 11.w),
                      alignment: Alignment.center,
                      child: Image.asset(
                        Assets.imagesAccountImageuid,
                        width: ScreenHelper.width(18),
                        height: ScreenHelper.width(18),
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(height: 15.h),
          TextField(
            focusNode: userContentPhraseNode,
            controller: userContentPhraseController,
            style: TextStyle(
                fontSize: 14.sp,
                color: Colours.text_color_2,
                textBaseline: TextBaseline.alphabetic,
                height: 1.4),
            decoration: InputDecoration(
              isDense: true,
              //添加这个以后才可以修改内间距
              contentPadding: EdgeInsets.only(
                  left: 12.w, top: 12.5.h, right: 12.w, bottom: 12.5.h),
              hintText: S.current.access_transaction_account10,
              hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colours.text_color_5,
                  textBaseline: TextBaseline.alphabetic),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  borderSide:
                      BorderSide(color: Colours.def_line_2_color, width: 1)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  borderSide:
                      BorderSide(color: Colours.def_line_2_color, width: 1)),
            ),
            maxLines: 1,
            cursorColor: Colours.app_main,
          ),
        ],
      ),
    );
  }

  Widget scrollView(BuildContext context) {
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              alignment: Alignment.centerLeft,
              child: Text(
                S.current.drying_exchange,
                style: TextStyle(
                    color: Colours.text_color_2,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: AccessTraderWidget(
                listEntity: _managerModel.traderAccount?.exchangeList ?? [],
                hideRebate: false,
                myCallBack: (type) {
                  // _managerModel.subscribetype = typeAll;
                  _managerModel.curExchange =
                  _managerModel.traderAccount?.exchangeList![type];

                  setState(() {});
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              alignment: Alignment.centerLeft,
              child: Text(
                S.current.firm_access_text11,
                style: TextStyle(
                    color: Colours.text_color_2,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal),
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 14.w, right: 14, bottom: 10.h),
              child: AccessTraderWidget(
                list: _managerModel.traderAccount?.accountTypeList ?? [],
                hideRebate: true,
                myCallBack: (type) {
                  _managerModel.traderAccount = _managerModel.traderAccount
                      ?.accountTypeList![type] as AccessTraderAccountEntity?;
                  // _managerModel.subscribetype = typeAll;
                  setState(() {});
                },
              ),
            ),
            inPutViewApi(),
            // Gaps.hLine_interval,
            Gaps.vGap20,

            Gaps.hLine,
            Gaps.vGap20,
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 14.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.current.access_transaction_account7,
                    style: TextStyle(
                        color: Colours.text_color_2,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          Parameters parameters = Parameters();

                          parameters.putString("url",
                              _managerModel.traderAccount?.course_url ?? '');
                          parameters.putInt("token", 1);

                          parameters.putString(
                              "title", S.current.trading_view_text);

                          Routers.navigateTo(
                              context, Routers.mineWebViewCommonPage,
                              parameters: parameters);
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 14.w),
                          alignment: Alignment.centerRight,
                          child: Text(
                            S.current.access_transaction_account8,
                            style: TextStyle(
                              color: Colours.app_main,
                              fontSize: 14.sp,
                              // fontWeight: BFFontWeight.medium,
                            ),
                          ),
                        )))
              ],
            ),

            Gaps.vGap20,

            Container(
              padding: EdgeInsets.only(right: 14.w, left: 14.w),
              alignment: Alignment.centerLeft,
              child: Text(
                _managerModel.curExchange?.desc ?? '',
                style: TextStyle(
                  color: Colours.text_color_4,
                  fontSize: 12.sp,
                  // fontWeight: BFFontWeight.medium,
                ),
              ),
            )
          ],
        )
        // Container(
        //   color: Colours.white,
        //   alignment: Alignment.centerLeft,
        //   child:,
        // )
    );
  }

  void initViewModel() {
    _managerModel.refresh();

    _managerModel.addListener(() {
      _refreshController.refreshCompleted();
      if (_managerModel.isBusy) {
        showProgress();
      } else {
        closeProgress();
      }
    });
  }

  Widget bottomView(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colours.white,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: BottomButton(
        text: S.current.drying_tab_5,
        enable: _enableButton,
        onPressed: () => showAlert(),
      ),
    );
  }

  void showAlert() {
    if (!_enableButton) {
      return;
    }
    // "drying_access_join_text_19":"key不可为空",
    // "drying_access_join_text_20":"secret不可为空",
    // "drying_access_join_text_21":"pass不可为空",
    if (apiKeyController.text.isEmpty) {
      ToastUtil.show(S.current.access_transaction_account11);
      return;
    }
    KeyboardUtil.closeKeyboard(context);
    if (apiKeyController.text.isEmpty) {
      ToastUtil.show(S.current.drying_access_join_text_19);
      return;
    }
    if (secretKeyController.text.isEmpty) {
      ToastUtil.show(S.current.drying_access_join_text_20);
      return;
    }
    if (secretKeyController.text.isEmpty) {
      ToastUtil.show(S.current.drying_access_join_text_21);
      return;
    }

    if (userUidPhraseController.text.isEmpty) {
      ToastUtil.show(S.current.access_transaction_account12);
      return;
    }
    if (userContentPhraseController.text.isEmpty) {
      ToastUtil.show(S.current.access_transaction_account13);
      return;
    }

    _managerModel.accountAlias = userPhraseController.text;
    _managerModel.apikey = apiKeyController.text;
    _managerModel.apiSecret = secretKeyController.text;
    _managerModel.apiPass = passPhraseController.text;

    _managerModel.exchangeUid = userUidPhraseController.text;
    _managerModel.contact = userContentPhraseController.text;

    _managerModel.accountType = _managerModel.curAccountType?.accountType ?? '';

    _managerModel.setLiveApiData(onSuccess: () {
      ToastUtil.show(S.of(context).score_addition_state_1);
      // Event.eventBus.fire(AccessSuccessEvent());
      // 返回根路由，实盘管理页面
      Navigator.pop(context);
      // Navigator.of(context).popUntil(ModalRoute.withName('/'));
    });
    // AlertView.showAlertAccess(
    //   context,
    //   title: S.current.drying_access_confirm_confirm_title,
    //   cancel: S.current.drying_access_confirm_confirm_cancel,
    //   confirm: S.current.drying_access_confirm_confirm_sure,
    //   cancelClick: () {},
    //   confirmClick: () {
    //     _managerModel.apiPass = passPhraseController.text;
    //     _managerModel.apikey = apiKeyController.text;
    //     _managerModel.apiSecret = secretKeyController.text;
    //     _managerModel.hide_live = hideSet == true ? '1' : '2';
    //
    //     _managerModel.exchange = _managerModel.curExchange?.exchange ?? '';
    //
    //     _managerModel.setLiveApiData(onSuccess: () {
    //       ToastUtil.show(S.of(context).score_addition_state_1);
    //       Event.eventBus.fire(AccessSuccessEvent());
    //       // 返回根路由，实盘管理页面
    //       Navigator.of(context).popUntil(ModalRoute.withName('/'));
    //     });
    //   },
    //   istow: showIp ? true : false,
    // );
  }
}

class TextWidget extends StatefulWidget {
  // List<ApiType> apitypes = <ApiType>[];
  mycallBack myCallBack;
  AccessApiEntity item;
  int chooseIndex = 0;

  // _managerModel.curApi.api_types
  TextWidget({
    super.key,
    // required this.apitypes,
    required this.myCallBack,
    required this.item,
    required this.chooseIndex,
  });

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  String name = S.current.drying_access_join_range_1;
  String image = Assets.imagesBaseCheckedCircleYes;

  String name1 = S.current.drying_access_join_range_2;
  String image1 = Assets.imagesBaseCheckedCircleNo;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          InkWell(
              onTap: () {
                onPressed(1);
              },
              child: Container(
                  height: 20.h,
                  // margin: EdgeInsets.only(top: 40.h),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Image.asset(
                        widget.chooseIndex > 1
                            ? Assets.imagesBaseCheckedCircleNo
                            : Assets.imagesBaseCheckedCircleYes,
                        width: ScreenHelper.width(18),
                        height: ScreenHelper.width(18),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        name,
                        style: TextStyle(
                            color: Colours.text_color_2, fontSize: 13.sp),
                      )
                    ],
                  ))),
          SizedBox(width: 20.w),
          Visibility(
            visible: (widget.item.api_types?.length ?? 1) > 1 ? true : false,
            child: InkWell(
                onTap: () {
                  onPressed(2);
                },
                child: Container(
                    height: 20.h,
                    // margin: EdgeInsets.only(top: 40.h),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Image.asset(
                          widget.chooseIndex > 1
                              ? Assets.imagesBaseCheckedCircleYes
                              : Assets.imagesBaseCheckedCircleNo,
                          width: ScreenHelper.width(18),
                          height: ScreenHelper.width(18),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          name1,
                          style: TextStyle(
                              color: Colours.text_color_2, fontSize: 13.sp),
                        )
                      ],
                    ))),
          )
        ],
      ),
    );
  }

  void onPressed(int count) {
    setState(() {
      widget.chooseIndex = count;

      widget.myCallBack(count);
    });
  }
}

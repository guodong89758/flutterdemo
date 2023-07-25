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
import 'package:bitfrog/ui/page/assets/viewmodel/asset_deposit_model.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:simple_html_css/simple_html_css.dart';

class AssetDepositPage extends StatefulWidget {
  const AssetDepositPage({Key? key}) : super(key: key);

  @override
  State<AssetDepositPage> createState() => _AssetDepositPageState();
}

class _AssetDepositPageState extends State<AssetDepositPage>
    with BasePageMixin<AssetDepositPage> {
  late AssetDepositModel _model;

  @override
  void initState() {
    super.initState();
    _model = AssetDepositModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AssetDepositModel>(
        model: _model,
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colours.white,
            appBar: MyAppBar(
              title: S.current.action_deposit,
              bottomLine: true,
              action: InkWell(
                onTap: () {
                  Parameters parameters = Parameters()
                    ..putInt("type", 1)
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
            body: SingleChildScrollView(
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
                                      _model.selectChain = null;
                                      _model.infoData = null;
                                    });
                                    showProgress();
                                    _model.getDepositCurrencyChains(
                                        currency.currency ?? '');
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
                                      _model.infoData = null;
                                    });
                                    showProgress();
                                    _model.getDepositAddress(
                                        _model.selectCurrency?.currency ?? '',
                                        chain.network ?? '');
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
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 35.h),
                    child: QrImageView(
                      data: _model.infoData?.address ?? '',
                      version: QrVersions.auto,
                      padding: const EdgeInsets.all(0),
                      size: 140.w,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 14.w),
                    padding: EdgeInsets.only(left: 10.w),
                    alignment: Alignment.centerLeft,
                    height: 40.h,
                    constraints: BoxConstraints(minHeight: 40.h,maxHeight: 40.h),
                    decoration: const BoxDecoration(
                      color: Colours.def_view_bg_1_color,
                      borderRadius: BorderRadius.all(
                        Radius.circular(2),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Text(
                              _model.infoData?.address ?? '',
                              softWrap: true,
                              style: TextStyle(
                                  color: Colours.text_color_2,
                                  fontSize: 14.sp,
                                  fontFamily: BFFontFamily.din,
                                  fontWeight: BFFontWeight.medium),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if ((_model.infoData?.address ?? '').isEmpty) {
                              return;
                            }
                            Clipboard.setData(ClipboardData(
                                text: _model.infoData?.address ?? ''));
                            ToastUtil.show(S.current.copy_success);
                          },
                          child: Container(
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            alignment: Alignment.center,
                            child: Image(
                                width: 18.w,
                                height: 18.h,
                                image: ImageUtil.getAssetImage(
                                    Assets.imagesBaseCopy)),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Gaps.spaceView,
                  Padding(
                    padding:
                        EdgeInsets.only(top: 15.h, left: 14.w, bottom: 6.h),
                    child: Text(S.current.asset_deposit_notice,
                        style: TextStyle(
                            fontSize: 14.sp, color: Colours.text_color_2)),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Builder(builder: (context) {
                        return HTML.toRichText(
                          context,
                          _model.selectChain?.depositDesc ?? '',
                          defaultTextStyle: TextStyle(
                              color: Colours.text_color_4,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                              height: 2.0),
                        );
                      })),
                  SizedBox(height: 50.h)
                ],
              ),
            ),
          );
        });
  }

  void initViewModel() {
    showProgress();
    _model.getDepositCurrencyList();

    _model.addListener(() {
      if (_model.isFirst || _model.isBusy) {
        showProgress();
      } else {
        closeProgress();
      }
    });
  }
}

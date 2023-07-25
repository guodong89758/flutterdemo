import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/ui/page/assets/model/asset_record_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/asset_record_detail_model.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/string_util.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetRecordDetailPage extends StatefulWidget {
  const AssetRecordDetailPage(
      {Key? key, required this.type, required this.record})
      : super(key: key);
  final int type;
  final RecordEntity? record;

  @override
  State<AssetRecordDetailPage> createState() => _AssetRecordDetailPageState();
}

class _AssetRecordDetailPageState extends State<AssetRecordDetailPage>
    with BasePageMixin<AssetRecordDetailPage> {
  late AssetRecordDetailModel _model;

  @override
  void initState() {
    super.initState();
    _model = AssetRecordDetailModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        initViewModel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AssetRecordDetailModel>(
        model: _model,
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colours.white,
            appBar: MyAppBar(
              title: widget.type == 1
                  ? S.current.asset_record_detail_deposit
                  : S.current.asset_record_detail_withdraw,
              bottomLine: true,
            ),
            body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: widget.type == 2 &&
                            (widget.record?.state ?? 0) == 3,
                        child: Container(
                          color: Colours.def_warn_bg_color,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.h, vertical: 7.h),
                          child: Text(S.current.asset_record_detail_refuse,
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colours.def_yellow)),
                        ),
                      ),
                      Container(
                        height: 122.5.h,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                '${widget.type == 1 ? '+' : ''}${StringUtil.formatPrice(widget.record?.amount ?? '')}',
                                style: TextStyle(
                                    fontSize: 33.sp,
                                    color: Colours.text_color_2,
                                    fontWeight: BFFontWeight.medium,
                                    fontFamily: BFFontFamily.din)),
                            SizedBox(width: 6.w),
                            Padding(
                              padding: EdgeInsets.only(bottom: 6.h),
                              child: Text(widget.record?.currency ?? '',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colours.text_color_4,
                                      fontWeight: BFFontWeight.normal)),
                            )
                          ],
                        ),
                      ),
                      Gaps.spaceView,
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 14.w),
                          SizedBox(
                              width: 76.w,
                              child: Text(S.current.asset_record_detail_chain,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colours.text_color_4,
                                      fontWeight: BFFontWeight.normal))),
                          Expanded(
                              child: Text(widget.record?.chain ?? '',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colours.text_color_2,
                                      height: 1,
                                      fontWeight: BFFontWeight.normal)))
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 14.w),
                          SizedBox(
                              width: 76.w,
                              child: Text(S.current.asset_record_detail_state,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colours.text_color_4,
                                      fontWeight: BFFontWeight.normal))),
                          Expanded(
                              child: Text(widget.record?.stateDesc ?? '',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: getStateColor(),
                                      height: 1,
                                      fontWeight: BFFontWeight.normal))),
                        ],
                      ),
                      Visibility(
                          visible: widget.type == 2,
                          child: SizedBox(height: 20.h)),
                      Visibility(
                        visible: widget.type == 2,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 14.w),
                            SizedBox(
                                width: 76.w,
                                child: Text(S.current.asset_record_detail_fee,
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colours.text_color_4,
                                        fontWeight: BFFontWeight.normal))),
                            Expanded(
                                child: Text(
                                    '${widget.record?.fee ?? ''} ${widget.record?.currency ?? ''}',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colours.text_color_2,
                                        height: 1,
                                        fontWeight: BFFontWeight.normal))),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 14.w),
                          SizedBox(
                              width: 76.w,
                              child: Text(
                                  widget.type == 1
                                      ? S.current
                                          .asset_record_detail_deposit_address
                                      : S.current
                                          .asset_record_detail_withdraw_address,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colours.text_color_4,
                                      fontWeight: BFFontWeight.normal))),
                          Expanded(
                              child: Text(widget.record?.address ?? '',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colours.text_color_2,
                                      height: 1.2,
                                      fontWeight: BFFontWeight.normal))),
                          InkWell(
                            onTap: () {
                              if ((widget.record?.address ?? '').isEmpty) {
                                return;
                              }
                              Clipboard.setData(ClipboardData(
                                  text: widget.record?.address ?? ''));
                              ToastUtil.show(S.current.copy_success);
                            },
                            child: Container(
                              height: 24.h,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              alignment: Alignment.center,
                              child: Image(
                                  width: 14.w,
                                  height: 14.h,
                                  image: ImageUtil.getAssetImage(
                                      Assets.imagesBaseCopy)),
                            ),
                          )
                        ],
                      ),
                      Visibility(
                          visible: (widget.record?.txid ?? '').isNotEmpty,
                          child: SizedBox(height: 20.h)),
                      Visibility(
                        visible: (widget.record?.txid ?? '').isNotEmpty,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 14.w),
                            SizedBox(
                                width: 76.w,
                                child: Text(S.current.asset_record_detail_txid,
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colours.text_color_4,
                                        fontWeight: BFFontWeight.normal))),
                            Expanded(
                                child: Text(widget.record?.txid ?? '',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colours.text_color_2,
                                        height: 1,
                                        fontWeight: BFFontWeight.normal))),
                            InkWell(
                              onTap: () {
                                if ((widget.record?.txid ?? '').isEmpty) {
                                  return;
                                }
                                Clipboard.setData(ClipboardData(
                                    text: widget.record?.txid ?? ''));
                                ToastUtil.show(S.current.copy_success);
                              },
                              child: Container(
                                height: 24.h,
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                alignment: Alignment.center,
                                child: Image(
                                    width: 14.w,
                                    height: 14.h,
                                    image: ImageUtil.getAssetImage(
                                        Assets.imagesBaseCopy)),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 14.w),
                          SizedBox(
                              width: 76.w,
                              child: Text(S.current.asset_record_detail_time,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colours.text_color_4,
                                      fontWeight: BFFontWeight.normal))),
                          Expanded(
                              child: Text(widget.record?.created ?? '',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colours.text_color_2,
                                      height: 1,
                                      fontWeight: BFFontWeight.normal))),
                        ],
                      ),
                      SizedBox(height: 60.h),
                      Visibility(
                          visible: widget.type == 2 &&
                              (widget.record?.state ?? 0) == 1,
                          child: InkWell(
                              onTap: () {
                                showProgress();
                                _model.cancelWithdraw(widget.record?.id ?? '');
                              },
                              child: Container(
                                  height: 45.h,
                                  margin: EdgeInsets.only(
                                      left: 14.w, right: 14.w, bottom: 40.h),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Colours.def_green,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(2),
                                    ),
                                  ),
                                  child: Text(
                                    S.current.action_revoke,
                                    style: TextStyle(
                                        color: Colours.white, fontSize: 16.sp),
                                  ))))
                    ])),
          );
        });
  }

  void initViewModel() {
    _model.addListener(() {
      if (_model.isBusy) {
        showProgress();
      } else {
        closeProgress();
      }
    });
  }

  Color getStateColor() {
    if (widget.type == 1) {
      //充值 (1待确认 2 成功 3异常)
      switch (widget.record?.state) {
        case 1:
          return Colours.def_yellow;
        case 2:
          return Colours.text_color_2;
        case 3:
          return Colours.def_red;
      }
    } else if (widget.type == 2) {
      //提币 (1 待审核 2 审核通过 3 审核拒绝 4 支付中 5 支付失败 6 已完成 7 已撤销)
      switch (widget.record?.state) {
        case 1:
        case 4:
          return Colours.def_yellow;
        case 2:
          return Colours.def_green;
        case 3:
        case 5:
          return Colours.def_red;
      }
    }
    return Colours.text_color_2;
  }
}

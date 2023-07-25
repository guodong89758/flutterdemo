import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/item/transfer_record_item.dart';
import 'package:bitfrog/ui/page/assets/model/transfer_record_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/transfer_record_model.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/ui/view/refresh_view.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/widget/dialog/action_list_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///划转记录
class TransferRecordPage extends StatefulWidget {
  const TransferRecordPage({Key? key}) : super(key: key);

  @override
  State<TransferRecordPage> createState() => _TransferRecordPageState();
}

class _TransferRecordPageState extends State<TransferRecordPage>
    with
        BasePageMixin<TransferRecordPage>,
        AutomaticKeepAliveClientMixin<TransferRecordPage> {
  late TransferRecordModel _model;

  @override
  void initState() {
    super.initState();
    _model = TransferRecordModel();
    _model.addListener(() {
      if(_model.isSuccess || _model.isEmpty || _model.isError){
        closeProgress();
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TransferRecordModel>(
      model: _model,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colours.white,
          appBar: MyAppBar(
            title: S.current.asset_transfer_record,
            bottomLine: true,
          ),
          body: Column(
            children: [
              SizedBox(
                height: 35.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // Routers.navigateToResult(
                          //     context, Routers.currencyChoiceSymbol, (result) {
                          //   String tempCurrency = result as String;
                          //   setState(() {
                          //     _model.curCurrencyName =
                          //         tempCurrency == S.current.action_all
                          //             ? S.current.asset_currency
                          //             : tempCurrency;
                          //   });
                          //   _model.currency =
                          //       tempCurrency == S.current.action_all
                          //           ? ''
                          //           : tempCurrency;
                          //   _model.refresh();
                          // });
                          Routers.navigateToResult(context, Routers.tradeSymbol,
                              parameters: Parameters()
                                ..putString('type', 'transfer')
                                ..putString(
                                    'selection',
                                    _model.curCurrencyName), (result) {
                                BFSymbol itemSymbol = result as BFSymbol;
                                String tempCurrency = itemSymbol?.symbolTitle ?? S.current.action_all;
                                setState(() {
                                  _model.curCurrencyName =
                                  tempCurrency == S.current.asset_currency
                                      ? S.current.asset_currency
                                      : tempCurrency;
                                });
                                _model.currency =
                                tempCurrency == S.current.action_all
                                    ? ''
                                    : tempCurrency;
                                _model.refresh();
                              });





                        },
                        child: Container(
                          height: 35.h,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(_model.curCurrencyName,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colours.text_color_4)),
                              SizedBox(width: 4.w),
                              Image(
                                width: 12.w,
                                height: 12.h,
                                image: ImageUtil.getAssetImage(
                                    Assets.imagesAssetDown),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_model.timeArray.isEmpty) {
                            return;
                          }
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return ActionListDialog(
                                    actionList: _model.timeArray,
                                    selectAction:
                                        _model.curDayName == S.current.base_time
                                            ? _model.timeArray[0]
                                            : _model.curDayName,
                                    clickListener: (index, action) {
                                      setState(() {
                                        if (index == 0) {
                                          _model.days = '0';
                                        } else if (index == 1) {
                                          _model.days = '7';
                                        } else if (index == 2) {
                                          _model.days = '30';
                                        } else if (index == 3) {
                                          _model.days = '90';
                                        }
                                        if (index == 0) {
                                          _model.curDayName =
                                              S.current.base_time;
                                        } else {
                                          _model.curDayName =
                                              _model.timeArray[index];
                                        }
                                      });
                                      showProgress();
                                      _model.refresh();
                                    });
                              });
                        },
                        child: Container(
                          height: 35.h,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(_model.curDayName,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colours.text_color_4)),
                              SizedBox(width: 4.w),
                              Image(
                                width: 12.w,
                                height: 12.h,
                                image: ImageUtil.getAssetImage(
                                    Assets.imagesAssetDown),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Gaps.hLine,
              Expanded(
                  child: FBRefresherView(
                viewState: model.viewState,
                itemCount: model.dataList.length,
                onRefresh: model.refresh,
                onLoadMore: model.loadMore,
                controller: model.controller,
                onClickRefresh: model.clickRefresh,
                itemBuilder: (BuildContext context, int index) {
                  TransferRecord item = _model.dataList[index];
                  return TransferRecordItem(item: item);
                },
              )),
            ],
          ),
        );
      },
    );
  }
}

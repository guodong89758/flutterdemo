import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_choose_symbol_model.dart';
import 'package:bitfrog/ui/view/refresh_view.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:bitfrog/widget/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/ui/page/alert/item/alert_symbl_item.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef HandleClickAlertChooseSymbolPage = void Function(BFSymbol symbol);

/// 交易对选择页面
class AlertChooseSymbolPage extends StatefulWidget {
  const AlertChooseSymbolPage({Key? key, this.handleClickAlertChooseSymbolPage})
      : super(key: key);
  final HandleClickAlertChooseSymbolPage? handleClickAlertChooseSymbolPage;

  @override
  State<AlertChooseSymbolPage> createState() => _AlertChooseSymbolPageState();
}

class _AlertChooseSymbolPageState extends State<AlertChooseSymbolPage>
    with
        BasePageMixin<AlertChooseSymbolPage>,
        AutomaticKeepAliveClientMixin<AlertChooseSymbolPage>,
        SingleTickerProviderStateMixin {
  final AlertChooseSymbolModel viewModel = AlertChooseSymbolModel();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AlertChooseSymbolModel>(
      model: viewModel,
      builder: (context, model, child) {
        return SizedBox(
            height: ScreenHelper.screenHeight - 90.h,
            child: Column(
              children: [
                _headView(),
                Expanded(
                  child: FBRefresherView(
                    backgroundColor: Colours.white,
                    viewState: viewModel.viewState,
                    itemCount: model.dataList.length,
                    onRefresh: model.refresh,
                    onClickRefresh: model.clickRefresh,
                    enablePullUp: false,
                    enablePullDown: true,
                    controller: model.controller,
                    scrollController: model.scrollController,
                    header: Container(),
                    itemBuilder: (BuildContext context, int index) {
                      BFSymbol symbol = model.dataList[index];
                      return AlertSymbolItem(
                        type: 1,
                        handleClick: () {
                          Navigator.of(context).pop();
                          widget.handleClickAlertChooseSymbolPage?.call(symbol);
                        },
                        item: symbol,
                      );
                    },
                  ),
                ),
                Gaps.getVGap(ScreenHelper.bottomSafeHeight)
              ],
            ));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  Widget _headView() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Routers.goBack(context),
          child: SizedBox(
              width: 100.w,
              height: 35.h,
              child: Center(
                child: Image.asset(
                  Assets.imagesBaseArrowDownDark,
                  width: 15.w,
                  height: 15.w,
                ),
              )),
        ),
        _buildSearchBar(),
        Container(
          height: 36.h,
          padding: EdgeInsets.only(left: 14.w, right: 14.w),
          decoration: BoxDecorations.bottomLine(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.alert_currency,
                style: TextStyle(color: Colours.text_color_4, fontSize: 12.sp),
              ),
              Text(
                S.current.alert_exchange,
                style: TextStyle(color: Colours.text_color_4, fontSize: 12.sp),
              ),
            ],
          ),
        )
      ],
    );
  }

  /// 搜索框
  Widget _buildSearchBar() {
    return Container(
      color: Colours.white,
      width: ScreenHelper.screenWidth,
      height: 40.h,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SearchTextField(
              lengthLimit: 20,
              controller: _textEditingController,
              hintText: S.of(context).def_symbol,
              onSearch: (value) => viewModel.search(value),
            ),
          ),
          GestureDetector(
            onTap: () => Routers.goBack(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                S.current.action_cancel,
                style: TextStyle(color: Colours.text_color_2, fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

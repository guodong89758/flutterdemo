import 'package:bitfrog/ui/view/refresh_view.dart';
import 'package:bitfrog/utils/keyboard_util.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:bitfrog/widget/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/item/alert_symbl_item.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_symbol_model.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 交易对选择页面
class AlertSymbolPage extends StatefulWidget {
  final int type; //0 正常搜索页面 1 bottomsheet
  const AlertSymbolPage({Key? key, this.type = 0}) : super(key: key);

  @override
  State<AlertSymbolPage> createState() => _AlertSymbolPageState();
}

class _AlertSymbolPageState extends State<AlertSymbolPage> {
  final TextEditingController _controller = TextEditingController();

  final AlertSymbolModel _symbolModel = AlertSymbolModel();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //表示透明也响应处理
      behavior: HitTestBehavior.translucent,
      onTap: () => KeyboardUtil.closeKeyboard(context),
      child: SizedBox(
        height: ScreenHelper.screenHeight - 90.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.type == 1 ? _buildSearchBar() : _headView(),
            Expanded(
              child: ProviderWidget<AlertSymbolModel>(
                model: _symbolModel,
                builder: (context, model, child) {
                  return FBRefresherView(
                    controller: model.controller,
                    onRefresh: () => model.refresh(),
                    onLoadMore: model.loadMore,
                    viewState: model.viewState,
                    itemCount: model.dataList.length,
                    onClickRefresh: () => model.clickRefresh(),
                    itemBuilder: (context, index) {
                      BFSymbol symbol = model.dataList[index];
                      return AlertSymbolItem(type: widget.type, item: symbol);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _headView() {
    return Container(
        child: Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            // viewModel.back(context);
          },
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
    ));
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
              controller: _controller,
              hintText: S.of(context).def_symbol,
              onSearch: (value) {
                _symbolModel.searchSymbol(value);
              },
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
}

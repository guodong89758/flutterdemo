import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_choose_symbol_model.dart';
import 'package:bitfrog/ui/page/assets/item/currency_choice_item.dart';
import 'package:bitfrog/ui/page/assets/model/currency_choose_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/currency_model.dart';
import 'package:bitfrog/ui/view/refresh_view.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bitfrog/base/base_page.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/ui/page/alert/item/alert_symbl_item.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef HandleClickAlertChooseSymbolPage = void Function(BFSymbol symbol);
/// 交易对选择页面
class CurrencyChoiceSymbolPage extends StatefulWidget {
  final HandleClickAlertChooseSymbolPage? handleClickAlertChooseSymbolPage;
  final String apiId;
  final String type;
  const CurrencyChoiceSymbolPage({Key? key,this.handleClickAlertChooseSymbolPage,this.apiId = '',this.type =''}) : super(key: key);


  @override
  State<CurrencyChoiceSymbolPage> createState() => _CurrencyChoiceSymbolPageState();
}

class _CurrencyChoiceSymbolPageState extends State<CurrencyChoiceSymbolPage>
    with
        BasePageMixin<CurrencyChoiceSymbolPage>,
        AutomaticKeepAliveClientMixin<CurrencyChoiceSymbolPage>,
        SingleTickerProviderStateMixin {


  /// TODO MODEL 在1.4.0 中已修改，解决冲突
  late CurrencyListModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = CurrencyListModel(widget.apiId,widget.type);

  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CurrencyListModel>(
      model: viewModel,
      builder: (context, model, child) {
        return Scaffold(body: Container(
          color: Colors.white,
          child:Column(
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
                    SymbolCurrency symbol = model.dataList[index];
                    return CurrencyChoiceSymbolItem(
                        type: 1,
                        count: 1,
                        index: index,
                        handleClick: (){
                          // Navigator.of(context).pop();
                          Routers.goBackWithParams(context, symbol);
                          // widget.handleClickAlertChooseSymbolPage?.call(symbol);
                        },
                        item: symbol);
                  },
                ),
              ),
              // Gaps.getVGap(ScreenHelper.bottomSafeHeight)
            ],
          ) ,) ,)

          ;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    /// MODEL 在1.4.0 中已修改，解决冲突
    // viewModel.textEditingController.dispose();
    // viewModel.focusNode.dispose();
  }

  Widget _headView(){
    return Column(
      children: [

        SizedBox(height: 45.h,),
        _buildSearchBar(),
        Container(
          height: 36.h,
          padding: EdgeInsets.only(left: 14.w,right: 14.w),
          decoration:BoxDecorations.bottomLine(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('币种列表',style: TextStyle(color: Colours.text_color_4,fontSize: 12.sp),),
              // Text(S.current.alert_exchange,style: TextStyle(color: Colours.text_color_4,fontSize: 12.sp),),
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
      padding: EdgeInsets.only(left: 14.w),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 30.h,
              child: TextField(
                controller: viewModel.textEditingController,
                // focusNode: viewModel.focusNode,
                textInputAction: TextInputAction.search,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                  // FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                ],
                onSubmitted: (String val) {
                  viewModel.search();
                },
                onChanged: (text) {
                  // viewModel.search();
                },
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  prefixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 6.h, 6.w, 6.h),
                    child: Image(
                        width: 18.w,
                        height: 18.h,
                        image:
                        ImageUtil.getAssetImage(Assets.imagesBaseSearch)),
                  ),
                  prefixIconConstraints: const BoxConstraints(),
                  // suffixIcon: viewModel.textEditingController.text.isEmpty
                  suffixIcon: false
                      ? Gaps.empty
                      : GestureDetector(

                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 6.h),
                      child: Image(
                          width: 18.w,
                          height: 18.h,
                          image: ImageUtil.getAssetImage(
                              Assets.imagesBaseClear)),
                    ),
                    onTap: () {
                      viewModel.textEditingController.text  = '';
                      setState(() {
                        viewModel.dataList.clear();
                        viewModel.dataList.addAll(viewModel.oldLists);

                      });
                    },
                  ),
                  suffixIconConstraints: const BoxConstraints(),
                  hintText: S.current.def_symbol,
                  hintStyle: const TextStyle(
                      color: Colours.text_color_5,
                      fontSize: Dimens.font_sp14,
                      textBaseline: TextBaseline.alphabetic),
                  fillColor: Colours.def_view_bg_1_color,
                  filled: true,
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          color: Colours.def_view_bg_1_color, width: 1)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          color: Colours.def_view_bg_1_color, width: 1)),
                ),
                cursorColor: Colours.app_main,
                style: const TextStyle(
                    color: Colours.text_color_1,
                    fontSize: Dimens.font_sp14,
                    textBaseline: TextBaseline.alphabetic),
                minLines: 1,
              ),
            ),
          ),
          TextButton(
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colours.transparent),
                alignment: Alignment.center,
                minimumSize: MaterialStateProperty.all(Size(
                    ScreenHelper.width(60),
                    40.h)),
                padding: MaterialStateProperty.all(
                    EdgeInsets.only(left: 15.w, right: 14.w))),
            onPressed: () {
              // Routers.goBackWithParams(context, symbol);
              Routers.goBack(context);
            },
            child: Text(S.current.action_cancel,
                style: TextStyle(
                    color: Colours.text_color_2, fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;


}

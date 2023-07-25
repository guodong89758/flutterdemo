import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/dimens.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

typedef SearchChangeCallback = void Function(String string);

class AssetsApiAccountSpotSearchItem extends StatefulWidget {
  const AssetsApiAccountSpotSearchItem({
    Key? key,
    this.textEditingController,
    this.orderStr,
    this.voidCallback,
    this.voidCallbackCancel,
    this.focusNode,
    this.searchChangeCallback,
    this.lengthLimit,
    this.isShowRight = true,

  }) : super(key: key);
  final TextEditingController? textEditingController;

  final String? orderStr;
  final VoidCallback? voidCallback;
  final VoidCallback? voidCallbackCancel;
  final SearchChangeCallback? searchChangeCallback;
  final FocusNode? focusNode;
  final int? lengthLimit;
  final bool isShowRight ;

  @override
  State<AssetsApiAccountSpotSearchItem> createState() => _AssetsApiAccountSpotSearchItemState();
}

class _AssetsApiAccountSpotSearchItemState extends State<AssetsApiAccountSpotSearchItem> {
  bool showCancel = false;
  late PublishSubject<String> _textFieldSubject;

  @override
  void initState() {
    super.initState();

    /// 搜索防抖
    _textFieldSubject = PublishSubject<String>();
    _textFieldSubject
        .debounce((_) => TimerStream(true, const Duration(milliseconds: 800)))
        .listen((event) {
      //输入框内容变化回调

      if (widget.searchChangeCallback != null) {
        widget.searchChangeCallback!(event);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          _buildSearchBar(),
        ],
      ),
    );
  }

  /// 搜索框
  Widget _buildSearchBar() {
    return Container(
      color: Colours.white,
      width: ScreenHelper.screenWidth,
      height: 50.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(right: 14.w),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 14.w,top: 10.h,bottom: 10.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(Assets.imagesHideZeroN,width: 14.w,height: 14.w,),
                      Gaps.getHGap(3),
                      Text("隐藏0资产",style: TextStyle(
                          color: Colours.text_color_4,
                          fontSize: 12.sp
                      ),)
                    ],
                  ),
                )
              ],
            ),
          ),
          Gaps.getHGap(130.w),
          Expanded(
            child: SizedBox(
              height: ScreenHelper.height(30),
              child: TextField(
                controller: widget.textEditingController,
                focusNode: widget.focusNode,
                textInputAction: TextInputAction.search,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.lengthLimit ?? 20),
                  // FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                ],
                onSubmitted: (String val) {
                  _textFieldSubject.add(val);
                },
                onChanged: (text) {
                  //     //输入框内容变化回调
                  //     _symbolModel.searchSymbol(text);
                  setState(() {
                    // _controller.text = text;
                  });
                  _textFieldSubject.add(text);
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  prefixIconConstraints: BoxConstraints(minWidth: 34.w, minHeight: 0),
                  prefixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(4.w, 6.h, 0, 6.h),
                    child: Image(
                      image: ImageUtil.getAssetImage(
                        Assets.imagesFirmOfferSearch,
                      ),
                      width: 18.w,
                      height: 18.w,
                    ),
                  ),
                  suffixIcon: widget.textEditingController!.text.isEmpty
                      ? Gaps.empty
                      : GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(6.w, 6.h, 0, 6.h),
                            child: Image(
                                width: 14.w,
                                height: 14.w,
                                image: ImageUtil.getAssetImage(
                                    Assets.imagesBaseClear)),
                          ),
                          onTap: () {
                            setState(() {
                              widget.textEditingController?.clear();
                            });
                            widget.voidCallbackCancel?.call();
                          },
                        ),
                  hintText: "搜索",
                  hintStyle: const TextStyle(
                      color: Colours.text_color_5,
                      fontSize: Dimens.font_sp14,
                      textBaseline: TextBaseline.alphabetic),
                  filled: true,
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17.5)),
                      borderSide: BorderSide(
                          color: Colours.def_view_bg_1_color, width: 1)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17.5)),
                      borderSide: BorderSide(
                          color: Colours.def_view_bg_1_color, width: 1)),
                ),
                cursorColor: Colours.app_main,
                // cursorHeight: ScreenHelper.height(18),
                style: TextStyle(
                    color: Colours.text_color_1,
                    fontSize: 14.sp,
                    textBaseline: TextBaseline.alphabetic,
                    height: 1.4),
                minLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

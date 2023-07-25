import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/item/spot_account_item.dart';
import 'package:bitfrog/ui/page/assets/model/assets_info_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_voice_model.dart';
import 'package:bitfrog/ui/page/financial/model/voice_record_entity.dart';
import 'package:bitfrog/ui/page/financial/voicerecording/voice_record_item.dart';
import 'package:bitfrog/ui/page/mine/item/Line_view_item.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:bitfrog/widget/box_decorations.dart';
import 'package:bitfrog/widget/dialog/common_dialog.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/ui/view/refresh_head_view.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetsVoicePage extends StatefulWidget {

  const AssetsVoicePage({Key? key}) : super(key: key);

  @override
  State<AssetsVoicePage> createState() => _AssetsVoicePageState();
}

class _AssetsVoicePageState extends State<AssetsVoicePage>  with AutomaticKeepAliveClientMixin ,TickerProviderStateMixin {
  late AssetsVoiceModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = AssetsVoiceModel();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const MyAppBar(title: "语音",),
      body: ProviderWidget<AssetsVoiceModel>(
        model: viewModel,
        builder: (context, model, child) {
          return SafeArea(
            child: FBRefreshHeadView(
              viewState: model.viewState,
              itemCount: model.dataList.length,
              onRefresh: () {
                model.refresh();
              },
              enablePullUp: false,
              onLoadMore: model.loadMore,
              onClickRefresh: model.clickRefresh,
              controller: model.controller,
              scrollController: model.scrollController,
              placeholderHeight: ScreenHelper.screenHeight / 2.0,
              placeholderWidth: ScreenHelper.screenWidth,
              header: Container(),
              headView: _buildHeadView(),
              itemBuilder: (BuildContext context, int index) {
                Record? item = model.dataList[index];
                return VoiceRecordItem(
                    index: index,
                    count: 0,
                    item: item
                );
              },
            ),
          );
        },
      ),
    );
  }


  Widget _buildHeadView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "语音条数",
                    style: TextStyle(
                        color: Colours.text_color_4,
                        fontSize: 12.sp,
                        fontWeight: BFFontWeight.normal,
                        fontFamily: BFFontFamily.din),
                  ),
                  InkWell(
                    splashColor: Colours.white,
                    highlightColor: Colours.white,
                    onTap: () {
                      //语音记录
                      Routers.navigateTo(context, Routers.voiceRecord);
                    },
                    child: Container(
                      color: Colors.white,
                      padding:EdgeInsets.only(left: 10.w),
                      child: Image(
                        width: 20.w,
                        height: 20.h,
                        image: ImageUtil.getAssetImage(Assets.imagesCopyTradePosiitonBtn),
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.vGap10,
              Text("${viewModel.voiceCountEntity?.voice_amount ?? ""}",style: TextStyle(
                color: Colours.text_color_2,
                fontSize: 26.sp,
                fontWeight: BFFontWeight.bold,
                fontFamily: BFFontFamily.din
              ),),
              Gaps.vGap20,
              InkWell(
                  onTap: () {
                    //充值
                    if (viewModel.isBindMobile ?? false) {
                      Routers.navigateTo(context, Routers.voicePage);
                    } else {
                      showBindPhoneDialog();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 35.h,
                    decoration: const BoxDecoration(
                      color: Colours.app_main,
                      borderRadius: BorderRadius.all(
                        Radius.circular(2),
                      ),
                    ),
                    child: Text("充值语音",
                        style: TextStyle(
                            color: Colours.white,
                            fontSize: 14.sp,
                            fontWeight: BFFontWeight.medium)),
                  )),
            ],
          ),
        ),
        const LineViewItem(),
        Container(
          height: 50.h,
          padding: EdgeInsets.only(left: 14.w,right: 14.w),
          child: InkWell(
            child: Container(
              decoration: BoxDecorations.bottomLine(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("财务记录",style: TextStyle(
                    color: Colours.text_color_2,
                    fontWeight: BFFontWeight.medium,
                    fontSize: 15.sp
                  ),),
                  Image.asset(Assets.imagesBaseArrowRight,width: 15.w,height: 15.w,)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void showBindPhoneDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return CommonDialog(
          content: S.current.alert_bind_phone,
          action2: S.current.action_bind,
          onCancel: () {
            Routers.goBack(context);
          },
          onAction: () {
            Routers.goBack(context);
            Parameters parameter = Parameters();
            parameter.putBool('isEmail', false);

            parameter.putString('title',
                S.current.user_security_phone_subtitle);
            Routers.navigateTo(
                context, Routers.mineBindPhoneEmailPage,
                parameters: parameter);
          },
        );
      },
    );
  }

}









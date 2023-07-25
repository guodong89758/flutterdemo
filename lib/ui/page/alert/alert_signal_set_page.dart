
import 'package:bitfrog/base/provider_widget.dart';
import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/model/channel_entity.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/gaps.dart';
import 'package:bitfrog/ui/page/alert/model/alert_signal_config_entity.dart';
import 'package:bitfrog/ui/page/alert/viewmodel/alert_signal_set_model.dart';
import 'package:bitfrog/ui/view/base_view.dart';
import 'package:bitfrog/ui/view/buttons.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/ui/view/show_alert_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bitfrog/model/symbol_entity.dart';

class AlertSignalSetPage extends StatefulWidget {
  const AlertSignalSetPage({Key? key,this.symbol}) : super(key: key);
  final BFSymbol? symbol;
  @override
  State<AlertSignalSetPage> createState() => _AlertSignalSetPageState();
}

class _AlertSignalSetPageState extends State<AlertSignalSetPage> {

  late AlertSymbolSetModel viewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = AlertSymbolSetModel(widget.symbol);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MyAppBar(
        title: S.current.alert_indicator_warning,
      ),
      body: SafeArea(
        child: ProviderWidget<AlertSymbolSetModel>(
          model: viewModel,
          builder: (context, model, child) {
            return BaseView(
              viewState: viewModel.viewState,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 14.w,right: 14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gaps.vGap15,
                      Text(S.current.def_symbol,style: TextStyle(

                        color: Colours.text_color_4,
                        fontSize: 14.sp,
                        wordSpacing: 4.0, //1倍行高
                      ),
                          ),
                      Gaps.vGap10,
                      Container(

                        child: Row(children: [_symbol()],) ,
                      ),

                      Gaps.vGap24,
                      Text(S.current.alert_period,style: titleTextStyle,),
                      _period(),
                      Gaps.getVGap(14),
                      Row(children: [
                        Text(S.current.alert_single_1,style: titleTextStyle,),
                        GestureDetector(
                          onTap: (){
                           List<List> listArray = [];
                            for(int i=0; i< (viewModel.alertSignalConfigEntity?.indicators?.length ?? 0);i++){
                              Indicators? indicator  =viewModel.alertSignalConfigEntity?.indicators![i];
                              List<String> listValue = [];
                              listValue.add(indicator?.name ?? '');
                              listValue.add(indicator?.intro ?? '');
                              listArray.add(listValue);
                            }
                            AlertView.showExplainNew(context, S.current.alert_single_2,'',listArray);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 5.w,top: 10.h,bottom: 10.h),
                            child: Image.asset(Assets.imagesBaseExplain,width: 14.w,height: 14.w,),
                          ),
                        )
                      ],),
                      _target(),
                      Gaps.vGap24,
                      Text(S.current.alert_single_3,style: titleTextStyle,),
                      _trigger(),
                     _params(),
                      Gaps.vGap24,
                      Text(S.current.alert_type,style: titleTextStyle,),
                      _channels(),
                      Gaps.getVGap(40),

                      BottomButton(text: S.current.alert_single_4,onPressed: (){
                        viewModel.addAlert(context);
                      },padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 24.h),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _symbol(){
    return GestureDetector(
      onTap: (){
        viewModel.choseSymbol(context);
      },
      child: Container(
        // width: 180.w,
        decoration: BoxDecoration(
          border: Border.all(color: Colours.def_line_1_color,width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(2))
        ),
        padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 8.h,bottom: 8.h),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(viewModel.symbol?.symbolTitle ?? "",style: btnTextStyle,),
            Gaps.hGap10,
            Image.asset(Assets.imagesCopyTradeSortDown,width: 12.w,height: 12.w,)
          ],
        ),
      ),
    );
  }
  Widget _period(){
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: viewModel.period.length,
        padding:  EdgeInsets.fromLTRB(0, 10.h, 0, 0),
        gridDelegate:
         SliverGridDelegateWithFixedCrossAxisCount(
          //设置列数
          crossAxisCount: 4,
          //设置横向间距
          crossAxisSpacing: 20.w,
          //设置主轴间距
          mainAxisSpacing: 15,
          childAspectRatio: 133 / 60,
        ),
        itemBuilder: (context, position) {
          Terms terms = viewModel.period[position];
          return InkWell(
            onTap: () {
              viewModel.changePeriod(position);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: viewModel.periodIndex == position
                    ? Colours.app_main.withOpacity(0.1)
                    : Colours.white,
                borderRadius: BorderRadius.circular(1),
                border: Border.all(color: viewModel.periodIndex == position
                    ? Colours.app_main
                    : Colours.def_line_1_color)
              ),
              child: Text(
                terms.title ?? "",
                maxLines: 1,
                style: btnTextStyle.copyWith(color: viewModel.periodIndex == position
                    ? Colours.app_main
                    : null),
              ),
            ),
          );
        });
  }

  Widget _target(){
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: viewModel.target.length,
        padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          //设置列数
          crossAxisCount: 3,
          //设置横向间距
          crossAxisSpacing: 20.w,
          //设置主轴间距
          mainAxisSpacing: 15,
          childAspectRatio: 194 / 60,
        ),
        itemBuilder: (context, position) {
          Indicators indicators = viewModel.target[position];
          return InkWell(
            onTap: () {
              viewModel.changeTarget(position);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: viewModel.targetIndex == position
                      ? Colours.app_main.withOpacity(0.1)
                      : Colours.white,
                  borderRadius: BorderRadius.circular(1),
                  border: Border.all(color: viewModel.targetIndex == position
                      ? Colours.app_main
                      : Colours.def_line_1_color)
              ),
              child: Text(
                indicators.name ?? "",
                maxLines: 1,
                style: btnTextStyle.copyWith(color: viewModel.targetIndex == position
                    ? Colours.app_main
                    : null),
              ),
            ),
          );
        });
  }

  Widget _trigger(){
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: viewModel.trigger.length,
        padding:  EdgeInsets.fromLTRB(0, 10.h, 0, 0),
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          //设置列数
          crossAxisCount: 2,
          //设置横向间距
          crossAxisSpacing: 20.w,
          //设置主轴间距
          mainAxisSpacing: 15,
          childAspectRatio: 306 / 70,
        ),
        itemBuilder: (context, position) {
          Conditions conditions = viewModel.trigger[position];
          return InkWell(
            onTap: () {
              viewModel.changeTrigger(position);
            },
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: conditions.checked
                          ? Colours.app_main.withOpacity(0.1)
                          : Colours.white,
                      borderRadius: BorderRadius.circular(1),
                      border: Border.all(color: conditions.checked
                          ? Colours.app_main
                          : Colours.def_line_1_color)
                  ),
                  child: Text(
                    conditions.name ?? "",
                    maxLines: 1,
                    style: btnTextStyle.copyWith(color: conditions.checked
                        ? Colours.app_main
                        : null),
                  ),
                ),
                if(conditions.checked) Positioned(
                  right: 0,
                    bottom: 0,
                    child: Image.asset(Assets.imagesAlertChooseSymbolS,width: 15.w,height: 15.w,)
                )
              ],
            ),
          );
        });
  }

  Widget _params(){
    if(viewModel.params.isEmpty){
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap24,
        Text(S.current.alert_single_7,style: titleTextStyle,),
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: viewModel.params.length,
            padding:  EdgeInsets.fromLTRB(0, 10.h, 0, 0),
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              //设置列数
              crossAxisCount: 2,
              //设置横向间距
              crossAxisSpacing: 20.w,
              //设置主轴间距
              mainAxisSpacing: 15,
              childAspectRatio: 306 / 70,
            ),
            itemBuilder: (context, position) {
              Params params = viewModel.params[position];
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${params.name ?? ""}: ${params.value}",
                  maxLines: 1,
                  style: btnTextStyle,
                ),
              );
            }),
      ],
    );
  }

  Widget _channels(){
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: viewModel.channels.length,
        padding:  EdgeInsets.fromLTRB(0, 10.h, 0, 0),
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          //设置列数
          crossAxisCount: 2,
          //设置横向间距
          crossAxisSpacing: 20.w,
          //设置主轴间距
          mainAxisSpacing: 15,
          childAspectRatio: 306 / 70,
        ),
        itemBuilder: (context, position) {
          ChannelEntity channelEntity = viewModel.channels[position];
          return InkWell(
            onTap: () {
              viewModel.changeChannels(position);
            },
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: channelEntity.checked
                          ? Colours.app_main.withOpacity(0.1)
                          : Colours.white,
                      borderRadius: BorderRadius.circular(1),
                      border: Border.all(color: channelEntity.checked
                          ? Colours.app_main
                          : Colours.def_line_1_color)
                  ),
                  child: Text(
                    channelEntity.name ?? "",
                    maxLines: 1,
                    style: btnTextStyle.copyWith(color: channelEntity.checked
                        ? Colours.app_main
                        : null),
                  ),
                ),
                if(channelEntity.checked) Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset(Assets.imagesAlertChooseSymbolS,width: 15.w,height: 15.w,)
                )
              ],
            ),
          );
        });
  }

  TextStyle titleTextStyle = TextStyle(
    color: Colours.text_color_4,
    fontSize: 14.sp
  );
  TextStyle btnTextStyle = TextStyle(
      color: Colours.text_color_2,
      fontSize: 14.sp
  );
}

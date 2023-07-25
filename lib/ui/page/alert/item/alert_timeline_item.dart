import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/res/styles.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/alert_detail_page.dart';
import 'package:bitfrog/ui/page/alert/model/alert_event_entity.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_html_css/simple_html_css.dart';

class AlertTimelineItem extends StatefulWidget {
  final int? type; //1、订阅 2、详情 3、分享
  final int? index;
  final int? count;
  final AlertEvent? item;
  final bool isLast;
  final ValueChanged<AlertEvent>? onSubscribeClick;

  const AlertTimelineItem(
      {Key? key,
      required this.type,
      required this.index,
      required this.count,
      required this.item,
      required this.isLast,
      this.onSubscribeClick})
      : super(key: key);

  @override
  State<AlertTimelineItem> createState() => _AlertTimelineItemState();

}

class _AlertTimelineItemState extends State<AlertTimelineItem> {

  // late double width = widget.type==3 ?(ScreenHelper.screenWidth/2-70-40) : (ScreenHelper.screenWidth/2-70);

  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    final widthContext =  widget.type==3 ?size.width-70-40 : ((size.width-70-40)/2);
    return InkWell(
      onTap: () {
        if (widget.type == 3) {
          return;
        }
        if (Routers.goLogin(context)) return;
        Routers.navigateTo(context, Routers.alertDetailPage,
            parameters: Parameters()
              ..putString('id', (widget.item?.id ?? 0).toString())
              ..putObj('types', AlertShowTypes.eventDetail));
      },
      child: SizedBox(
        width: double.infinity,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 23.w),
              SizedBox(
                width: 10.w,
                height: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Opacity(
                      // 修改透明度实现隐藏，类似于invisible
                      opacity: widget.index == 0 ? 0.0 : 1.0,
                      child: SizedBox(
                        height: 15.5.h,
                        child: VerticalDivider(
                          width: 0.5.w,
                          thickness: 0.5.w,
                          color: Colours.def_line_2_color,
                        ),
                      ),
                    ),
                    Image(
                      width: 10.w,
                      height: 10.h,
                      image:
                          ImageUtil.getAssetImage(Assets.imagesBasePointYellow),
                    ),
                    Expanded(
                        child: Opacity(
                            // 修改透明度实现隐藏，类似于invisible
                            opacity: widget.isLast &&
                                    widget.index == widget.count! - 1
                                ? 0.0
                                : 1.0,
                            child: SizedBox(
                              height: double.infinity,
                              child: VerticalDivider(
                                width: 0.5.w,
                                thickness: 0.5.w,
                                color: Colours.def_line_2_color,
                              ),
                            )))
                  ],
                ),
              ),
              Container(
                width: 15.w,
                height: 0.5.h,
                margin: EdgeInsets.only(top: 20.5.h),
                color: Colours.def_line_2_color,
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  padding: EdgeInsets.only(right: 14.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10.h),
                      Container(
                        height: 21.h,
                        width: 71.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.5.h),
                            color: Colours.def_view_bg_1_color),
                        alignment: Alignment.center,
                        child: Text(
                          DateUtil.formatDateMs(
                              ((widget.item?.timestamp ?? 0) * 1000).toInt(),
                              format: 'HH:mm:ss'),
                          style: TextStyle(
                              color: Colours.text_color_4,
                              fontSize: 12.sp,
                              fontFamily: BFFontFamily.din,
                              fontWeight: BFFontWeight.medium),
                        ),
                      ),
                      Expanded(
                          child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            SizedBox(height: 15.h),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Visibility(
                                    visible:
                                        (widget.item?.title ?? '').isNotEmpty,
                                    child: Text(widget.item?.title ?? '',
                                        style: TextStyle(
                                            color: Colours.text_color_2,
                                            fontSize: 15.sp,
                                            fontWeight: BFFontWeight.medium)),
                                  ),
                                ),
                                Visibility(
                                  visible: widget.type == 1 &&
                                      widget.item?.isShowSubscribe == 1,
                                  child: InkWell(
                                    onTap: () {
                                      if (Routers.goLogin(context)) return;
                                      if (widget.item?.isSubscribedirectly ==
                                          0) {
                                        if (widget.item?.subscribeType ==
                                            'px_trigger') {
                                          Routers.navigateTo(
                                              context, Routers.alertPricePage);
                                        } else if (widget.item?.subscribeType ==
                                            'px_indicator_signal') {
                                          Routers.navigateTo(
                                              context, Routers.alertSignalPage);
                                        } else {
                                          Parameters parameters = Parameters();
                                          parameters.putString("type",
                                              widget.item?.subscribeType ?? '');
                                          Routers.navigateTo(context,
                                              Routers.alertConfigDetailPage,
                                              parameters: parameters);
                                        }
                                        return;
                                      }
                                      if (widget.onSubscribeClick == null) {
                                        return;
                                      }
                                      widget.onSubscribeClick!(
                                          widget.item ?? AlertEvent());
                                    },
                                    child: Container(
                                      height: 21.w,
                                      constraints:
                                          BoxConstraints(minWidth: 45.w),
                                      margin: EdgeInsets.only(left: 5.w),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 6.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.5.h),
                                          color: widget.item?.isSubscribe == 0
                                              ? Colours.def_green
                                              : Colours.def_green_10),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Visibility(
                                            visible:
                                                widget.item?.isSubscribe == 0,
                                            child: Image(
                                                image: ImageUtil.getAssetImage(
                                                    Assets.imagesSubscribeNo),
                                                width: 8.w,
                                                height: 8.h),
                                          ),
                                          Visibility(
                                              visible:
                                                  widget.item?.isSubscribe == 0,
                                              child: SizedBox(width: 3.w)),
                                          Text(
                                            widget.item?.isSubscribe == 0
                                                ? S.current.subscribe
                                                : S.current.subscribe_text_6,
                                            style: TextStyle(
                                                color:
                                                    widget.item?.isSubscribe ==
                                                            0
                                                        ? Colours.white
                                                        : Colours.def_green,
                                                fontSize: 11.sp,
                                                fontWeight:
                                                    BFFontWeight.medium),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            Expanded(

                                child: HTML.toRichText(

                              context,
                              widget.item?.content ?? '',
                              defaultTextStyle: TextStyle(
                                color: Colours.text_color_2,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                height:
                                    widget.item?.subscribeType == 'px_trigger'
                                        ? 2.0
                                        : 1.5,
                              ),
                            )),
                            SizedBox(height: 10.h),

                                Container( height:widget.type==3? (widget.item?.images?.length ?? 0) *(widthContext*(230/305)): ((widget.item?.images?.length ?? 0)%2==1 ? ((widget.item?.images?.length ?? 0)%2+(widget.item?.images?.length ?? 0)/2)*widthContext*(230/305)+10 :(((widget.item?.images?.length ?? 0)/2)*widthContext*(230/305)+10)) , child: GridView.builder(
                                  // shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: widget.item?.images?.length ?? 0,
                                    padding: const EdgeInsets.symmetric(horizontal: 0),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      //设置列数
                                      crossAxisCount:widget.type==3? 1 : 2,
                                      //设置横向间距
                                      crossAxisSpacing: 8.h,
                                      //设置主轴间距
                                      mainAxisSpacing: 8.w,
                                      childAspectRatio: 305/230,
                                    ),
                                    itemBuilder: (context, position) {

                                      return _buildCell(context,position);

                                    }),)

                          ]))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildCell(BuildContext context, int cellIndex) {

    return GestureDetector(
      onTap: () {
        List<String> photoUrls  =[];
        for(int i=0;i<(widget.item?.images?.length ?? 0);i++){
          photoUrls.add(widget.item?.images![i]);
        }
        // String photoUrlsStr = photoUrls.join('*-Bitfrog-*');
        // Routers.goFlutterContainerPage(Routers.photoPreview, {
        //   "index":'$cellIndex',
        //   "photoUrls":photoUrlsStr
        // }, context);
        Parameters parameters = Parameters();
        parameters.putList("photoUrls", photoUrls);
        parameters.putInt("index", cellIndex);
        Routers.navigateTo(context, Routers.photoPreview,parameters: parameters);

      },
      child: Container(
          child: CachedNetworkImage(
            imageUrl:   widget.item?.images![cellIndex] ?? "",
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Image.asset(Assets.imagesAlertDefault),
            fadeOutDuration:const Duration(milliseconds: 1),
            fadeInDuration:const Duration(milliseconds: 1),
          )
      ),
    );
  }
}

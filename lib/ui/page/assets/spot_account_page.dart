import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/ui/page/assets/item/spot_account_item.dart';
import 'package:bitfrog/ui/page/assets/model/assets_info_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_model.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:flutter/material.dart';

class SpotAccountPage extends StatefulWidget {
  const SpotAccountPage({Key? key, required this.model}) : super(key: key);
  final AssetsModel model;

  @override
  State<SpotAccountPage> createState() => _SpotAccountPageState();
}

class _SpotAccountPageState extends State<SpotAccountPage>
    with AutomaticKeepAliveClientMixin<SpotAccountPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget emptyWidget = BaseEmptyPage(onEmptyClick: () {
      widget.model.refresh();
    });
    return (widget.model.spotList ?? []).isEmpty
        ? emptyWidget
        : ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: (widget.model.spotList ?? []).length,
            itemBuilder: (BuildContext context, int index) {
              SpotEntity item =
                  widget.model.spotList?[index] ?? SpotEntity();
              bool assetsVisible = SpUtil.getBool(Config.keyAssetsVisible) ?? true;
              return CapitalAccountItem(item: item, assetsVisible:assetsVisible);
            });
  }
}

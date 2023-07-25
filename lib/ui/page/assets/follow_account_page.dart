import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/ui/page/assets/item/follow_account_item.dart';
import 'package:bitfrog/ui/page/assets/model/assets_info_entity.dart';
import 'package:bitfrog/ui/page/assets/viewmodel/assets_model.dart';
import 'package:bitfrog/utils/sp_util.dart';
import 'package:bitfrog/widget/refresh/base_empty_page.dart';
import 'package:flutter/material.dart';

class FollowAccountPage extends StatefulWidget {
  const FollowAccountPage({Key? key, required this.model}) : super(key: key);
  final AssetsModel model;

  @override
  State<FollowAccountPage> createState() => _FollowAccountPageState();
}

class _FollowAccountPageState extends State<FollowAccountPage>
    with AutomaticKeepAliveClientMixin<FollowAccountPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget emptyWidget = BaseEmptyPage(onEmptyClick: () {
      widget.model.refresh();
    });
    return (widget.model.contractList ?? []).isEmpty
        ? emptyWidget
        : ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: (widget.model.contractList ?? []).length,
            itemBuilder: (BuildContext context, int index) {
              ContractEntity item =
                  widget.model.contractList?[index] ??
                      ContractEntity();
              bool assetsVisible = SpUtil.getBool(Config.keyAssetsVisible) ?? true;
              return FollowAccountItem(item: item, assetsVisible: assetsVisible);
            });
  }
}

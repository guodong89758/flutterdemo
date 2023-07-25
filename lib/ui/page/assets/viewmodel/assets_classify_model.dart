import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/ui/page/assets/assets_api_account_page.dart';
import 'package:bitfrog/ui/page/assets/assets_capital_page.dart';
import 'package:bitfrog/ui/page/assets/assets_copy_trade_page.dart';
import 'package:bitfrog/ui/page/assets/assets_overview_page.dart';
import 'package:bitfrog/ui/page/assets/model/asserts_account_index_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';
import 'package:flutter/material.dart';

class AssetsClassifyModel extends ViewStateModel {
  final List tabs = [];
  List<Widget> tabBarViewList = [];

  late TabController tabController;
  String? _defaultTabName;

  TickerProvider vsync;
  AssertsAccountIndexEntity? assertsAccountIndexEntity;

  AssetsClassifyModel(this.vsync, {String? defaultTabName}) : super() {
    _defaultTabName = defaultTabName;
    tabController = TabController(length: tabs.length, vsync: vsync);
    getInfo();
  }

  _initTabBar() {
    tabs.clear();
    tabBarViewList.clear();

    tabs.addAll([
      S.current.assets_tab_general,
      S.current.assets_tab_fund,
      S.current.assets_tab_follow_trade,
    ]);
    tabBarViewList.addAll([
      AssetsOverViewPage(assertsAccountIndexEntity: assertsAccountIndexEntity,valueChangedIndex: (index){
        tabController.index = index;
      },),
      const AssetsCapitalPage(),
      const AssetsCopyTradePage()
    ]);

    assertsAccountIndexEntity?.list?.forEach((apiAccount) {
      tabs.add(apiAccount.name ?? "");
      tabBarViewList.add(AssetsApiAccountPage(apiAccountEntity: apiAccount));
    });

    final selectedIndex = tabs.indexOf(_defaultTabName);
    tabController = TabController(
        initialIndex: selectedIndex != -1 ? selectedIndex : 0,
        length: tabs.length,
        vsync: vsync);
    setSuccess();
  }

  getInfo() {
    AssetsApi.instance.getAccountIndex(onSuccess: (dynamic data) {
      assertsAccountIndexEntity = AssertsAccountIndexEntity.fromJson(data);
      _initTabBar();
    }, onError: (code, msg) {
      setError(code);
      return false;
    });
  }

  clickRefresh() {
    setBusy();
    getInfo();
  }
}

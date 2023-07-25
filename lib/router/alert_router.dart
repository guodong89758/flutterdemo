import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/router/i_router.dart';
import 'package:bitfrog/router/page_builder.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/alert/alert_add_price_page.dart';
import 'package:bitfrog/ui/page/alert/alert_config_page.dart';
import 'package:bitfrog/ui/page/alert/alert_detail_page.dart';
import 'package:bitfrog/ui/page/alert/alert_history_page.dart';
import 'package:bitfrog/ui/page/alert/alert_index_page.dart';
import 'package:bitfrog/ui/page/alert/alert_phone_page.dart';
import 'package:bitfrog/ui/page/alert/alert_price_page.dart';
import 'package:bitfrog/ui/page/alert/alert_sharp_price_page.dart';
import 'package:bitfrog/ui/page/alert/alert_signal_page.dart';
import 'package:bitfrog/ui/page/alert/alert_signal_set_page.dart';
import 'package:bitfrog/ui/page/alert/alert_symbol_page.dart';
import 'package:bitfrog/model/symbol_entity.dart' as SymbolA;
import 'package:bitfrog/ui/page/alert/alert_config_detail_page.dart';
class AlertRouter extends IRouter {
  @override
  List<PageBuilder> getPageBuilders() {
    return [
      PageBuilder(Routers.alertConfigPage, (_) => const AlertConfigPage()),
      PageBuilder(Routers.alertPhonePage, (_) => const AlertPhonePage()),
      PageBuilder(Routers.alertHistoryPage, (_) => const AlertHistoryPage()),
      PageBuilder(Routers.alertPricePage, (_) => const AlertPricePage()),
      PageBuilder(Routers.alertSymbolPage, (params) {
        int type = params?.getInt('type') ?? 0;
        return AlertSymbolPage(type: type);
      }),
      PageBuilder(Routers.alertAddPricePage, (params) {
        BFSymbol symbol = params?.getObj('symbol');
        return AlertAddPricePage(symbol: symbol);
      }),
      PageBuilder(Routers.alertSharpPricePage, (params) {
        String tip = params?.getString('tip') ?? '';
        return AlertSharpPricePage(tip: tip);
      }),
      PageBuilder(Routers.alertDetailPage, (params) {
        String id = params?.getString('id') ?? '';
        AlertShowTypes? types = params?.getObj("types");
        return AlertDetailPage(id: id,type:types ,);
      }),
      PageBuilder(Routers.alertIndexPage, (params) {
        String type = params?.getString('type') ?? '';
        String title = params?.getString('title') ?? '';
        String tip = params?.getString('tip') ?? '';
        return AlertIndexPage(type: type, title: title, tip: tip);
      }),
      PageBuilder(Routers.alertSignalPage, (params) {
        String id = params?.getString('id') ?? '';
        return const AlertSignalPage();
      }),
      PageBuilder(Routers.alertSignalSetPage,(params) {
        SymbolA.BFSymbol? symbol = params?.getObj("symbol");
        return  AlertSignalSetPage(symbol: symbol,);
      }),
      PageBuilder(Routers.alertConfigDetailPage,(params) {
        String type = params?.getString('type') ?? '';
        return AlertConfigDetailPage(type: type);
      }),
    ];
  }
}

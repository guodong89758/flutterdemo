import 'package:bitfrog/router/i_router.dart';
import 'package:bitfrog/router/page_builder.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/page/assets/access_trader_account_page.dart';
import 'package:bitfrog/ui/page/assets/asset_deposit_page.dart';
import 'package:bitfrog/ui/page/assets/asset_record_detail_page.dart';
import 'package:bitfrog/ui/page/assets/asset_record_page.dart';
import 'package:bitfrog/ui/page/assets/asset_transfer_page.dart';
import 'package:bitfrog/ui/page/assets/asset_withdraw_page.dart';
import 'package:bitfrog/ui/page/assets/assets_api_account_contract_record_page.dart';
import 'package:bitfrog/ui/page/assets/assets_api_account_spot_record_page.dart';
import 'package:bitfrog/ui/page/assets/assets_classify_page.dart';
import 'package:bitfrog/ui/page/assets/assets_voices_page.dart';
import 'package:bitfrog/ui/page/assets/currency_choice_page.dart';
import 'package:bitfrog/ui/page/assets/follow_record_page.dart';
import 'package:bitfrog/ui/page/assets/model/asset_record_entity.dart';
import 'package:bitfrog/ui/page/assets/qrcode_scanner_page.dart';
import 'package:bitfrog/ui/page/assets/spot_record_page.dart';
import 'package:bitfrog/ui/page/assets/transfer_record_page.dart';

class AssetsRouter extends IRouter {
  @override
  List<PageBuilder> getPageBuilders() {
    return [
      PageBuilder(Routers.assetsDeposit, (_) => const AssetDepositPage()),
      PageBuilder(Routers.assetsWithdraw, (_) => const AssetWithdrawPage()),
      PageBuilder(Routers.assetsRecord, (params) {
        int type = params?.getInt('type') ?? 0;
        String currency = params?.getString('currency') ?? '';
        return AssetRecordPage(type: type, currency: currency);
      }),
      PageBuilder(Routers.assetsRecordDetail, (params) {
        int type = params?.getInt('type') ?? 0;
        RecordEntity record = params?.getObj('record');
        return AssetRecordDetailPage(type: type, record: record);
      }),
      PageBuilder(Routers.assetsSpotRecord, (_) => const SpotRecordPage()),
      PageBuilder(Routers.assetsFollowRecord, (_) => const FollowRecordPage()),
      PageBuilder(Routers.assetsQrcodeScanner, (_) => const QrcodeScannerPage()),
      PageBuilder(Routers.assetsClassify, (params) {
        final defaultTabName = params?.getString('defaultTabName');
        return AssetsClassifyPage(defaultTabName: defaultTabName);
      }),
      PageBuilder(Routers.accessTraderAccountPage, (_) => const AccessTraderAccountPage()),
      PageBuilder(Routers.assetsTransfer, (_) => const AssetTransferPage()),
      PageBuilder(Routers.assetsVoice, (_) => const AssetsVoicePage()),
      PageBuilder(Routers.assetsTransferRecord, (_) => const TransferRecordPage()),

      PageBuilder(Routers.currencyChoiceSymbol, (params) {
        String type = params?.getString('type') ?? '';
        String apiId = params?.getString('apiId') ?? '';
        return CurrencyChoiceSymbolPage(apiId: apiId, type: type);
      }),

      PageBuilder(Routers.assetsApiAccountSpotRecord, (_) => const AssetsApiAccountSpotRecordPage()),
      PageBuilder(Routers.assetsApiAccountContractRecord, (_) => const AssetsApiAccountContractRecordPage()),
    ];
  }
}

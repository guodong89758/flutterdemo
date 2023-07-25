import 'dart:async';

import 'package:bitfrog/api/bitfrog_api.dart';
import 'package:bitfrog/base/view_state.dart';
import 'package:bitfrog/base/view_state_model.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/ui/page/assets/model/asset_account_entity.dart';
import 'package:bitfrog/ui/page/assets/model/currency_choose_entity.dart';
import 'package:bitfrog/ui/page/assets/request/assets_api.dart';
import 'package:bitfrog/utils/toast_util.dart';

class AssetTransferModel extends ViewStateModel {
  List<AssetAccountEntity> accountList = [];
  AssetAccountEntity? selectAccount;
  List<SymbolCurrency> oldLists = [];
  SymbolCurrency ? symbolCurrency;
  String currency = '';
  String balance = '0';
  String balanceMax = '0';
  String from_type = 'spot';
  String to_type = 'swap';
  AssetTransferModel() : super(viewState: ViewState.first);

  @override
  void dispose() {
    super.dispose();
  }

  void listenEvent() {}

  /// 获取划转账户
  Future getTransferAccount() {
    accountList.clear();
  return AssetsApi.instance.getTransferAccountList(
        cancelToken: cancelToken,
        onSuccess: (dynamic data) {
          List<AssetAccountEntity> typeData =
          data == null ? [] : AssetAccountEntity.fromJsonList(data) ?? [];
          accountList.clear();
          accountList.addAll(typeData);
          if (accountList.isNotEmpty) {
            selectAccount = accountList?[0];
            selectAccount?.checked = true;
            getCurrenys(selectAccount?.id ?? '', from_type);
          }

        },
        onError: (code, msg)
    {
      setError(code, message: msg);
      return false;
    });
  }
  Future getCurrenys(String id ,String type){
   return BitFrogApi.instance.transferCurrenciesList( id,type,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
         oldLists = data== null ? [] : SymbolCurrencyEntity.fromJsonList(data) ?? [];

         if(currency.isEmpty){
           symbolCurrency = oldLists.first;
         }else{
           for(SymbolCurrency item in oldLists){
             if(item.currency==currency){
               symbolCurrency = item;
               break;
             }
           }
         }
         currency = symbolCurrency?.currency ??'0';
         balanceMax = symbolCurrency?.withdrawAvailable?.amount ?? '';
          setSuccess();

        },onError: (code, msg) {
          setError(code, message: msg);
          return false;
        }
        );
  }
  Future transferPlay({Function? onSuccess}){
    return AssetsApi.instance.transferApply(
        from_type,selectAccount?.id ??'',to_type,selectAccount?.id ??'',currency,balance,
        cancelToken: cancelToken,
        onSuccess: (dynamic data) {

          onSuccess?.call();
        },
        onError: (code, msg) {
          setError(code, message: msg);
          return false;
        });

  }

}

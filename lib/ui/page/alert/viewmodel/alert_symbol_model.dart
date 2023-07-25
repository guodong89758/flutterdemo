import 'package:bitfrog/api/bitfrog_api.dart';
import 'package:bitfrog/model/symbol_entity.dart';
import 'package:bitfrog/net/network_api.dart';
import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';
import 'package:dio/dio.dart';

class AlertSymbolModel extends ListCommonModel {
  String? keyword;

  void searchSymbol(String keyword) {
    this.keyword = keyword;
    refresh();
  }

  @override
  requestData({
    required RequestListDataCallback requestListData,
    NetErrorCallback? onError,
    CancelToken? cancelToken,
  }) {
    BitFrogApi.instance.getSymbols(
      keyword: keyword ?? '',
      page: page,
      size: pageSize,
      cancelToken: cancelToken,
      onSuccess: (dynamic data) {
        SymbolEntity symbolData = SymbolEntity.fromJson(data);
        requestListData(symbolData.data ?? []);
      },
      onError: onError,
    );
  }
}

import 'package:bitfrog/api/bitfrog_api.dart';
import 'package:bitfrog/ui/page/financial/model/voice_auth_entity.dart';
import 'package:bitfrog/ui/page/financial/model/voice_count_entity.dart';
import 'package:bitfrog/ui/page/financial/model/voice_record_entity.dart';
import 'package:dio/dio.dart';
import 'package:bitfrog/net/network_api.dart';
import 'package:bitfrog/ui/page/community/viewmodel/list_common_model.dart';


class AssetsVoiceModel extends ListCommonModel {


  VoiceCountEntity? voiceCountEntity;
  bool? isBindMobile;



  AssetsVoiceModel():super(){
    getVoiceInfo();
  }




  @override
  requestData(
      {required RequestListDataCallback requestListData,
        NetErrorCallback? onError,
        CancelToken? cancelToken}) {
    BitFrogApi.instance.getVoiceHistory(page, pageSize,
        cancelToken: cancelToken, onSuccess: (dynamic data) {
          VoiceRecordEntity voiceRecordEntity = VoiceRecordEntity.fromJson(data);
          totalCountData = voiceRecordEntity.count;
          requestListData(voiceRecordEntity.data ?? []);
        },onError: onError);
  }


  getVoiceInfo(){
    Future.wait<dynamic>([
      getVoiceCountsModel(),
      getVoice_AuthInfo(),
    ]).then((value){
      voiceCountEntity = VoiceCountEntity.fromJson(value.first);
      VoiceAuthEntity modelAuth = VoiceAuthEntity.fromJson(value.last);
      isBindMobile = modelAuth.is_mobile ?? false;
      setSuccess();
    },onError: (e){
      setError(0);
    });
  }



  Future getVoiceCountsModel() {
    return BitFrogApi.instance.getVoiceCount(
      cancelToken: cancelToken,
    );
  }

  Future getVoice_AuthInfo() {
    return BitFrogApi.instance.getVoiceAuthInfo(
      cancelToken: cancelToken,
    );
  }

 
  
}

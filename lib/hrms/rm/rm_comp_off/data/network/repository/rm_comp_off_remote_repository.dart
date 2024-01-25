import 'package:awign_saas/hrms/rm/rm_comp_off/data/model/comp_off_approve_reject_request.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/data/model/rm_comp_off_search_response.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/data/network/api/rm_comp_off_api.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/data/network/data_source/rm_comp_off_remote_data_source.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/data/model/advance_search/advance_search_request.dart';
import '../../../../../../core/data/network/client/rest_client.dart';
import '../../../../../../core/utils/app_log.dart';

class RMCompOffRemoteRepository extends RMCompOffAPI
    implements RMCompOffRemoteDataSource {
  @override
  Future<RMCompOffSearchResponse> searchCompOff(AdvancedSearchRequest advancedSearchRequest) async {
    try {
      Response response = await bffRestClient.post(searchCompOffAPI, body: advancedSearchRequest.toJson());
      return RMCompOffSearchResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('searchCompOff : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> approveOrRejectCompOff(int compOffID, CompOffApproveRejectRequest approveRejectRequest) async {
    try {
      Response response = await bffRestClient.post(approveOrRejectCompOffAPI.replaceFirst('COMP_OFF_ID', compOffID.toString()),
      body: approveRejectRequest.toJson());
    } catch (e) {
      AppLog.e('approveOrRejectCompOff : ${e.toString()}');
      rethrow;
    }
  }

}

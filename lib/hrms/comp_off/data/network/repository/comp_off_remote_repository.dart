import 'package:awign_saas/hrms/comp_off/data/model/apply_comp_off_request.dart';
import 'package:awign_saas/hrms/comp_off/data/model/apply_comp_off_response.dart';
import 'package:awign_saas/hrms/comp_off/data/model/comp_off_details_response.dart';
import 'package:awign_saas/hrms/comp_off/data/model/employee_comp_off_response.dart';
import 'package:awign_saas/hrms/comp_off/data/network/api/comp_off_api.dart';
import 'package:awign_saas/hrms/comp_off/data/network/data_source/comp_off_remote_data_sourcee.dart';
import 'package:dio/dio.dart';
import '../../../../../core/data/model/advance_search/advance_search_request.dart';
import '../../../../../core/data/network/client/rest_client.dart';
import '../../../../../core/utils/app_log.dart';

class CompOffRemoteRepository extends CompOffAPI
    implements CompOffRemoteDataSource {

  @override
  Future<ApplyCompOffResponse> applyCompOff(ApplyCompOffRequest applyCompOffRequest) async {
    try {
      Response response = await bffRestClient
          .post(applyCompOffAPI, body: applyCompOffRequest.toJson());
      return ApplyCompOffResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('applyCompOff : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<EmployeeCompOffResponse> getEmployeeCompOffList(AdvancedSearchRequest advancedSearchRequest) async {
    try {
      Response response = await bffRestClient.post(getEmployeeCompOffAPI, body: advancedSearchRequest.toJson());
      return EmployeeCompOffResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('getEmployeeCompOffList : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<CompOffDetailsResponse> getCompOffDetails(int compOffID) async {
    try {
      Response response = await bffRestClient.get(getCompOffDetailsAPI.replaceFirst('COMP_OFF_ID', compOffID.toString()));
      return CompOffDetailsResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('getCompOffDetails : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> withdrawCompOff(int compOffID) async {
    try {
      Response response = await bffRestClient
          .post(withdrawCompOffAPI.replaceFirst('COMP_OFF_ID', compOffID.toString()));
    } catch (e) {
      AppLog.e('withdrawCompOff : ${e.toString()}');
      rethrow;
    }
  }

}

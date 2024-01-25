import 'package:awign_saas/core/data/network/client/rest_client.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/appy_reimbursement_data.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/category_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_detail_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_type_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/network/api/reimbursement_api.dart';
import 'package:awign_saas/hrms/reimbursements/data/network/data_source/reimbursement_remote_data_source.dart';
import 'package:dio/dio.dart';

import '../../model/manager_response.dart';

class ReimbursementRemoteRepository extends ReimbursementAPI
    implements ReimbursementRemoteDataSource {

  @override
  Future<ReimbursementResponse> getAllReimbursement(String status, String startDate, String endDate) async {
    try {
      final Map<String,dynamic> queryParams = {
        if(status != '') "status" : status,
        if(startDate != '') "start_date" : startDate,
        if(endDate != '') "end_date" : endDate,
      };
      Response response = await bffRestClient.get(getAllReimbursementAPI,
          queryParams: queryParams
      );
      return ReimbursementResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('getAllReimbursement : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future createReimbursement(ApplyReimbursementData applyReimbursementData) async {
    try {
      Response response = await bffRestClient.post(createReimbursementAPI,body: applyReimbursementData.toJson());
    } catch (e) {
      AppLog.e('createReimbursement : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<ReimbursementCategoryResponse> getReimbursementCategory() async {
    try {
      Response response = await bffRestClient.get(getReimbursementCategoryAPI);
      return ReimbursementCategoryResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('getReimbursementCategory : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<ReimbursementDetailResponse> getReimbursement(String uuid) async {
    try {
      Response response = await bffRestClient.get(getReimbursementAPI.replaceAll('uuid', uuid));
      return ReimbursementDetailResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('getReimbursement : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<ManagerResponse> getManager(String id) async {
    try {
      Response response = await bffRestClient.get(getManagerAPI.replaceAll('id', id));
      return ManagerResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('getManager : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future deleteReimbursement(String uuid) async {
    try {
      Response response = await bffRestClient.patch(deleteReimbursementAPI.replaceAll('uuid', uuid),body: {
        "deleted":true
      });
    } catch (e) {
      AppLog.e('deleteReimbursement : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<ReimbursementTypeResponse> getReimbursementTypes() async {
    try {
      Response response = await bffRestClient.get(getReimbursementTypesAPI);
      return ReimbursementTypeResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('getReimbursementTypes : ${e.toString()}');
      rethrow;
    }
  }
}

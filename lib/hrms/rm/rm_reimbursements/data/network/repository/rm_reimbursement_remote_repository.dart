import 'package:awign_saas/core/data/model/advance_search/advance_search_request.dart';
import 'package:awign_saas/core/data/network/client/rest_client.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_response.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/data/model/employee_search_response.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/data/network/api/rm_reimbursement_api.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/data/network/data_source/rm_reimbursement_data_source.dart';
import 'package:dio/dio.dart';

import '../../model/rm_reimbursement_search_response.dart';

class RMReimbursementRemoteRepository extends RMReimbursementAPI
    implements RMReimbursementRemoteDataSource {

  @override
  Future<RmReimbursementSearchResponse> searchReimbursement(AdvancedSearchRequest advancedSearchRequest) async {
    try {
      Response response = await bffRestClient.post(getReimbursementStatusAPI,body: advancedSearchRequest.toJson());
      return RmReimbursementSearchResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('getReimbursementStatus : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future approvedReimbursement(Map<String,dynamic> body,String? expenseId,bool? isApproved) async {
    try {
      Response response = await bffRestClient.patch(approveReimbursementAPI.replaceAll('expense_id', expenseId!).replaceAll('approvedStatus',isApproved! ? 'APPROVED' : 'REJECTED'),body: body);
    } catch (e) {
      AppLog.e('approvedReimbursement : ${e.toString()}');
      rethrow;
    }
  }
}
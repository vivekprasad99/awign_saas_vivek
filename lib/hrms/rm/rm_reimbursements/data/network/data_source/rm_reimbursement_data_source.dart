
import 'package:awign_saas/core/data/model/advance_search/advance_search_request.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_response.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/data/model/rm_reimbursement_search_response.dart';

import '../../model/employee_search_response.dart';

abstract class RMReimbursementRemoteDataSource {
  Future<RmReimbursementSearchResponse> searchReimbursement(AdvancedSearchRequest advancedSearchRequest);
  Future approvedReimbursement(Map<String,dynamic> body,String? expenseId,bool? isApproved);
}
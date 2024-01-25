import 'package:awign_saas/core/data/model/advance_search/advance_search_request.dart';
import 'package:awign_saas/hrms/comp_off/data/model/apply_comp_off_request.dart';
import 'package:awign_saas/hrms/comp_off/data/model/apply_comp_off_response.dart';
import 'package:awign_saas/hrms/comp_off/data/model/comp_off_details_response.dart';

import '../../model/employee_comp_off_response.dart';

abstract class CompOffRemoteDataSource {
  Future<ApplyCompOffResponse> applyCompOff(ApplyCompOffRequest applyCompOffRequest);
  Future<EmployeeCompOffResponse> getEmployeeCompOffList(AdvancedSearchRequest advancedSearchRequest);
  Future<CompOffDetailsResponse> getCompOffDetails(int compOffID);
  Future<void> withdrawCompOff(int compOffID);
}

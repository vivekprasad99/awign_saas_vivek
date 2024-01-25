import 'package:awign_saas/core/data/model/advance_search/advance_search_request.dart';
import 'package:awign_saas/hrms/leaves/data/model/search_leave_response.dart';

import '../../model/apply_leave_request.dart';
import '../../model/apply_leave_response.dart';
import '../../model/leave.dart';
import '../../model/leave_balance_response.dart';
import '../../model/leave_types_response.dart';

abstract class LeavesRemoteDataSource {
  Future<LeaveTypesResponse> getLeaveTypes(String leaveType);
  Future<ApplyLeaveResponse> applyLeave(ApplyLeaveRequest applyLeaveRequest, String tenantID);
  Future<SearchLeaveResponse> searchLeave(AdvancedSearchRequest advancedSearchRequest, String tenantID);
  Future<Leave> getLeaveDetails(int leaveID, String tenantID);
  Future<void> withdrawLeave(int leaveID);
  Future<LeaveBalanceResponse> getLeaveBalance();
}

import '../../../../../../core/data/model/advance_search/advance_search_request.dart';
import '../../../../../leaves/data/model/leave.dart';
import '../../../../../leaves/data/model/search_leave_response.dart';
import '../../model/update_leave_request.dart';

abstract class RMLeavesRemoteDataSource {
  Future<SearchLeaveResponse> searchLeaves(AdvancedSearchRequest advancedSearchRequest);
  Future<Leave> approveOrDeclineLeave(UpdateLeaveRequest updateLeaveRequest);
  Future<Leave> approveHolidayLeave(int holidayLeaveID);
  Future<Leave> rejectHolidayLeave(int holidayLeaveID);
}

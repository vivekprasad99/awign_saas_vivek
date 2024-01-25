import 'package:awign_saas/core/data/model/advance_search/advance_search_request.dart';
import 'package:awign_saas/hrms/leaves/data/model/search_leave_response.dart';
import 'package:awign_saas/hrms/rm/rm_leaves/data/model/update_leave_request.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/data/network/client/rest_client.dart';
import '../../../../../../core/utils/app_log.dart';
import '../../../../../leaves/data/model/leave.dart';
import '../api/rm_leaves_api.dart';
import '../data_source/rm_leaves_remote_data_source.dart';

class RMLeavesRemoteRepository extends RMLeavesAPI
    implements RMLeavesRemoteDataSource {

  @override
  Future<SearchLeaveResponse> searchLeaves(AdvancedSearchRequest advancedSearchRequest) async {
    try {
      Response response = await bffRestClient
          .post(searchLeavesAPI, body: advancedSearchRequest.toJson());
      return SearchLeaveResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('searchLeaves : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<Leave> approveOrDeclineLeave(UpdateLeaveRequest updateLeaveRequest) async {
    try {
      Response response = await bffRestClient
          .patch(approveOrDeclineLeaveAPI, body: updateLeaveRequest.toJson());
      return Leave.fromJson(response.data);
    } catch (e) {
      AppLog.e('approveOrDeclineLeave : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<Leave> approveHolidayLeave(int holidayLeaveID) async {
    try {
      Response response = await bffRestClient
          .patch(approveHolidayLeaveAPI.replaceFirst('HOLIDAY_LEAVE_ID', holidayLeaveID.toString()));
      return Leave.fromJson(response.data);
    } catch (e) {
      AppLog.e('approveHolidayLeave : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<Leave> rejectHolidayLeave(int holidayLeaveID) async {
    try {
      Response response = await bffRestClient
          .patch(rejectHolidayLeaveAPI.replaceFirst('HOLIDAY_LEAVE_ID', holidayLeaveID.toString()));
      return Leave.fromJson(response.data);
    } catch (e) {
      AppLog.e('rejectHolidayLeave : ${e.toString()}');
      rethrow;
    }
  }
}

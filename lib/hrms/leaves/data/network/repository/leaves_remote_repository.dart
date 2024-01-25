import 'package:awign_saas/core/data/model/advance_search/advance_search_request.dart';
import 'package:awign_saas/hrms/leaves/data/model/apply_leave_request.dart';
import 'package:awign_saas/hrms/leaves/data/model/leave_balance_response.dart';
import 'package:awign_saas/hrms/leaves/data/model/search_leave_response.dart';
import 'package:awign_saas/hrms/leaves/data/network/api/leaves_api.dart';
import 'package:awign_saas/hrms/leaves/data/network/data_source/leaves_remote_data_source.dart';
import 'package:dio/dio.dart';
import '../../../../../core/data/network/client/rest_client.dart';
import '../../../../../core/data/network/helper/headers_utils.dart';
import '../../../../../core/utils/app_log.dart';
import '../../model/apply_leave_response.dart';
import '../../model/leave.dart';
import '../../model/leave_types_response.dart';

class LeavesRemoteRepository extends LeavesAPI
    implements LeavesRemoteDataSource {
  static const leaveTransactionID = 'leave_transaction_id';
  @override
  Future<LeaveTypesResponse> getLeaveTypes(String leaveType) async {
    try {
      Response response = await bffRestClient
          .get(getLeaveTypesAPI.replaceFirst('leaveType', leaveType));
      return LeaveTypesResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('getLeaveTypes : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<ApplyLeaveResponse> applyLeave(ApplyLeaveRequest applyLeaveRequest, String tenantID) async {
    try {
      Response response = await bffRestClient
          .post(applyLeaveAPI, body: applyLeaveRequest.toJson(), header: {HeadersUtils.tenantID: tenantID});
      return ApplyLeaveResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('applyLeave : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<SearchLeaveResponse> searchLeave(AdvancedSearchRequest advancedSearchRequest, String tenantID) async {
    try {
      Response response = await bffRestClient
          .post(searchLeaveAPI, body: advancedSearchRequest.toJson(), header: {HeadersUtils.tenantID: tenantID});
      return SearchLeaveResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('searchLeave : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<Leave> getLeaveDetails(int leaveID, String tenantID) async {
    try {
      Response response = await bffRestClient
          .get(getLeaveDetailsAPI.replaceFirst('leaveID', leaveID.toString()), header: {HeadersUtils.tenantID: tenantID});
      return Leave.fromJson(response.data);
    } catch (e) {
      AppLog.e('getLeaveDetails : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> withdrawLeave(int leaveID) async {
    try {
      Response response = await bffRestClient
          .patch(withdrawLeaveAPI, body: {leaveTransactionID: leaveID});
    } catch (e) {
      AppLog.e('withdrawLeave : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<LeaveBalanceResponse> getLeaveBalance() async {
    try {
      Response response = await bffRestClient.get(getLeaveBalanceAPI);
      return LeaveBalanceResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('getLeaveBalance : ${e.toString()}');
      rethrow;
    }
  }
}

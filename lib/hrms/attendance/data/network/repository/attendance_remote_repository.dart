import 'package:awign_saas/hrms/attendance/data/network/api/attendance_api.dart';
import 'package:awign_saas/hrms/attendance/data/network/data_source/attendance_remote_data_source.dart';
import 'package:dio/dio.dart';
import '../../../../../core/data/network/client/rest_client.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../attendance/data/model/punch_request.dart';
import '../../../../attendance/data/model/punch_response.dart';
import '../../model/attendance_response.dart';
import '../../model/today_attendance_status.dart';
import '../../model/date_range_request.dart';

class AttendanceRemoteRepository extends AttendanceAPI
    implements AttendanceRemoteDataSource {
  @override
  Future<TodayAttendanceStatus> getAttendanceStatus() async {
    try {
      Response response = await bffRestClient.get(getAttendanceAPI);
      return TodayAttendanceStatus.fromJson(response.data);
    } catch (e) {
      AppLog.e('getAttendanceStatus : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<AttendanceResponse> getAttendanceStatusByDateRange(DateRangeRequest? attendanceStatusRequest) async {
    try {
      Response response = await bffRestClient.get(getAttendanceByDateRangeAPI, queryParams: attendanceStatusRequest?.toJson());
      return AttendanceResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('getAttendanceStatusByDateRange : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<PunchResponse> doPunchInPunchOut(PunchRequest punchRequest) async {
    try {
      Response response =
          await bffRestClient.post(punchAPI, body: punchRequest.toJson());
      return PunchResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('doPunchInPunchOut : ${e.toString()}');
      rethrow;
    }
  }
}

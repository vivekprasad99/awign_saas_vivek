import 'package:awign_saas/hrms/attendance/data/model/attendance_response.dart';

import '../../../../attendance/data/model/punch_request.dart';
import '../../../../attendance/data/model/punch_response.dart';
import '../../model/today_attendance_status.dart';
import '../../model/date_range_request.dart';

abstract class AttendanceRemoteDataSource {
  Future<TodayAttendanceStatus> getAttendanceStatus();
  Future<AttendanceResponse> getAttendanceStatusByDateRange(DateRangeRequest? attendanceStatusRequest);
  Future<PunchResponse> doPunchInPunchOut(PunchRequest punchRequest);
}

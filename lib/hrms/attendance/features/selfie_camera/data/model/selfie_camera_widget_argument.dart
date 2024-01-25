import 'package:awign_saas/hrms/attendance/data/model/punch_request.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../../core/data/local/database/model/current_user/work_location.dart';
import '../../../../data/model/today_attendance_status.dart';

class SelfieCameraWidgetArgument {
  PunchType? punchType;
  AttendanceType attendanceType;
  WorkLocation? workLocation;

  SelfieCameraWidgetArgument(this.punchType, this.attendanceType, this.workLocation);
}
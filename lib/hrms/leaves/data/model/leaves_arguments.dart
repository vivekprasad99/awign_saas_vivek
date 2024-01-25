import '../../../attendance/data/model/attendance_response.dart';
import '../../../holidays/data/model/holiday_search_response.dart';
import '../../../regularisation/data/model/regularisation_status_response.dart';

class LeavesArgument {
  AttendanceDetails? attendanceDetails;
  Regularisation? regularisation;
  AttendanceStatusEntity? attendanceStatusEntity;

  LeavesArgument(
      {this.attendanceDetails, this.regularisation, this.attendanceStatusEntity});
}

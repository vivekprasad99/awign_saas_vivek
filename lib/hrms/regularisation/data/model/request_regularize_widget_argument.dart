import '../../../attendance/data/model/attendance_response.dart';

class RequestRegularizeWidgetArgument {
  AttendanceDetails? attendanceDetails;
  AttendanceStatusEntity? attendanceStatusEntity;

  RequestRegularizeWidgetArgument(
      {this.attendanceDetails, this.attendanceStatusEntity});
}

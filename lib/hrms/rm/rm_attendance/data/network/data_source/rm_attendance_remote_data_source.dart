import '../../../../../attendance/data/model/date_range_request.dart';
import '../../model/employee_attendance.dart';

abstract class RMAttendanceRemoteDataSource {
  Future<List<EmployeeAttendance>?> getEmployeesAttendanceStatus(DateRangeRequest? dateRangeRequest);
}

import 'package:dio/dio.dart';
import '../../../../../../core/data/network/client/rest_client.dart';
import '../../../../../../core/utils/app_log.dart';
import '../../../../../attendance/data/model/date_range_request.dart';
import '../../model/employee_attendance.dart';
import '../api/rm_attendance_api.dart';
import '../data_source/rm_attendance_remote_data_source.dart';

class RMAttendanceRemoteRepository extends RMAttendanceAPI
    implements RMAttendanceRemoteDataSource {

  @override
  Future<List<EmployeeAttendance>?> getEmployeesAttendanceStatus(DateRangeRequest? dateRangeRequest) async {
    try {
      Response response = await bffRestClient.post(getEmployeesAttendanceStatusAPI.replaceFirst('startDateValue', dateRangeRequest?.startDate ?? '')
          .replaceFirst('endDateValue', dateRangeRequest?.endDate ?? ''));
      List<EmployeeAttendance>? employeeAttendanceList;
      if (response.data != null && response.data is List) {
        employeeAttendanceList = <EmployeeAttendance>[];
        response.data.forEach((v) {
          employeeAttendanceList?.add(EmployeeAttendance.fromJson(v));
        });
      }
      return employeeAttendanceList;
    } catch (e) {
      AppLog.e('getEmployeesAttendanceStatus : ${e.toString()}');
      rethrow;
    }
  }
}

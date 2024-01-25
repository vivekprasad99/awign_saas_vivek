import '../../../../attendance/data/model/attendance_response.dart';

class EmployeeAttendance {
  String? employeeUuid;
  String? employeeName;
  String? employeeId;
  String? employeeEmail;
  String? employeeMobile;
  List<AttendanceDetails>? attendanceDetails;
  String? managersName;
  String? managersEmail;

  EmployeeAttendance(
      {this.employeeUuid,
        this.employeeName,
        this.employeeId,
        this.employeeEmail,
        this.employeeMobile,
        this.attendanceDetails,
        this.managersName,
        this.managersEmail});

  EmployeeAttendance.fromJson(Map<String, dynamic> json) {
    employeeUuid = json['employee_uuid'];
    employeeName = json['employee_name'];
    employeeId = json['employee_id'];
    employeeEmail = json['employee_email'];
    employeeMobile = json['employee_mobile'];
    if (json['attendance_status'] != null) {
      attendanceDetails = <AttendanceDetails>[];
      json['attendance_status'].forEach((v) {
        attendanceDetails!.add(AttendanceDetails.fromJson(v));
      });
    }
    managersName = json['managers_name'];
    managersEmail = json['managers_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_uuid'] = employeeUuid;
    data['employee_name'] = employeeName;
    data['employee_id'] = employeeId;
    data['employee_email'] = employeeEmail;
    data['employee_mobile'] = employeeMobile;
    if (attendanceDetails != null) {
      data['attendance_status'] =
          attendanceDetails!.map((v) => v.toJson()).toList();
    }
    data['managers_name'] = managersName;
    data['managers_email'] = managersEmail;
    return data;
  }
}
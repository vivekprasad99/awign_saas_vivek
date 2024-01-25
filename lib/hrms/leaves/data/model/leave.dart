import '../../../attendance/data/model/attendance_response.dart';
import 'leave_types_response.dart';

enum LeaveStatus {
  pending('PENDING'),
  approved('APPROVED'),
  rejected('REJECTED'),
  withdrawn('WITHDRAWN'),
  all('ALL');

  const LeaveStatus(this.value);

  final String value;

  static LeaveStatus? get(strPunchType) {
    switch(strPunchType) {
      case 'PENDING':
        return LeaveStatus.pending;
      case 'APPROVED':
        return LeaveStatus.approved;
      case 'REJECTED':
        return LeaveStatus.rejected;
      case 'WITHDRAWN':
        return LeaveStatus.withdrawn;
      case 'ALL':
        return LeaveStatus.all;
      default:
        return LeaveStatus.all;
    }
  }
}

class Leave {
  int? id;
  int? leaveId;
  LeaveStatus? status;
  LeaveStatus? leaveStatus;
  String? employeeName;
  String? managerName;
  String? managerId;
  String? reason;
  String? startDate;
  String? endDate;
  bool? startDateHalfDayAllowed;
  String? createdAt;
  String? updatedAt;
  double? numberOfDays;
  String? leaveType;
  String? employeeUid;
  String? leaveName;
  ShiftType? workingShift;
  String? holidayType;
  int? holidayId;
  String? holidayName;
  String? date;

  Leave(
      {this.id,
        this.leaveId,
        this.status,
        this.leaveStatus,
        this.employeeName,
        this.managerName,
        this.managerId,
        this.reason,
        this.startDate,
        this.endDate,
        this.startDateHalfDayAllowed,
        this.createdAt,
        this.updatedAt,
        this.numberOfDays,
        this.leaveType,
        this.employeeUid,
        this.leaveName,
        this.workingShift,
        this.holidayType,
        this.holidayId,
        this.holidayName,
        this.date,
      });

  Leave.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveId = json['leave_id'];
    status = LeaveStatus.get(json['status']);
    leaveStatus = LeaveStatus.get(json['leave_status']);
    employeeName = json['employee_name'];
    managerName = json['manager_name'];
    managerId = json['manager_id'];
    reason = json['reason'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startDateHalfDayAllowed = json['start_date_half_day_allowed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    numberOfDays = json['number_of_days'];
    leaveType = json['leave_type'];
    employeeUid = json['employee_uid'];
    leaveName = json['leave_name'];
    workingShift = ShiftType.get(json['working_shift']);
    holidayType = json['holiday_type'];
    holidayId = json['holiday_id'];
    leaveStatus = LeaveStatus.get(json['holiday_status']);
    holidayName = json['holiday_name'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leave_id'] = leaveId;
    data['status'] = status?.value;
    data['leave_status'] = leaveStatus?.value;
    data['employee_name'] = employeeName;
    data['manager_name'] = managerName;
    data['manager_id'] = managerId;
    data['reason'] = reason;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['start_date_half_day_allowed'] = startDateHalfDayAllowed;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['number_of_days'] = numberOfDays;
    data['leave_type'] = leaveType;
    data['employee_uid'] = employeeUid;
    data['leave_name'] = leaveName;
    data['working_shift'] = workingShift?.value;
    data['holiday_type'] = holidayType;
    data['holiday_id'] = holidayId;
    data['holiday_name'] = holidayName;
    data['date'] = date;
    return data;
  }
}
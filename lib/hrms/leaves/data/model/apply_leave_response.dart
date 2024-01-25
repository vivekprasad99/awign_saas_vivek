class ApplyLeaveResponse {
  int? id;
  int? leaveId;
  String? status;
  String? employeeName;
  String? managerName;
  String? managerId;
  String? reason;
  String? startDate;
  String? endDate;
  bool? startDateHalfDayAllowed;
  String? createdAt;
  String? updatedAt;

  ApplyLeaveResponse(
      {this.id,
        this.leaveId,
        this.status,
        this.employeeName,
        this.managerName,
        this.managerId,
        this.reason,
        this.startDate,
        this.endDate,
        this.startDateHalfDayAllowed,
        this.createdAt,
        this.updatedAt});

  ApplyLeaveResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveId = json['leave_id'];
    status = json['status'];
    employeeName = json['employee_name'];
    managerName = json['manager_name'];
    managerId = json['manager_id'];
    reason = json['reason'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startDateHalfDayAllowed = json['start_date_half_day_allowed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leave_id'] = leaveId;
    data['status'] = status;
    data['employee_name'] = employeeName;
    data['manager_name'] = managerName;
    data['manager_id'] = managerId;
    data['reason'] = reason;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['start_date_half_day_allowed'] = startDateHalfDayAllowed;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
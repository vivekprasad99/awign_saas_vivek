class ApplyLeaveRequest {
  String? reason;
  int? leaveId;
  int? holidayID;
  String? startDate;
  bool? startDateHalfDayAllowed;
  String? endDate;
  String? shift;
  String? managerUUID;

  ApplyLeaveRequest(
      {this.reason,
      this.leaveId,
      this.holidayID,
      this.startDate,
      this.startDateHalfDayAllowed,
      this.endDate,
      this.shift,
      this.managerUUID});

  ApplyLeaveRequest.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    leaveId = json['leave_id'];
    holidayID = json['holiday_leave_id'];
    startDate = json['start_date'];
    startDateHalfDayAllowed = json['start_date_half_day_allowed'];
    endDate = json['end_date'];
    shift = json['shift'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reason'] = reason;
    data['leave_id'] = leaveId;
    if(holidayID != null) {
      data['holiday_id'] = holidayID;
    }
    data['start_date'] = startDate;
    data['start_date_half_day_allowed'] = startDateHalfDayAllowed;
    if(endDate != null) {
      data['end_date'] = endDate;
    }
    if(shift != null) {
      data['shift'] = shift;
    }
    if(managerUUID != null) {
      data['manager_uuid'] = managerUUID;
    }
    return data;
  }
}

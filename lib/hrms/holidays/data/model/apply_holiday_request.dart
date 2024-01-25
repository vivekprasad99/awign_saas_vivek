class ApplyHolidayRequest {
  String? reason;
  int? holidayID;
  String? managerUUID;

  ApplyHolidayRequest(
      {this.reason,
        this.holidayID,
        this.managerUUID});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reason'] = reason;
    if(holidayID != null) {
      data['holiday_id'] = holidayID;
    }
    if(managerUUID != null) {
      data['manager_uuid'] = managerUUID;
    }
    return data;
  }
}

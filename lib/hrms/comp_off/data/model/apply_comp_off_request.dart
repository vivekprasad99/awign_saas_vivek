class ApplyCompOffRequest {
  String? employeeRemark;
  String? workDate;

  ApplyCompOffRequest({this.employeeRemark, this.workDate});

  ApplyCompOffRequest.fromJson(Map<String, dynamic> json) {
    employeeRemark = json['employee_remark'];
    workDate = json['work_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_remark'] = employeeRemark;
    data['work_date'] = workDate;
    return data;
  }
}
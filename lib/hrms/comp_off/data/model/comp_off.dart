enum CompOffStatus {
  pending('PENDING'),
  accepted('ACCEPTED'),
  rejected('REJECTED'),
  withdraw('WITHDRAW'),
  all('ALL');

  const CompOffStatus(this.value);

  final String value;

  static CompOffStatus? get(strPunchType) {
    switch(strPunchType) {
      case 'PENDING':
        return CompOffStatus.pending;
      case 'ACCEPTED':
        return CompOffStatus.accepted;
      case 'REJECTED':
        return CompOffStatus.rejected;
      case 'WITHDRAW':
        return CompOffStatus.withdraw;
      case 'ALL':
        return CompOffStatus.all;
      default:
        return CompOffStatus.all;
    }
  }
}

class CompOff {
  int? id;
  String? employeeUuid;
  String? managerUUID;
  String? managerName;
  String? tenantId;
  String? workDate;
  String? employeeRemark;
  CompOffStatus? status;
  String? createdAt;
  String? updatedAt;

  CompOff(
      {this.id,
        this.employeeUuid,
        this.managerUUID,
        this.managerName,
        this.tenantId,
        this.workDate,
        this.employeeRemark,
        this.status,
        this.createdAt,
        this.updatedAt});

  CompOff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeUuid = json['employee_uuid'];
    managerUUID = json['manager_uuid'];
    managerName = json['manager_name'];
    tenantId = json['tenant_id'];
    workDate = json['work_date'];
    employeeRemark = json['employee_remark'];
    status = CompOffStatus.get(json['status']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_uuid'] = employeeUuid;
    data['manager_uuid'] = managerUUID;
    data['manager_name'] = managerName;
    data['tenant_id'] = tenantId;
    data['work_date'] = workDate;
    data['employee_remark'] = employeeRemark;
    data['status'] = status?.value;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
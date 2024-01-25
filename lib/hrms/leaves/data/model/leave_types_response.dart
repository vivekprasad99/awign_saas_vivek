enum LeaveType {
  regular('REGULAR');

  const LeaveType(this.value);

  final String value;

  static LeaveType? get(strPunchType) {
    switch(strPunchType) {
      case 'REGULAR':
        return LeaveType.regular;
      default:
        return LeaveType.regular;
    }
  }
}

enum ShiftType {
  firstHalf('FIRST_HALF', 1),
  secondHalf('SECOND_HALF', 2),
  fullDay('FULL_DAY', 0);

  const ShiftType(this.value, this.intValue);

  final String value;
  final int intValue;

  static ShiftType? get(strShift) {
    switch(strShift) {
      case 'FIRST_HALF':
        return ShiftType.firstHalf;
      case 'SECOND_HALF':
        return ShiftType.secondHalf;
      case 'BOTH':
        return ShiftType.fullDay;
      default:
        return null;
    }
  }

  static ShiftType? getShiftByIndex(index) {
    switch(index) {
      case 1:
        return ShiftType.firstHalf;
      case 2:
        return ShiftType.secondHalf;
      case 0:
        return ShiftType.fullDay;
      default:
        return null;
    }
  }
}

class LeaveTypesResponse {
  List<LeaveTypeEntity>? leaves;

  LeaveTypesResponse({this.leaves});

  LeaveTypesResponse.fromJson(Map<String, dynamic> json) {
    if (json['leaves'] != null) {
      leaves = <LeaveTypeEntity>[];
      json['leaves'].forEach((v) {
        leaves!.add(LeaveTypeEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaves != null) {
      data['leaves'] = leaves!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveTypeEntity {
  int? id;
  String? name;
  String? employeeGender;
  bool? autoApproved;
  bool? carryForward;
  String? leaveType;
  String? tenantId;
  double? quantity;
  String? allocationType;
  String? createdAt;
  String? updatedAt;

  LeaveTypeEntity(
      {this.id,
        this.name,
        this.employeeGender,
        this.autoApproved,
        this.carryForward,
        this.leaveType,
        this.tenantId,
        this.quantity,
        this.allocationType,
        this.createdAt,
        this.updatedAt});

  LeaveTypeEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    employeeGender = json['employee_gender'];
    autoApproved = json['auto_approved'];
    carryForward = json['carry_forward'];
    leaveType = json['leave_type'];
    tenantId = json['tenant_id'];
    quantity = json['quantity'];
    allocationType = json['allocation_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['employee_gender'] = employeeGender;
    data['auto_approved'] = autoApproved;
    data['carry_forward'] = carryForward;
    data['leave_type'] = leaveType;
    data['tenant_id'] = tenantId;
    data['quantity'] = quantity;
    data['allocation_type'] = allocationType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
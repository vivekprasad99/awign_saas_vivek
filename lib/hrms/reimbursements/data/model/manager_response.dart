class ManagerResponse {
  List<Manager>? manager;

  ManagerResponse({this.manager});

  ManagerResponse.fromJson(Map<String, dynamic> json) {
    if (json['manager'] != null) {
      manager = <Manager>[];
      json['manager'].forEach((v) {
        manager!.add(Manager.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (manager != null) {
      data['manager'] = manager!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Manager {
  String? uuid;
  String? name;
  String? employeeId;
  String? panNumber;
  String? mobile;
  String? email;
  String? tenantId;
  String? designation;
  String? dateOfJoining;
  String? createdAt;
  String? updatedAt;
  int? version;

  Manager(
      {this.uuid,
        this.name,
        this.employeeId,
        this.panNumber,
        this.mobile,
        this.email,
        this.tenantId,
        this.designation,
        this.dateOfJoining,
        this.createdAt,
        this.updatedAt,
        this.version});

  Manager.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    employeeId = json['employee_id'];
    panNumber = json['pan_number'];
    mobile = json['mobile'];
    email = json['email'];
    tenantId = json['tenant_id'];
    designation = json['designation'];
    dateOfJoining = json['date_of_joining'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['employee_id'] = this.employeeId;
    data['pan_number'] = this.panNumber;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['tenant_id'] = this.tenantId;
    data['designation'] = this.designation;
    data['date_of_joining'] = this.dateOfJoining;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['version'] = this.version;
    return data;
  }
}

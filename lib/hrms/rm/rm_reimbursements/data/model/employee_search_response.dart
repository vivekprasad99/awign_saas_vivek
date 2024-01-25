class EmployeeSearchResponse {
  List<Employees>? employees;

  EmployeeSearchResponse({this.employees});

  EmployeeSearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['employees'] != null) {
      employees = <Employees>[];
      json['employees'].forEach((v) {
        employees!.add(Employees.fromJson(v));
      });
    }
  }
}

class Employees {
  String? uuid;
  String? name;
  String? employeeId;
  String? mobile;
  String? email;
  String? tenantId;
  String? designation;
  String? workingStatus;
  String? dateOfJoining;
  String? createdAt;

  Employees(
      {this.uuid,
        this.name,
        this.employeeId,
        this.mobile,
        this.email,
        this.tenantId,
        this.designation,
        this.workingStatus,
        this.dateOfJoining,
        this.createdAt});

  Employees.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    employeeId = json['employee_id'];
    mobile = json['mobile'];
    email = json['email'];
    tenantId = json['tenant_id'];
    designation = json['designation'];
    workingStatus = json['working_status'];
    dateOfJoining = json['date_of_joining'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['employee_id'] = this.employeeId;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['tenant_id'] = this.tenantId;
    data['designation'] = this.designation;
    data['working_status'] = this.workingStatus;
    data['date_of_joining'] = this.dateOfJoining;
    data['created_at'] = this.createdAt;
    return data;
  }
}

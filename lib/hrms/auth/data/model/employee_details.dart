import '../../../../core/data/local/database/model/current_user/work_location.dart';

class EmployeeDetails {
  String? tenantId;
  OtherDetails? otherDetails;
  String? shiftVersionId;
  String? gender;
  List<Teams>? teams;
  String? mobile;
  String? createdAt;
  String? uuid;
  WorkLocation? workLocation;
  String? userId;
  int? employeeCategoryId;
  String? employeeId;
  String? name;
  String? workingStatus;
  String? dateOfJoining;
  String? designation;
  String? state;
  String? email;

  EmployeeDetails(
      {this.tenantId,
        this.otherDetails,
        this.shiftVersionId,
        this.gender,
        this.teams,
        this.mobile,
        this.createdAt,
        this.uuid,
        this.workLocation,
        this.userId,
        this.employeeCategoryId,
        this.employeeId,
        this.name,
        this.workingStatus,
        this.dateOfJoining,
        this.designation,
        this.state,
        this.email});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    tenantId = json['tenant_id'];
    otherDetails = json['other_details'] != null
        ? OtherDetails.fromJson(json['other_details'])
        : null;
    shiftVersionId = json['shift_version_id'];
    gender = json['gender'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(Teams.fromJson(v));
      });
    }
    mobile = json['mobile'];
    createdAt = json['created_at'];
    uuid = json['uuid'];
    workLocation = json['work_location'] != null
        ? WorkLocation.fromJson(json['work_location'])
        : null;
    userId = json['user_id'];
    employeeCategoryId = json['employee_category_id'];
    employeeId = json['employee_id'];
    name = json['name'];
    workingStatus = json['working_status'];
    dateOfJoining = json['date_of_joining'];
    designation = json['designation'];
    state = json['state'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenant_id'] = tenantId;
    if (otherDetails != null) {
      data['other_details'] = otherDetails!.toJson();
    }
    data['shift_version_id'] = shiftVersionId;
    data['gender'] = gender;
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    data['mobile'] = mobile;
    data['created_at'] = createdAt;
    data['uuid'] = uuid;
    if (workLocation != null) {
      data['work_location'] = workLocation!.toJson();
    }
    data['user_id'] = userId;
    data['employee_category_id'] = employeeCategoryId;
    data['employee_id'] = employeeId;
    data['name'] = name;
    data['working_status'] = workingStatus;
    data['date_of_joining'] = dateOfJoining;
    data['designation'] = designation;
    data['state'] = state;
    data['email'] = email;
    return data;
  }
}

class OtherDetails {
  String? workingStatus;

  OtherDetails({this.workingStatus});

  OtherDetails.fromJson(Map<String, dynamic> json) {
    workingStatus = json['working_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['working_status'] = workingStatus;
    return data;
  }
}

class Teams {
  String? name;
  String? teamUuid;
  String? headName;
  String? headId;
  bool? head;
  bool? vertical;

  Teams(
      {this.name,
        this.teamUuid,
        this.headName,
        this.headId,
        this.head,
        this.vertical});

  Teams.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    teamUuid = json['team_uuid'];
    headName = json['head_name'];
    headId = json['head_id'];
    head = json['head'];
    vertical = json['vertical'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['team_uuid'] = teamUuid;
    data['head_name'] = headName;
    data['head_id'] = headId;
    data['head'] = head;
    data['vertical'] = vertical;
    return data;
  }
}

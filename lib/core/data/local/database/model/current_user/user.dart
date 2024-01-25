import 'package:awign_saas/core/data/local/database/model/current_user/tenant.dart';
import 'package:hive/hive.dart';

import '../../boxes.dart';
import 'permissions.dart';
import 'work_location.dart';

part 'user.g.dart';

@HiveType(typeId: Boxes.currentUserHoTypeID)
class User extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? organization;
  @HiveField(4)
  String? userType;
  @HiveField(5)
  Permissions? permissions;
  @HiveField(6)
  Tenant? tenant;
  @HiveField(7)
  bool? isManager;
  @HiveField(8)
  WorkLocation? workLocation;

  User(
      {this.id,
      this.name,
      this.email,
      this.organization,
      this.userType,
      this.permissions,
      this.tenant,
      this.isManager,
      this.workLocation});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    organization = json['organization'];
    userType = json['user_type'];
    permissions = json['permissions'] != null
        ? Permissions.fromJson(json['permissions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['organization'] = organization;
    data['user_type'] = userType;
    if (permissions != null) {
      data['permissions'] = permissions!.toJson();
    }
    return data;
  }
}

import 'package:hive/hive.dart';

import '../../boxes.dart';
part 'permissions.g.dart';

@HiveType(typeId: Boxes.permissionTypeID)
class Permissions {
  @HiveField(0)
  String? s65;
  @HiveField(1)
  String? s66;
  @HiveField(2)
  String? s68;

  Permissions({this.s65, this.s66, this.s68});

  Permissions.fromJson(Map<String, dynamic> json) {
    s65 = json['65'];
    s66 = json['66'];
    s68 = json['68'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['65'] = s65;
    data['66'] = s66;
    data['68'] = s68;
    return data;
  }
}
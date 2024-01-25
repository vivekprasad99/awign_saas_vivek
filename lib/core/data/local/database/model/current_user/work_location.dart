import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../boxes.dart';

part 'work_location.g.dart';

@HiveType(typeId: Boxes.workLocationTypeID)
class WorkLocation extends Equatable {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? address;
  @HiveField(2)
  String? branchCode;
  @HiveField(3)
  double? latitude;
  @HiveField(4)
  double? longitude;
  @HiveField(5)
  int? punchRadius;

  WorkLocation(
      {this.id,
        this.address,
        this.branchCode,
        this.latitude,
        this.longitude,
        this.punchRadius});

  WorkLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    branchCode = json['branch_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    punchRadius = json['punch_radius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['branch_code'] = branchCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['punch_radius'] = punchRadius;
    return data;
  }

  @override
  List<Object?> get props => [id, address, branchCode, latitude, longitude, punchRadius];
}
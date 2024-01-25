import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../boxes.dart';

part 'tenant.g.dart';

@HiveType(typeId: Boxes.tenantTypeID)
class Tenant extends Equatable {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? logoUrl;
  @HiveField(2)
  String? organization;
  @HiveField(3)
  int? billingCycle;
  @HiveField(4)
  String? userId;
  @HiveField(5)
  bool? isSelected;
  @HiveField(6)
  List<String>? modules;

  Tenant(
      {this.name,
      this.logoUrl,
      this.organization,
      this.billingCycle,
      this.userId,
      this.isSelected,
      this.modules});

  Tenant.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logoUrl = json['logo_url'];
    organization = json['organization'];
    billingCycle = json['billing_cycle'];
    userId = json['user_id'];
    modules = json['modules'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['logo_url'] = logoUrl;
    data['organization'] = organization;
    data['billing_cycle'] = billingCycle;
    data['user_id'] = userId;
    data['modules'] = modules;
    return data;
  }

  @override
  List<Object?> get props =>
      [name, logoUrl, organization, billingCycle, userId, isSelected];
}

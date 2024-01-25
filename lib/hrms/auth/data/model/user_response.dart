import '../../../../core/data/local/database/model/current_user/tenant.dart';
import '../../../../core/data/local/database/model/current_user/user.dart';

class UserResponse {
  User? user;
  bool? otpVerified;
  List<Tenant>? tenants;

  UserResponse({this.user, this.otpVerified, this.tenants});

  UserResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    otpVerified = json['otp_verified'];
    if (json['tenants'] != null) {
      tenants = <Tenant>[];
      json['tenants'].forEach((v) {
        tenants!.add(Tenant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['otp_verified'] = otpVerified;
    return data;
  }
}
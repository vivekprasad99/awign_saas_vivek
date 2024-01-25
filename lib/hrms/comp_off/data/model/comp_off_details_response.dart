import 'package:awign_saas/hrms/comp_off/data/model/comp_off.dart';

class CompOffDetailsResponse {
  String? message;
  String? status;
  CompOff? compOffDetails;

  CompOffDetailsResponse({this.message, this.status, this.compOffDetails});

  CompOffDetailsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    compOffDetails = json['data'] != null ? CompOff.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (compOffDetails != null) {
      data['data'] = compOffDetails!.toJson();
    }
    return data;
  }
}
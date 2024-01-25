import 'comp_off.dart';

class ApplyCompOffResponse {
  CompOff? data;
  String? message;
  String? status;

  ApplyCompOffResponse({this.data, this.message, this.status});

  ApplyCompOffResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CompOff.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
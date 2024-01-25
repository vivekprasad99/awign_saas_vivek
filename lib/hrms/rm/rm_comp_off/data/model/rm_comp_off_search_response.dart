import 'package:awign_saas/hrms/comp_off/data/model/comp_off.dart';

class RMCompOffSearchResponse {
  String? message;
  List<Data>? data;
  String? status;

  RMCompOffSearchResponse({this.message, this.data, this.status});

  RMCompOffSearchResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Data {
  List<CompOff>? compOffs;
  int? limit;
  int? page;
  int? totalCount;

  Data({this.compOffs, this.limit, this.page, this.totalCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['comp_offs'] != null) {
      compOffs = <CompOff>[];
      json['comp_offs'].forEach((v) {
        compOffs!.add(CompOff.fromJson(v));
      });
    }
    limit = json['limit'];
    page = json['page'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (compOffs != null) {
      data['comp_offs'] = compOffs!.map((v) => v.toJson()).toList();
    }
    data['limit'] = limit;
    data['page'] = page;
    data['total_count'] = totalCount;
    return data;
  }

  List<CompOff>? getPendingCompOffList() {
    return compOffs?.where((element) => element.status == CompOffStatus.pending).toList();
  }

  List<CompOff>? getApprovedCompOffList() {
    return compOffs?.where((element) => element.status == CompOffStatus.accepted).toList();
  }

  List<CompOff>? getRejectedCompOffList() {
    return compOffs?.where((element) => element.status == CompOffStatus.rejected).toList();
  }
}
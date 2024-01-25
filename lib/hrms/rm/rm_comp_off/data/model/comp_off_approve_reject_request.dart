import '../../../../comp_off/data/model/comp_off.dart';

class CompOffApproveRejectRequest {
  String? managerRemark;
  CompOffStatus? status;

  CompOffApproveRejectRequest({this.managerRemark, this.status});

  CompOffApproveRejectRequest.fromJson(Map<String, dynamic> json) {
    managerRemark = json['manager_remark'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['manager_remark'] = managerRemark;
    data['status'] = status?.value;
    return data;
  }
}
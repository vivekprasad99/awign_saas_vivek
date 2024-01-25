class UpdateLeaveRequest {
  String? status;
  int? leaveTransactionId;
  String? remarks;

  UpdateLeaveRequest({this.status, this.leaveTransactionId, this.remarks});

  UpdateLeaveRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    leaveTransactionId = json['leave_transaction_id'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['leave_transaction_id'] = leaveTransactionId;
    data['remarks'] = remarks;
    return data;
  }
}
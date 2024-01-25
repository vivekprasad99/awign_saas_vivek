import 'reimbursement_type_response.dart';

class ReimbursementDetailResponse {
  ReimbursementDetail? data;

  ReimbursementDetailResponse({this.data});

  ReimbursementDetailResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? ReimbursementDetail.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ReimbursementDetail {
  String? uuid;
  int? reimbursementCategoryId;
  String? reimbursementType;
  String? attachmentUrl;
  num? amount;
  String? approvedAmount;
  String? comments;
  String? invoiceNumber;
  String? invoiceDate;
  String? status;
  String? userId;
  String? userName;
  String? approverId;
  String? approverName;
  String? expenseId;
  String? createdAt;
  String? updatedAt;
  String? approvedAt;
  String? startDate;
  String? endDate;
  String? employeeId;
  Metadata? metadata;

  ReimbursementDetail(
      {this.uuid,
      this.reimbursementCategoryId,
      this.reimbursementType,
      this.attachmentUrl,
      this.amount,
      this.comments,
      this.invoiceNumber,
      this.invoiceDate,
      this.status,
      this.userId,
      this.userName,
      this.approverId,
      this.approverName,
      this.expenseId,
      this.createdAt,
      this.updatedAt,
      this.approvedAt,
      this.startDate,
      this.endDate,
      this.employeeId,
      this.metadata,
      this.approvedAmount});

  ReimbursementDetail.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    reimbursementCategoryId = json['reimbursement_category_id'];
    reimbursementType = json['reimbursement_type'];
    attachmentUrl = json['attachment_url'];
    amount = json['amount'];
    comments = json['comments'];
    invoiceNumber = json['invoice_number'];
    invoiceDate = json['invoice_date'];
    status = json['status'];
    userId = json['user_id'];
    userName = json['user_name'];
    approverId = json['approver_id'];
    approverName = json['approver_name'];
    expenseId = json['expense_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    approvedAt = json['approved_at'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    employeeId = json['employee_id'];
    metadata = json['metadata'] != null
        ? Metadata.fromJson(json['metadata'])
        : null;
    approvedAmount = json['approved_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['reimbursement_category_id'] = reimbursementCategoryId;
    data['reimbursement_type'] = reimbursementType;
    data['attachment_url'] = attachmentUrl;
    data['amount'] = amount;
    data['comments'] = comments;
    data['invoice_number'] = invoiceNumber;
    data['invoice_date'] = invoiceDate;
    data['status'] = status;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['approver_id'] = approverId;
    data['approver_name'] = approverName;
    data['expense_id'] = expenseId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['approved_at'] = approvedAt;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    data['approved_amount'] = approvedAmount;
    return data;
  }
}

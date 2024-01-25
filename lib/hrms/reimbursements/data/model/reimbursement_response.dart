enum ReimbursementStatus {
  pending('PENDING'),
  approved('APPROVED'),
  rejected('REJECTED'),
  all('ALL');

  const ReimbursementStatus(this.value);

  final String value;

  static ReimbursementStatus? get(strPunchType) {
    switch(strPunchType) {
      case 'PENDING':
        return ReimbursementStatus.pending;
      case 'APPROVED':
        return ReimbursementStatus.approved;
      case 'REJECTED':
        return ReimbursementStatus.rejected;
      case 'ALL':
        return ReimbursementStatus.all;
      default:
        return ReimbursementStatus.all;
    }
  }

}

  class ReimbursementResponse {
  List<Reimbursement>? data;

  ReimbursementResponse({this.data,});

  ReimbursementResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Reimbursement>[];
      json['data'].forEach((v) {
        data!.add(Reimbursement.fromJson(v));
      });
    }
  }
}

class Reimbursement {
  String? uuid;
  int? reimbursementCategoryId;
  String? attachmentUrl;
  num? amount;
  String? comments;
  String? invoiceNumber;
  String? reimbursementType;
  String? invoiceDate;
  String? status;
  String? userId;
  String? approverId;
  String? expenseId;
  String? createdAt;
  String? updatedAt;
  String? approvedAmount;

  Reimbursement(
      {this.uuid,
        this.reimbursementCategoryId,
        this.attachmentUrl,
        this.amount,
        this.comments,
        this.invoiceNumber,
        this.invoiceDate,
        this.reimbursementType,
        this.status,
        this.userId,
        this.approverId,
        this.expenseId,
        this.createdAt,
        this.updatedAt,
        this.approvedAmount});

  Reimbursement.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    reimbursementCategoryId = json['reimbursement_category_id'];
    attachmentUrl = json['attachment_url'];
    amount = json['amount'];
    comments = json['comments'];
    reimbursementType = json['reimbursement_type'];
    invoiceNumber = json['invoice_number'];
    invoiceDate = json['invoice_date'];
    status = json['status'];
    userId = json['user_id'];
    approverId = json['approver_id'];
    expenseId = json['expense_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    approvedAmount = json['approved_amount'];
  }
}

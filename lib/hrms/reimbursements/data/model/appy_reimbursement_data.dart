import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_type_response.dart';

class ApplyReimbursementData {
  String? name;
  String? startDate;
  String? endDate;
  String? description;
  List<Reimbursement>? reimbursement;

  ApplyReimbursementData(
      {this.name,
        this.startDate,
        this.endDate,
        this.description,
        this.reimbursement});

  ApplyReimbursementData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    if (json['reimbursement'] != null) {
      reimbursement = <Reimbursement>[];
      json['reimbursement'].forEach((v) {
        reimbursement!.add(Reimbursement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['description'] = description;
    if (reimbursement != null) {
      data['reimbursement'] =
          reimbursement!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reimbursement {
  int? reimbursementCategoryId;
  String? attachmentUrl;
  double? amount;
  String? comments;
  String? invoiceNumber;
  String? invoiceDate;
  String? approverId;
  Metadata? metadata;

  Reimbursement(
      {this.reimbursementCategoryId,
        this.attachmentUrl,
        this.amount,
        this.comments,
        this.invoiceNumber,
        this.invoiceDate,
        this.approverId,
        this.metadata});

  Reimbursement.fromJson(Map<String, dynamic> json) {
    reimbursementCategoryId = json['reimbursement_category_id'];
    attachmentUrl = json['attachment_url'];
    amount = json['amount'];
    comments = json['comments'];
    invoiceNumber = json['invoice_number'];
    invoiceDate = json['invoice_date'];
    approverId = json['approver_id'];
    metadata = json['metadata'] != null
        ? Metadata.fromJson(json['metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reimbursement_category_id'] = reimbursementCategoryId;
    data['attachment_url'] = attachmentUrl;
    data['amount'] = amount;
    data['comments'] = comments;
    data['invoice_number'] = invoiceNumber;
    data['invoice_date'] = invoiceDate;
    data['approver_id'] = approverId;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    return data;
  }
}

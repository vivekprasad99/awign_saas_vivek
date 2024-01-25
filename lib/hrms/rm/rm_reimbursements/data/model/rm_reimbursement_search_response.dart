import 'package:awign_saas/hrms/rm/rm_reimbursements/data/model/employee_search_response.dart';

class RmReimbursementSearchResponse {
  RmReimbursementSearch? rmReimbursementSearch;

  RmReimbursementSearchResponse({this.rmReimbursementSearch});

  RmReimbursementSearchResponse.fromJson(Map<String, dynamic> json) {
    rmReimbursementSearch = json['data'] != null
        ? RmReimbursementSearch.fromJson(json['data'])
        : null;
  }
}

class RmReimbursementSearch {
  List<Reimbursements>? reimbursements;
  int? limit;
  int? page;
  int? totalCount;

  RmReimbursementSearch(
      {this.reimbursements, this.limit, this.page, this.totalCount});

  RmReimbursementSearch.fromJson(Map<String, dynamic> json) {
    if (json['reimbursements'] != null) {
      reimbursements = <Reimbursements>[];
      json['reimbursements'].forEach((v) {
        reimbursements!.add(new Reimbursements.fromJson(v));
      });
    }
    limit = json['limit'];
    page = json['page'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reimbursements != null) {
      data['reimbursements'] =
          this.reimbursements!.map((v) => v.toJson()).toList();
    }
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['total_count'] = this.totalCount;
    return data;
  }
}

class Reimbursements {
  String? uuid;
  int? reimbursementCategoryId;
  String? reimbursementType;
  String? attachmentUrl;
  double? amount;
  String? comments;
  String? invoiceNumber;
  String? status;
  String? userId;
  String? employeeId;
  String? userName;
  String? approverId;
  String? expenseId;
  String? createdAt;
  String? updatedAt;
  Employees? employees;

  Reimbursements(
      {this.uuid,
      this.reimbursementCategoryId,
      this.reimbursementType,
      this.attachmentUrl,
      this.amount,
      this.comments,
      this.invoiceNumber,
      this.status,
      this.userId,
      this.approverId,
      this.expenseId,
      this.createdAt,
      this.updatedAt,
      this.employees,this.employeeId,this.userName});

  Reimbursements.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    reimbursementCategoryId = json['reimbursement_category_id'];
    reimbursementType = json['reimbursement_type'];
    attachmentUrl = json['attachment_url'];
    amount = json['amount'];
    comments = json['comments'];
    invoiceNumber = json['invoice_number'];
    status = json['status'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    userName = json['user_name'];
    approverId = json['approver_id'];
    expenseId = json['expense_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['reimbursement_category_id'] = this.reimbursementCategoryId;
    data['reimbursement_type'] = this.reimbursementType;
    data['attachment_url'] = this.attachmentUrl;
    data['amount'] = this.amount;
    data['comments'] = this.comments;
    data['invoice_number'] = invoiceNumber;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['approver_id'] = this.approverId;
    data['expense_id'] = this.expenseId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

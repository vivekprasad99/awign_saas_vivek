class ReimbursementCategoryResponse {
  List<ReimbursementCategory>? categories;

  ReimbursementCategoryResponse({this.categories});

  ReimbursementCategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      categories = <ReimbursementCategory>[];
      json['data'].forEach((v) {
        categories!.add(ReimbursementCategory.fromJson(v));
      });
    }
  }
}

class ReimbursementCategory {
  int? id;
  int? reimbursementSubTypeId;
  String? reimbursementSubType;
  int? employeeCategoryId;
  double? maxAmount;
  String? eligibilityDuration;
  String? createdAt;
  String? updatedAt;

  ReimbursementCategory(
      {this.id,
        this.reimbursementSubTypeId,
        this.reimbursementSubType,
        this.employeeCategoryId,
        this.maxAmount,
        this.eligibilityDuration,
        this.createdAt,
        this.updatedAt});

  ReimbursementCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reimbursementSubTypeId = json['reimbursement_sub_type_id'];
    reimbursementSubType = json['reimbursement_sub_type'];
    employeeCategoryId = json['employee_category_id'];
    maxAmount = json['max_amount'];
    eligibilityDuration = json['eligibility_duration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reimbursement_sub_type_id'] = reimbursementSubTypeId;
    data['reimbursement_sub_type'] = reimbursementSubType;
    data['employee_category_id'] = employeeCategoryId;
    data['max_amount'] = maxAmount;
    data['eligibility_duration'] = eligibilityDuration;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

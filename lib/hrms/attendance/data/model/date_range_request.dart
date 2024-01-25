class DateRangeRequest {
  String? startDate;
  String? endDate;
  String? status;

  DateRangeRequest({this.startDate, this.endDate, this.status});

  DateRangeRequest.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['status'] = status;
    return data;
  }
}

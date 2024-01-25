import 'leave.dart';

class SearchLeaveResponse {
  List<Leave>? leaveTransactions;

  SearchLeaveResponse({this.leaveTransactions});

  SearchLeaveResponse.fromJson(Map<String, dynamic> json) {
    if (json['leaves'] != null) {
      leaveTransactions = <Leave>[];
      json['leaves'].forEach((v) {
        leaveTransactions!.add(Leave.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaveTransactions != null) {
      data['leaves'] =
          leaveTransactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
import 'package:awign_saas/core/utils/constants.dart';

class LeaveBalanceResponse {
  Map<String, dynamic>? leaves;

  LeaveBalanceResponse({this.leaves});

  LeaveBalanceResponse.fromJson(Map<String, dynamic> json) {
    leaves = json['leaves'] != null ? json['leaves'] as Map<String, dynamic> : null;
    getCompOffBalance();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaves != null) {
      data['leaves'] = leaves;
    }
    return data;
  }

  double? getCompOffBalance() {
    if(leaves?.containsKey(Keys.compOff) ?? false) {
      double? value = leaves![Keys.compOff];
      if(value != null && value > 0) {
        return value;
      } else {
        leaves?.remove(Keys.compOff);
      }
    }
    return null;
  }
}
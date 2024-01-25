class LeavesAPI {
  final String getLeaveTypesAPI = 'api/v1/leave?type=leaveType';
  final String applyLeaveAPI = 'api/v1/leave_transaction/employee/apply';
  final String searchLeaveAPI = 'api/v1/leave_transaction/employee/search';
  final String getLeaveDetailsAPI = 'api/v1/leave_transaction/employee/leave/leaveID';
  final String withdrawLeaveAPI = '/api/v1/leave_transaction/employee/withdraw_leave';
  final String getLeaveBalanceAPI = 'api/v1/leave_balance/employee';
}

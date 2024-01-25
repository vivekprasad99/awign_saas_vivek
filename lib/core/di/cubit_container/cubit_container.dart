import 'package:awign_saas/hrms/auth/di/auth_cubit_container.dart' as auth_cc;
import 'package:awign_saas/hrms/reimbursements/di/reimbursements_cubit_container.dart'
    as reimbursement_cc;
import 'package:awign_saas/hrms/attendance/di/attendance_cubit_container.dart'
    as attendance_cc;
import 'package:awign_saas/hrms/leaves/di/leaves_cubit_container.dart'
    as leaves_cc;
import 'package:awign_saas/hrms/documents/di/document_cubit_container.dart'
    as document_cc;
import 'package:awign_saas/hrms/holidays/di/holiday_cubit_container.dart'
    as holiday_cc;

void init() {
  /// Cubits
  auth_cc.init();
  reimbursement_cc.init();
  attendance_cc.init();
  leaves_cc.init();
  holiday_cc.init();
  document_cc.init();
}

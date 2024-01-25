import 'package:awign_saas/hrms/auth/di/auth_repository_container.dart' as auth_rc;
import 'package:awign_saas/hrms/reimbursements/di/reimbursements_repository_container.dart' as reimbursements_rc;
import 'package:awign_saas/hrms/attendance/di/attendance_repository_container.dart' as attendance_rc;
import 'package:awign_saas/hrms/leaves/di/leaves_repository_container.dart' as leaves_rc;
import 'package:awign_saas/hrms/holidays/di/holiday_repository_container.dart' as holiday_rc;
import 'package:awign_saas/hrms/faq/di/faq_repository_container.dart' as faq_rc;
import 'package:awign_saas/hrms/regularisation/di/regularisation_repository_container.dart' as regularisation_rc;
import 'package:awign_saas/hrms/documents/di/document_repository_container.dart' as document_rc;
import 'package:awign_saas/hrms/rm/rm_attendance/di/rm_attendance_repository_container.dart' as rm_attendance_rc;
import 'package:awign_saas/hrms/rm/rm_reimbursements/di/rm_reimbursement_repository_container.dart' as rm_reimbursement_rc;
import 'package:awign_saas/hrms/rm/rm_leaves/di/rm_leaves_repository_container.dart' as rm_leaves_rc;
import 'package:awign_saas/hrms/rm/rm_regularisation/di/rm_regularisation_repository_container.dart' as rm_regularisation_rc;
import 'package:awign_saas/hrms/comp_off/di/comp_off_repository_container.dart' as comp_off_rc;
import 'package:awign_saas/hrms/rm/rm_comp_off/di/rm_comp_off_repository_container.dart' as rm_comp_off_rc;

void init() {
  /// Repositories
  auth_rc.init();
  reimbursements_rc.init();
  attendance_rc.init();
  leaves_rc.init();
  regularisation_rc.init();
  document_rc.init();
  rm_attendance_rc.init();
  rm_leaves_rc.init();
  holiday_rc.init();
  faq_rc.init();
  rm_reimbursement_rc.init();
  rm_regularisation_rc.init();
  comp_off_rc.init();
  rm_comp_off_rc.init();
}

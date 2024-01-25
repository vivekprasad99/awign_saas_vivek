import 'package:awign_saas/core/di/app_injection_container.dart';
import 'package:awign_saas/hrms/reimbursements/data/network/repository/reimbursement_remote_repository.dart';

void init() {
  /// Repositories
  sl.registerFactory<ReimbursementRemoteRepository>(() => ReimbursementRemoteRepository());
}
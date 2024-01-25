
import 'package:awign_saas/core/di/app_injection_container.dart';

import '../data/network/repository/rm_reimbursement_remote_repository.dart';

void init() {
  /// Repositories
  sl.registerFactory<RMReimbursementRemoteRepository>(() => RMReimbursementRemoteRepository());
}
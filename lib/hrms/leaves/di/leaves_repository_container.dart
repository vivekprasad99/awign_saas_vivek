import 'package:awign_saas/hrms/leaves/data/network/repository/leaves_remote_repository.dart';

import '../../../core/di/app_injection_container.dart';

void init() {
  /// Repositories
  sl.registerFactory<LeavesRemoteRepository>(() => LeavesRemoteRepository());
}

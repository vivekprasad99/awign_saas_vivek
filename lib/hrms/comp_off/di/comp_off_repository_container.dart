import 'package:awign_saas/hrms/comp_off/data/network/repository/comp_off_remote_repository.dart';

import '../../../core/di/app_injection_container.dart';

void init() {
  /// Repositories
  sl.registerFactory<CompOffRemoteRepository>(() => CompOffRemoteRepository());
}

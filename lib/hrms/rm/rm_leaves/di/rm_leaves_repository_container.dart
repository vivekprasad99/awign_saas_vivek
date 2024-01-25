import 'package:awign_saas/hrms/rm/rm_leaves/data/network/repository/rm_leaves_remote_repository.dart';

import '../../../../core/di/app_injection_container.dart';


void init() {
  /// Repositories
  sl.registerFactory<RMLeavesRemoteRepository>(() => RMLeavesRemoteRepository());
}

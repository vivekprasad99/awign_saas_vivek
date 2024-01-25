import 'package:awign_saas/hrms/rm/rm_comp_off/data/network/repository/rm_comp_off_remote_repository.dart';

import '../../../../core/di/app_injection_container.dart';


void init() {
  /// Repositories
  sl.registerFactory<RMCompOffRemoteRepository>(() => RMCompOffRemoteRepository());
}

import 'package:awign_saas/hrms/regularisation/data/network/repository/regularisation_remote_repository.dart';

import '../../../core/di/app_injection_container.dart';

void init() {
  /// Repositories
  sl.registerFactory<RegularisationRemoteRepository>(() => RegularisationRemoteRepository());
}

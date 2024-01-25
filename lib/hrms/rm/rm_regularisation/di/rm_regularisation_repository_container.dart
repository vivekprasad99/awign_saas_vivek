import '../../../../core/di/app_injection_container.dart';
import '../data/network/repository/rm_regularisation_remote_repository.dart';


void init() {
  /// Repositories
  sl.registerFactory<RMRegularisationRemoteRepository>(() => RMRegularisationRemoteRepository());
}

import '../../../core/di/app_injection_container.dart';
import '../data/network/repository/auth_remote_repository.dart';

void init() {
  /// Repositories
  sl.registerFactory<AuthRemoteRepository>(() => AuthRemoteRepository());
}

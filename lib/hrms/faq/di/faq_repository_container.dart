import 'package:awign_saas/core/di/app_injection_container.dart';
import 'package:awign_saas/hrms/faq/data/network/repository/faq_remote_repository.dart';

void init() {
  /// Repositories
  sl.registerFactory<FaqRemoteRepository>(() => FaqRemoteRepository());
}
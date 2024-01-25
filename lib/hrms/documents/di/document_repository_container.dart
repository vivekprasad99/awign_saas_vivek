import 'package:awign_saas/core/di/app_injection_container.dart';
import 'package:awign_saas/hrms/documents/data/network/repository/document_remote_repository.dart';

void init() {
  /// Repositories
  sl.registerFactory<DocumentRemoteRepository>(() => DocumentRemoteRepository());
}
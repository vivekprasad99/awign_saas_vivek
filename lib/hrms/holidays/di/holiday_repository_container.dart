
import 'package:awign_saas/core/di/app_injection_container.dart';
import 'package:awign_saas/hrms/holidays/data/network/repository/holiday_remote_repository.dart';

void init() {
  /// Repositories
  sl.registerFactory<HolidayRemoteRepository>(() => HolidayRemoteRepository());
}
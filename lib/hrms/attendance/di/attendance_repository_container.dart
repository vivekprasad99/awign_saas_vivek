import 'package:awign_saas/hrms/attendance/data/network/repository/attendance_remote_repository.dart';

import '../../../core/di/app_injection_container.dart';

void init() {
  /// Repositories
  sl.registerFactory<AttendanceRemoteRepository>(() => AttendanceRemoteRepository());
}

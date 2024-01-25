import '../../../../core/di/app_injection_container.dart';
import '../data/network/repository/rm_attendance_remote_repository.dart';


void init() {
  /// Repositories
  sl.registerFactory<RMAttendanceRemoteRepository>(() => RMAttendanceRemoteRepository());
}

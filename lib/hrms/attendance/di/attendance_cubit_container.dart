import '../../../core/di/app_injection_container.dart';
import '../features/attendance_dashboard/widget/mark_attendance/cubit/mark_attendance_cubit.dart';
import '../features/regularisation_alert/cubit/regularisation_alert_cubit.dart';

void init() {
  /// Cubits
  sl.registerFactory<MarkAttendanceCubit>(() => MarkAttendanceCubit(sl()));
  sl.registerFactory<RegularisationAlertCubit>(() => RegularisationAlertCubit(sl()));
}

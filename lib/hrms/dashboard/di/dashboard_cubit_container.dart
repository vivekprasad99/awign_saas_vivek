import 'package:awign_saas/hrms/dashboard/features/dashboard/cubit/dashboard_cubit.dart';

import '../../../core/di/app_injection_container.dart';

void init() {
  /// Cubits
  sl.registerSingleton<DashboardCubit>(DashboardCubit(),
      dispose: (dashboardCubit) => dashboardCubit.close());
}
import 'package:awign_saas/core/di/app_injection_container.dart';
import 'package:awign_saas/hrms/holidays/features/holidays_listing/cubit/holiday_listing_cubit.dart';

void init() {
  /// Cubits
  sl.registerFactory<HolidayListingCubit>(() => HolidayListingCubit(sl()));
}
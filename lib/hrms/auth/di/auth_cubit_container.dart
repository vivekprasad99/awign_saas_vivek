import '../../../core/di/app_injection_container.dart';
import '../features/splash/cubit/splash_cubit.dart';

void init() {
  /// Cubits
  sl.registerFactory<SplashCubit>(() => SplashCubit(sl()));
}

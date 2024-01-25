import 'package:awign_saas/hrms/faq/features/faq/cubit/faq_cubit.dart';
import '../../../core/di/app_injection_container.dart';

void init() {
  /// Cubits
  sl.registerFactory<FaqCubit>(() => FaqCubit(sl()));
}
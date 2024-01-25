
import 'package:awign_saas/core/di/app_injection_container.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements/cubit/reimbursement_cubit.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements_detail/cubit/reimbursement_detail_cubit.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements_form/cubit/reimbursement_form_cubit.dart';

void init() {
  /// Cubits
  sl.registerFactory<ReimbursementCubit>(() => ReimbursementCubit(sl()));
  sl.registerFactory<ReimbursementFormCubit>(() => ReimbursementFormCubit(sl()));
  sl.registerFactory<ReimbursementDetailCubit>(() => ReimbursementDetailCubit(sl()));
}

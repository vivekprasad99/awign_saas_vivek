import 'package:awign_saas/core/di/app_injection_container.dart';
import 'package:awign_saas/hrms/documents/features/company_document/cubit/company_document_cubit.dart';

void init() {
  /// Cubits
  sl.registerFactory<CompanyDocumentCubit>(() => CompanyDocumentCubit(sl()));
}

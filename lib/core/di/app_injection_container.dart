import 'package:awign_saas/core/di/cubit_container/cubit_container.dart' as cubit_container;
import 'package:awign_saas/core/di/repository_container/repository_container.dart' as repository_container;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import '../deep_link/cubit/deep_link_cubit.dart';
import '../router/router.dart';

final sl = GetIt.instance;

void init() {
  /* Data Sources */
  // dsc.init();

  /// Repositories
  repository_container.init();

  /// Cubits
  cubit_container.init();

  /* Services */
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<DeepLinkCubit>(() => DeepLinkCubit());

  /* Navigation */
  sl.registerSingleton<MRouter>(MRouter(), dispose: (router) {
    router.closeStream();
    router.closeLocalStream();
  });
}

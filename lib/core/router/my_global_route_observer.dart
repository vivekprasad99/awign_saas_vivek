import 'package:awign_saas/core/router/router.dart';
import 'package:flutter/material.dart';

import '../di/app_injection_container.dart';

class MyGlobalRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route? route, Route? previousRoute) {
    super.didPush(route!, previousRoute);
    sl<MRouter>().updateRoute(route.settings.name ?? '');
  }

  @override
  void didPop(Route? route, Route? previousRoute) {
    super.didPop(route!, previousRoute);
    sl<MRouter>().updateRoute(previousRoute?.settings.name ?? '');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    sl<MRouter>().updateRoute(newRoute?.settings.name ?? '');
  }

  @override
  void didRemove(Route? route, Route? previousRoute) {
    super.didRemove(route!, previousRoute);
    sl<MRouter>().updateRoute(previousRoute?.settings.name ?? '');
  }
}

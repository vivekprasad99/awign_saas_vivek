import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/hrms/dashboard/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:awign_saas/hrms/dashboard/features/dashboard/widget/bottom_navigation/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/app_injection_container.dart';
import '../../../../../core/router/my_local_route_observer.dart';
import '../../../../../core/router/router.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import '../cubit/dashboard_state.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      buildWhen: (previousState, state) {
        return false;
      },
      builder: (context, state) {
        return AppScaffold(
          bottomPadding: 0,
          body: buildWidgetForMobile(context),
          bottomNavigationBar: buildBottomNavigation(state),
        );
      },
    );
  }

  Widget buildBottomNavigation(DashboardState state) {
    if(!state.navigationItemList.isNullOrEmpty) {
      return BottomNavigationWidget(state.navigationItemList!);
    } else {
      return const SizedBox();
    }
  }

  Widget buildWidgetForMobile(BuildContext context) {
    return Navigator(
      key: MRouter.localNavigatorKey,
      initialRoute: MRouter.homeWidget,
      onGenerateRoute: sl<MRouter>().onGenerateRoute,
      observers: [MyLocalRouteObserver()],
    );
  }
}

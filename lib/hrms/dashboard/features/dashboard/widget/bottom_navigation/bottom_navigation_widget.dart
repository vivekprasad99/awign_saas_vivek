import 'package:awign_saas/hrms/dashboard/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:awign_saas/hrms/dashboard/features/dashboard/cubit/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/data/model/navigation_item.dart';
import '../../../../../../core/router/router.dart';

class BottomNavigationWidget extends StatelessWidget {
  final List<NavigationItem> navigationItemList;

  const BottomNavigationWidget(this.navigationItemList, {super.key});

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = navigationItemList
        .map((e) => BottomNavigationBarItem(
            icon: SvgPicture.asset(
              e.iconUrl ?? '',
            ),
            activeIcon: SvgPicture.asset(
              e.activeIconUrl ?? '',
              color: Get.theme.colorScheme.primary,
            ),
            label: e.text))
        .toList();
    return BlocBuilder<DashboardCubit, DashboardState>(
      buildWhen: (previousState, state) {
        return previousState.currentTabIndex != state.currentTabIndex;
      },
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: items,
          onTap: (index) {
            if(index != state.currentTabIndex) {
              MRouter.pushReplacementNamed(
                  navigationItemList[index].navigateTo ?? MRouter.homeWidget,
                  isLocal: true);
            }
          },
          currentIndex: state.currentTabIndex ?? 0,
        );
      },
    );
  }
}

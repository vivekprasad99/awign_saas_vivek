import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/data/model/navigation_item.dart';
import '../../../../../core/di/app_injection_container.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState(currentTabIndex: 0)) {
    sl<MRouter>().currentLocalRouteStream.listen((route) {
      int? currentTabIndex = state.navigationItemList?.indexWhere((element) => (element.navigateTo ?? '').contains(route));
      if(!isClosed) {
        emit(state.copyWith(currentTabIndex: currentTabIndex == -1 ? 0 : currentTabIndex));
      }
    });
    loadBottomNavigation();
  }

  loadBottomNavigation() {
    List<NavigationItem> navigationItemList = [
      NavigationItem(
        iconUrl: 'assets/images/ic_home_unselected.svg',
        activeIconUrl: 'assets/images/ic_home_selected.svg',
        text: 'home'.tr,
        navigateTo: MRouter.homeWidget,
      ),
      NavigationItem(
        iconUrl: 'assets/images/ic_notification_unselected.svg',
        activeIconUrl: 'assets/images/ic_notification_selected.svg',
        text: 'notifications'.tr,
        navigateTo: MRouter.notificationsWidget,
      ),
      NavigationItem(
        iconUrl: 'assets/images/ic_profile_unselected.svg',
        activeIconUrl: 'assets/images/ic_profile_selected.svg',
        text: 'profile'.tr,
        navigateTo: MRouter.profileWidget,
      ),
    ];
    if(UserPreferences.getInstance().getCurrentUser()?.isManager ?? false) {
      navigationItemList.insert(2, NavigationItem(
        iconUrl: 'assets/images/ic_settings_unselected.svg',
        activeIconUrl: 'assets/images/ic_settings_selected.svg',
        text: 'manager'.tr,
        navigateTo: MRouter.rmDashboardWidget,
      ));
    }
    if(!isClosed) {
      emit(state.copyWith(navigationItemList: navigationItemList));
    }
  }
}

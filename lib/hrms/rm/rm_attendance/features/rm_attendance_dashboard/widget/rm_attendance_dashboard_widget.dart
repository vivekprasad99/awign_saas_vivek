import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/employee_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/data/model/ui_state.dart';
import '../../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../../core/widget/dialog/loading/app_circular_progress_indicator.dart';
import '../../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../../../attendance/features/attendance_dashboard/widget/billing_cycle/cubit/billing_cycle_cubit.dart';
import '../../../../../attendance/features/attendance_dashboard/widget/billing_cycle/widget/billing_cycle_widget.dart';
import '../cubit/rm_attendance_dashboard_cubit.dart';
import '../cubit/rm_attendance_dashboard_state.dart';
import 'tile/employee_attendance_tile.dart';

class RMAttendanceDashboardWidget extends StatelessWidget {

  const RMAttendanceDashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<RMAttendanceDashboardCubit, RMAttendanceDashboardState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {

      },
      buildWhen: (context, state) {
        return state.uiState?.event == Event.reloadWidget;
      },
      builder: (context, state) {
        return AppScaffold(
          body: SafeArea(
            child: Column(
              children: [
                DefaultAppBar(
                    isBackIconVisible: true,
                    title: 'attendance'.tr),
                Expanded(
                  child: InternetSensitive(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimens.padding_16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(child: buildSelectBillingCycleWidgets(context)),
                                // SearchIconWidget(onTap: () {}),
                                // FilterIconWidget(onTap: () {
                                //   MRouter.pushNamed(MRouter.rmAttendanceFiltersWidget);
                                // }),
                              ],
                            ),
                          ),
                          const SizedBox(height: Dimens.padding_16),
                          buildAttendanceStatusTabBar(context),
                          buildAttendanceList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSelectBillingCycleWidgets(BuildContext context) {
    return BlocProvider(
      create: (context) => BillingCycleCubit(),
      child: BillingCycleWidget(label: 'select_billing_cycle'.tr, onChanged: (selectedValue) {
        context.read<RMAttendanceDashboardCubit>().updateSelectedBillingCycle(selectedValue);
      }),
    );
  }

  Widget buildAttendanceStatusTabBar(BuildContext context) {
    return BlocBuilder<RMAttendanceDashboardCubit, RMAttendanceDashboardState>(
      buildWhen: (prev, cur) {
        return (prev.absentList != cur.absentList || prev.presentList != cur.presentList || prev.leaveList != cur.leaveList);
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  height: Dimens.tabBarHeight_40,
                  decoration: BoxDecoration(
                    color: Get.theme.getCustomColor(context).secondary1100!,
                    borderRadius: BorderRadius.circular(Dimens.radius_6),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: Get.theme.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(Dimens.radius_6),
                      border: Border.all(color: Get.theme.getCustomColor(context).secondary1300!),
                    ),
                    labelColor: Get.theme.getCustomColor(context).backgroundgrey900!,
                    labelPadding: EdgeInsets.zero,
                    labelStyle: Get.textTheme.labelLarge?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey900, fontWeight: FontWeight.w700),
                    unselectedLabelStyle: Get.textTheme.labelLarge?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey900),
                    onTap: (index) {
                      context.read<RMAttendanceDashboardCubit>().updateCurrentTabIndex(index);
                    },
                    tabs: [
                      buildTab('absent'.tr, '${state.absentList?.length ?? 0}', Get.theme.colorScheme.error),
                      buildTab('leave'.tr, '${state.leaveList?.length ?? 0}', Get.theme.getCustomColor(context).link400!),
                      buildTab('present'.tr, '${state.presentList?.length ?? 0}', Get.theme.getCustomColor(context).success300!),
                      // Tab(
                      //     child: Text('all'.tr,
                      //     )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTab(String tabText, String strCount, Color bgColor) {
    return Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tabText,
            ),
            const SizedBox(width: Dimens.padding_4),
            buildAttendanceListCountWidget(strCount, bgColor),
          ],
        ));
  }

  Widget buildAttendanceListCountWidget(String count, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(Dimens.padding_4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(Dimens.radius_16),
      ),
      constraints: const BoxConstraints(
        minWidth: Dimens.badgeIconWidth_24,
        minHeight: Dimens.badgeIconHeight_16,
      ),
      child: Text(
        count,
        style: Get.textTheme.labelSmall?.copyWith(fontSize: Dimens.font_10, color: Get.theme.colorScheme.background),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildAttendanceList() {
    return BlocBuilder<RMAttendanceDashboardCubit, RMAttendanceDashboardState>(
      buildWhen: (preState, curState) {
        return (preState.currentTabIndex != curState.currentTabIndex || preState.isLoading != curState.isLoading);
      },
      builder: (context, state) {
        List<EmployeeAttendance>? attendanceList = [];
        switch(state.currentTabIndex) {
          case 0:
            attendanceList = state.absentList;
          case 1:
            attendanceList = state.leaveList;
          case 2:
            attendanceList = state.presentList;
          case 3:
            attendanceList = state.allAttendanceList;
          default:
            return const SizedBox();
        }
        if(state.isLoading ?? false) {
          return const Padding(
            padding: EdgeInsets.all(Dimens.padding_150),
            child: AppCircularProgressIndicator(),
          );
        } else if(!attendanceList.isNullOrEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
            child: ListView.separated(
              itemCount: attendanceList!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: Dimens.padding_16),
              itemBuilder: (context, i) {
                return EmployeeAttendanceTile(employeeAttendance: attendanceList![i], onEmployeeAttendanceTap: _onEmployeeAttendanceTap);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: Dimens.padding_12);
              },
            ),
          );
        } else {
          return buildEmptyWidgets(context);
        }
      },
    );
  }

  _onEmployeeAttendanceTap(BuildContext context, EmployeeAttendance employeeAttendance) async {
      MRouter.pushNamed(MRouter.rmAttendanceDetailWidget, arguments: employeeAttendance);
  }

  Widget buildEmptyWidgets(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.padding_36),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/ic_no_data_found.svg',
            ),
            const SizedBox(height: Dimens.padding_16),
            Text('attendance_not_available'.tr, style: Get.textTheme.titleMedium?.copyWith(color:
            Theme.of(context).getCustomColor(context).secondary1300, fontSize: Dimens.font_18),),
          ],
        ),
      ),
    );
  }
}

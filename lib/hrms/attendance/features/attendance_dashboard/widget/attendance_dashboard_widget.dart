import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:awign_saas/hrms/attendance/data/model/attendance_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/di/app_injection_container.dart';
import '../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../core/widget/dialog/loading/app_circular_progress_indicator.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../../../core/widget/theme/theme_manager.dart';
import '../../../../leaves/data/model/leaves_arguments.dart';
import '../../../../regularisation/data/model/request_regularize_widget_argument.dart';
import '../cubit/attendance_dashboard_cubit.dart';
import '../cubit/attendance_dashboard_state.dart';
import 'billing_cycle/cubit/billing_cycle_cubit.dart';
import 'billing_cycle/widget/billing_cycle_widget.dart';
import 'dialog/attendance_resolve_dialog.dart';
import 'mark_attendance/cubit/mark_attendance_cubit.dart';
import 'mark_attendance/widget/mark_attendance_widget.dart';
import 'tile/attendance_tile.dart';

class AttendanceDashboardWidget extends StatelessWidget {
  final BillingCycleCubit billingCycleCubit = BillingCycleCubit();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  AttendanceDashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<AttendanceDashboardCubit, AttendanceDashboardState>(
      listenWhen: (previous, current) {
        return (previous.uiState != current.uiState || previous.isLoading != current.isLoading);
      },
      listener: (context, state) {
        if (!(state.isLoading ?? false)) {
          _refreshController.refreshCompleted();
        }
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
                    child: SmartRefresher(
                      enablePullDown: true,
                      header: const MaterialClassicHeader(),
                      controller: _refreshController,
                      onRefresh: () {
                        _refreshWidget(context);
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildPunchInPunchOutContainer(),
                            const SizedBox(height: Dimens.padding_24),
                            buildSelectBillingCycleWidgets(context),
                            const SizedBox(height: Dimens.padding_16),
                            buildAttendanceStatusTabBar(context),
                            buildAttendanceList(),
                          ],
                        ),
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

  Widget buildPunchInPunchOutContainer() {
    return BlocProvider(
      create: (context) => sl<MarkAttendanceCubit>(),
      child: const MarkAttendanceWidget(),
    );
  }

  Widget buildSelectBillingCycleWidgets(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
      child: BlocProvider(
        create: (context) => billingCycleCubit,
        child: BillingCycleWidget(label: 'select_billing_cycle'.tr, onChanged: (selectedValue) {
          context.read<AttendanceDashboardCubit>().updateSelectedBillingCycle(selectedValue);
        }),
      ),
    );
  }

  Widget buildAttendanceStatusTabBar(BuildContext context) {
    return BlocBuilder<AttendanceDashboardCubit, AttendanceDashboardState>(
      buildWhen: (prev, cur) {
        return (prev.absentList != cur.absentList || prev.presentList != cur.presentList || prev.leaveList != cur.leaveList);
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
          child: DefaultTabController(
            length: 4,
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
                      context.read<AttendanceDashboardCubit>().updateCurrentTabIndex(index);
                    },
                    tabs: [
                      buildTab('absent'.tr, '${state.absentList?.length ?? 0}', Get.theme.colorScheme.error),
                      buildTab('leave'.tr, '${state.leaveList?.length ?? 0}', Get.theme.getCustomColor(context).link400!),
                      buildTab('present'.tr, '${state.presentList?.length ?? 0}', Get.theme.getCustomColor(context).success300!),
                      Tab(child: Text('all'.tr)),
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
    return BlocBuilder<AttendanceDashboardCubit, AttendanceDashboardState>(
      buildWhen: (preState, curState) {
        return (preState.currentTabIndex != curState.currentTabIndex
            || preState.isLoading != curState.isLoading);
      },
      builder: (context, state) {
        List<AttendanceDetails>? attendanceList = [];
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
            attendanceList = [];
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
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: Dimens.padding_16),
              itemBuilder: (context, i) {
                return AttendanceTile(attendance: attendanceList![i],
                    currentBillingCycle: billingCycleCubit.getCurrentBillingCycle(), onAttendanceAction: _onAttendanceTileAction);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: Dimens.padding_12);
              },
            ),
          );
        } else {
          return buildEmptyWidgets(context, state.currentTabIndex);
        }
      },
    );
  }

  _onAttendanceTileAction(BuildContext context, AttendanceDetails attendance, AttendanceTileAction attendanceTileAction,
      {AttendanceStatusEntity? attendanceStatusEntity}) async {
    switch(attendanceTileAction) {
      case AttendanceTileAction.resolve:
        showResolveAttendanceDialog(context, onRegulariseTap: () {
          _onRegulariseTap(context, attendance, attendanceStatusEntity: attendanceStatusEntity);
        }, onMarkAsLeaveTap: () async {
          _onMarkAsLeaveTap(context, attendance, attendanceStatusEntity: attendanceStatusEntity);
        });
        break;
    }
  }

  _onMarkAsLeaveTap(BuildContext context, AttendanceDetails attendance, {AttendanceStatusEntity? attendanceStatusEntity}) async {
    LeavesArgument leavesArgument = LeavesArgument(attendanceDetails: attendance, attendanceStatusEntity: attendanceStatusEntity);
    bool? doRefresh = await MRouter.pushNamed(MRouter.applyLeaveWidget, arguments: leavesArgument);
    if(doRefresh ?? false) {
      _refreshWidget(context);
    }
  }

  _onRegulariseTap(BuildContext context, AttendanceDetails attendance, {AttendanceStatusEntity? attendanceStatusEntity}) async {
    RequestRegularizeWidgetArgument requestRegularizeWidgetArgument = RequestRegularizeWidgetArgument(attendanceDetails: attendance, attendanceStatusEntity: attendanceStatusEntity);
    bool? doRefresh = await MRouter.pushNamed(MRouter.requestRegulariseWidget, arguments: requestRegularizeWidgetArgument);
    if(doRefresh ?? false) {
      _refreshWidget(context);
    }
  }

  _refreshWidget(BuildContext context) {
    context.read<AttendanceDashboardCubit>().getAttendanceStatusByDateRange();
  }

  Widget buildEmptyWidgets(BuildContext context, int? currentTabIndex) {
    String message = 'attendance_not_available'.tr;
    if(currentTabIndex == 1) {
      message = 'no_approved_leave_application_yet'.tr;
    }
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.padding_36),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/ic_no_data_found.svg',
            ),
            const SizedBox(height: Dimens.padding_16),
            Text(message, style: Get.textTheme.titleMedium?.copyWith(color:
            Theme.of(context).getCustomColor(context).secondary1300, fontSize: Dimens.font_18),),
          ],
        ),
      ),
    );
  }
}

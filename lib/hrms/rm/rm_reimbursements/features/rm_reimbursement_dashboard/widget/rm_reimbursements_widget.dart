import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/app_bar/default_app_bar.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/billing_cycle/cubit/billing_cycle_cubit.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/billing_cycle/widget/billing_cycle_widget.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/data/model/rm_reimbursement_search_response.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/features/rm_reimbursement_dashboard/cubit/rm_reimbursement_dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../cubit/rm_reimbursement_dashboard_state.dart';
import 'tile/rmreimbursement_tile.dart';

class RMReimbursementsWidget extends StatelessWidget {
  const RMReimbursementsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidgetsForMobile(context);
  }

  Widget buildWidgetsForMobile(BuildContext context) {
    return BlocConsumer<RmReimbursementDashboardCubit,
        RmReimbursementDashboardState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {},
      buildWhen: (context, state) {
        return state.uiState?.event == Event.reloadWidget;
      },
      builder: (context, state) {
        return AppScaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultAppBar(
                  isBackIconVisible: true,
                  title: 'reimbursements'.tr,
                ),
                Expanded(
                    child: InternetSensitive(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: Dimens.padding_16,
                                right: Dimens.padding_16,
                                top: Dimens.padding_16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child:
                                          buildSelectBillingCycleWidgets(context),
                                    ),
                                    // SearchIconWidget(onTap: () {}),
                                    // CalendarIconWidget(onTap: () {}),
                                  ],
                                ),
                                const SizedBox(height: Dimens.padding_16),
                                buildTabs(context),
                                const SizedBox(height: Dimens.padding_16),
                                buildReimbursementList(),
                                const SizedBox(height: Dimens.padding_16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
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
      child: BillingCycleWidget(
          label: 'select_billing_cycle'.tr,
          onChanged: (selectedValue) {
            context
                .read<RmReimbursementDashboardCubit>()
                .updateSelectedBillingCycle(selectedValue);
          }),
    );
  }

  Widget buildTabs(BuildContext context) {
    return BlocBuilder<RmReimbursementDashboardCubit,
        RmReimbursementDashboardState>(
      buildWhen: (preState, curState) {
        return (preState.pendingList != curState.pendingList ||
            preState.approvedList != curState.approvedList ||
            preState.rejectedList != curState.rejectedList);
      },
      builder: (context, state) {
          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  height: Dimens.tabBarHeight_40,
                  decoration: BoxDecoration(
                    color: Get.theme
                        .getCustomColor(context)
                        .secondary1100!,
                    borderRadius: BorderRadius.circular(Dimens.radius_6),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: Get.theme.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(Dimens.radius_6),
                      border: Border.all(
                          color:
                          Get.theme
                              .getCustomColor(context)
                              .secondary1300!),
                    ),
                    labelColor:
                    Get.theme
                        .getCustomColor(context)
                        .backgroundgrey900!,
                    labelPadding: EdgeInsets.zero,
                    labelStyle: Get.textTheme.labelLarge?.copyWith(
                        color:
                        Get.theme
                            .getCustomColor(context)
                            .backgroundgrey900,
                        fontWeight: FontWeight.w700),
                    unselectedLabelStyle: Get.textTheme.labelLarge?.copyWith(
                        color:
                        Get.theme
                            .getCustomColor(context)
                            .backgroundgrey900),
                    onTap: (index) {
                      context
                          .read<RmReimbursementDashboardCubit>()
                          .updateCurrentTabIndex(index);
                    },
                    tabs: [
                      buildTab(
                          'pending'.tr,
                          '${state.pendingList?.length ?? 0}',
                          Get.theme.getCustomColor(context).warning250!),
                      buildTab(
                          'approved'.tr,
                          '${state.approvedList?.length ?? 0}',
                          Get.theme.getCustomColor(context).success300!),
                      buildTab(
                          'rejected'.tr,
                          '${state.rejectedList?.length ?? 0}',
                          Get.theme.getCustomColor(context).error300!),
                      // Tab(
                      //     child: Text(
                      //       'all'.tr,
                      //     )),
                    ],
                  ),
                ),
              ],
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
            buildReimbursementListCountWidget(strCount, bgColor),
          ],
        ));
  }

  Widget buildReimbursementListCountWidget(String count, Color bgColor) {
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
        style: Get.textTheme.labelSmall?.copyWith(
            fontSize: Dimens.font_10, color: Get.theme.colorScheme.background),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildReimbursementList() {
    return BlocBuilder<RmReimbursementDashboardCubit,
        RmReimbursementDashboardState>(
      buildWhen: (preState, curState) {
        return (preState.currentTabIndex != curState.currentTabIndex || preState.isLoading != curState.isLoading);
      },
      builder: (context, state) {
        List<Reimbursements>? reimbursementList = [];
        switch (state.currentTabIndex) {
          case 0:
            reimbursementList = state.pendingList;
          case 1:
            reimbursementList = state.approvedList;
          case 2:
            reimbursementList = state.rejectedList;
          case 3:
            reimbursementList = state.allList;
          default:
            return const SizedBox();
        }
        if (state.isLoading ?? false) {
          return const Padding(
            padding: EdgeInsets.all(Dimens.padding_150),
            child: AppCircularProgressIndicator(),
          );
        } else if (reimbursementList != null) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: reimbursementList.length!,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return MyInkWell(
                  onTap: () async {
                    bool? isRefresh = await MRouter.pushNamed(
                        MRouter.rmReimbursementsDetailWidget,
                        arguments: reimbursementList![i].uuid);
                    if (isRefresh ?? false) {
                      context.read<RmReimbursementDashboardCubit>().searchReimbursement();
                    }
                  },
                  child: RmReimbursementTile(
                    reimbursement: reimbursementList![i],
                    index: i,
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: Dimens.padding_16);
            },
          );
        } else {
          return buildEmptyWidgets(Get.context!);
        }
      },
    );
  }

  Widget buildEmptyWidgets(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.padding_36),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset('assets/images/ic_no_claim_request.svg'),
            const SizedBox(height: Dimens.padding_16),
            Text(
              "no_claim_request_found".tr,
              style: Get.textTheme.titleMedium?.copyWith(
                  color: Theme.of(context)
                      .getCustomColor(context)
                      .secondary1300,
                  fontSize: Dimens.font_18),
            ),
          ],
        ),
      ),
    );
  }
}

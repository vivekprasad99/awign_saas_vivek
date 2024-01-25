import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/billing_cycle/cubit/billing_cycle_cubit.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/billing_cycle/widget/billing_cycle_widget.dart';
import 'package:awign_saas/hrms/leaves/data/model/leaves_arguments.dart';
import 'package:awign_saas/hrms/leaves/features/leaves_listing/cubit/leaves_listing_cubit.dart';
import 'package:awign_saas/hrms/leaves/features/leaves_listing/cubit/leaves_listing_state.dart';
import 'package:awign_saas/hrms/leaves/features/leaves_listing/widget/tile/leave_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../core/widget/buttons/raised_rect_button.dart';
import '../../../../../core/widget/divider/v_divider.dart';
import '../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../data/model/leave.dart';

class LeavesListingWidget extends StatelessWidget {
  const LeavesListingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LeavesListingCubit>().getLeaveBalance();
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<LeavesListingCubit, LeavesListingState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {
        if(state.uiState != null && state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
          Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
        }
      },
      buildWhen: (prev, state) {
        return false;
      },
      builder: (context, state) {
        return AppScaffold(
          body: SafeArea(
            child: Column(
              children: [
                DefaultAppBar(
                  isBackIconVisible: true,
                  title: 'leaves'.tr,
                ),
                Expanded(
                  child: InternetSensitive(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.padding_16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: Dimens.padding_16),
                                  buildLeaveBalanceContainer(context),
                                  const SizedBox(height: Dimens.padding_16),
                                  buildSelectBillingCycleWidgets(context),
                                  const SizedBox(height: Dimens.padding_16),
                                  buildLeaveTypeTabBar(context),
                                  buildLeaveList(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        buildApplyLeaveButton(),
                      ],
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

  Widget buildLeaveBalanceContainer(BuildContext context) {
    return BlocBuilder<LeavesListingCubit, LeavesListingState>(
      buildWhen: (pre, cur) {
        return (pre.leaveBalanceResponse != cur.leaveBalanceResponse || pre.isLeaveBalanceLoading != cur.isLeaveBalanceLoading);
      },
      builder: (context, state) {
        if(state.isLeaveBalanceLoading ?? false) {
          return const SizedBox();
        } else if(state.leaveBalanceResponse != null && state.leaveBalanceResponse!.leaves != null && state.leaveBalanceResponse!.leaves!.isNotEmpty) {
          return Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.radius_8),
              border: Border.all(
                width: Dimens.border_1,
                color: Get.theme.colorScheme.primary,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAnnualBalanceLeavesHeaderWidget(),
                buildLeaveBalanceList(state),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildAnnualBalanceLeavesHeaderWidget() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimens.radius_8),
              topRight: Radius.circular(Dimens.radius_8)),
          color: Get.theme.colorScheme.primary),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimens.padding_20, Dimens.padding_16,
            Dimens.padding_20, Dimens.padding_16),
        child: Row(
          children: [
            Text(
              'leave_balance'.tr,
              style: Get.textTheme.titleMedium?.copyWith(
                  color: Get.theme.colorScheme.background,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLeaveBalanceList(LeavesListingState state) {
    return Expanded(
      child: ListView.separated(
        itemCount: state.leaveBalanceResponse!.leaves!.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16, vertical: Dimens.padding_16),
        itemBuilder: (context, i) {
          List<MapEntry<String, dynamic>> leaveBalance = state.leaveBalanceResponse!.leaves!.entries.toList();
          return buildLeaveBalanceTile(context, leaveBalance[i].key, leaveBalance[i].value);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.padding_12, 0, Dimens.padding_12, 0),
            child: VDivider(
                dividerColor: Get.theme.colorScheme.inversePrimary),
          );
        },
      ),
    );
  }

  Widget buildLeaveBalanceTile(
      BuildContext context, String leaveTypeText, double leaveCount) {
    return SizedBox(
      width: 75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            leaveTypeText.toTitleCase(),
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.labelMedium?.copyWith(
                color: Theme.of(context)
                    .extension<CustomColors>()!
                    .sourceBackgroundgrey700),
          ),
          const SizedBox(height: Dimens.padding_4),
          Text(
            '$leaveCount',
            style: Get.textTheme.titleMedium?.copyWith(
                color: Theme.of(context)
                    .extension<CustomColors>()!
                    .backgroundblack,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget buildSelectBillingCycleWidgets(BuildContext context) {
    return BlocProvider(
      create: (context) => BillingCycleCubit(),
      child: BillingCycleWidget(label: 'select_billing_cycle'.tr, isShowNextBillingCycle: true, onChanged: (selectedValue) {
        context.read<LeavesListingCubit>().updateSelectedBillingCycle(selectedValue);
      }),
    );
  }

  Widget buildLeaveTypeTabBar(BuildContext context) {
    return DefaultTabController(
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
                border: Border.all(
                    color: Get.theme.getCustomColor(context).secondary1300!),
              ),
              labelColor: Get.theme.getCustomColor(context).backgroundgrey900!,
              labelPadding: EdgeInsets.zero,
              labelStyle: Get.textTheme.labelLarge?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey900, fontWeight: FontWeight.w700),
              unselectedLabelStyle: Get.textTheme.labelLarge?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey900),
              onTap: (index) {
                context.read<LeavesListingCubit>().searchLeaves(index);
              },
              tabs: [
                Tab(
                    child: Text(
                  'pending'.tr,
                )),
                Tab(
                    child: Text(
                  'approved'.tr,
                )),
                Tab(
                    child: Text(
                  'rejected'.tr,
                )),
                Tab(
                    child: Text(
                  'cancelled'.tr,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLeaveList() {
    return BlocBuilder<LeavesListingCubit, LeavesListingState>(
      buildWhen: (preState, curState) {
        return (preState.isSearchLeavesLoading != curState.isSearchLeavesLoading);
      },
      builder: (context, state) {
        if(state.isSearchLeavesLoading ?? false) {
          return const Padding(
            padding: EdgeInsets.all(Dimens.padding_150),
            child: AppCircularProgressIndicator(),
          );
        } else if(!state.leaves.isNullOrEmpty) {
          return ListView.separated(
            itemCount: state.leaves!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: Dimens.padding_16),
            itemBuilder: (context, i) {
              return LeaveTile(leave: state.leaves![i], onLeaveTap: _onLeaveTap);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: Dimens.padding_12);
            },
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: Dimens.padding_36),
            child: Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_no_data_found.svg',
                  ),
                  const SizedBox(height: Dimens.padding_16),
                  Text('no_leave_application_yet'.tr, style: Get.textTheme.titleMedium?.copyWith(color:
                    Theme.of(context).getCustomColor(context).secondary1300, fontSize: Dimens.font_18),),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  _onLeaveTap(BuildContext context, Leave leave) async {
    bool? isRefresh = await MRouter.pushNamed(MRouter.leaveDetailsWidget, arguments: leave.id);
    if(isRefresh ?? false) {
      _refreshWidget(context, null);
    }
  }

  Widget buildApplyLeaveButton() {
    return BlocBuilder<LeavesListingCubit, LeavesListingState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.padding_16),
          child: RaisedRectButton(
            buttonState: state.buttonState,
            text: 'apply_leave'.tr,
            onPressed: () async {
              LeavesArgument leavesArgument = LeavesArgument();
              bool? doRefresh = await MRouter.pushNamed(MRouter.applyLeaveWidget,arguments: leavesArgument);
              if(doRefresh ?? false) {
                _refreshWidget(context, null);
              }
            },
          ),
        );
      },
    );
  }

  _refreshWidget(BuildContext context, int? currentTabIndex) {
    context.read<LeavesListingCubit>().searchLeaves(currentTabIndex);
    context.read<LeavesListingCubit>().getLeaveBalance();
  }
}

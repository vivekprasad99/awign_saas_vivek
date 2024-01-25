import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/billing_cycle/cubit/billing_cycle_cubit.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/billing_cycle/widget/billing_cycle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/data/model/ui_state.dart';
import '../../../../../../core/utils/helper.dart';
import '../../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../../../leaves/data/model/leave.dart';
import '../cubit/rm_leave_listing_cubit.dart';
import '../cubit/rm_leave_listing_state.dart';
import 'tile/rm_leave_tile.dart';

class RMLeaveListingWidget extends StatelessWidget {
  const RMLeaveListingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<RMLeaveListingCubit, RMLeaveListingState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {
        if(state.uiState != null && state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
          Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
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
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(child: buildSelectBillingCycleWidgets(context)),
                                      // SearchIconWidget(onTap: () {}),
                                      // CalendarIconWidget(onTap: () {}),
                                    ],
                                  ),
                                  const SizedBox(height: Dimens.padding_16),
                                  buildLeaveTypeTabBar(context),
                                  buildLeaveList(),
                                ],
                              ),
                            ),
                          ),
                        ),
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

  Widget buildSelectBillingCycleWidgets(BuildContext context) {
    return BlocProvider(
      create: (context) => BillingCycleCubit(),
      child: BillingCycleWidget(label: 'select_billing_cycle'.tr, isShowNextBillingCycle: true, onChanged: (selectedValue) {
        context.read<RMLeaveListingCubit>().updateSelectedBillingCycle(selectedValue);
      }),
    );
  }

  Widget buildLeaveTypeTabBar(BuildContext context) {
    return DefaultTabController(
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
                border: Border.all(
                    color: Get.theme.getCustomColor(context).secondary1300!),
              ),
              labelColor: Get.theme.getCustomColor(context).backgroundgrey900!,
              labelPadding: EdgeInsets.zero,
              labelStyle: Get.textTheme.labelLarge?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey900, fontWeight: FontWeight.w700),
              unselectedLabelStyle: Get.textTheme.labelLarge?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey900),
              onTap: (index) {
                context.read<RMLeaveListingCubit>().searchLeaves(index);
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
  }

  Widget buildLeaveList() {
    return BlocBuilder<RMLeaveListingCubit, RMLeaveListingState>(
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
              return RMLeaveTile(leave: state.leaves![i], onLeaveTap: _onLeaveTap);
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
                  Text('no_leave_request_found'.tr, style: Get.textTheme.titleMedium?.copyWith(color:
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
    bool? isRefresh = await MRouter.pushNamed(MRouter.rmLeaveDetailsWidget, arguments: leave);
    if(isRefresh ?? false) {
      _refreshWidget(context);
    }
  }

  _refreshWidget(BuildContext context) {
    context.read<RMLeaveListingCubit>().searchLeaves(null);
  }
}

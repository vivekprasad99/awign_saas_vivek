import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/billing_cycle/cubit/billing_cycle_cubit.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/billing_cycle/widget/billing_cycle_widget.dart';
import 'package:awign_saas/hrms/comp_off/feature/comp_off_listing/cubit/comp_off_listing_cubit.dart';
import 'package:awign_saas/hrms/comp_off/feature/comp_off_listing/cubit/comp_off_listing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../core/widget/buttons/raised_rect_button.dart';
import '../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../data/model/comp_off.dart';
import 'tile/comp_off_tile.dart';

class CompOffListingWidget extends StatelessWidget {
  const CompOffListingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CompOffListingCubit>().getLeaveBalance();
    context.read<CompOffListingCubit>().getEmployeeCompOffList();
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<CompOffListingCubit, CompOffListingState>(
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
                  title: 'comp_off'.tr,
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
                                  buildCompOffBalanceContainer(context),
                                  const SizedBox(height: Dimens.padding_16),
                                  buildSelectBillingCycleWidgets(context),
                                  const SizedBox(height: Dimens.padding_16),
                                  buildCompOffTabBar(context),
                                  buildCompOffList(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        buildApplyCompOffButton(context),
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

  Widget buildCompOffBalanceContainer(BuildContext context) {
    return BlocBuilder<CompOffListingCubit, CompOffListingState>(
      buildWhen: (pre, cur) {
        return (pre.isCompOffBalanceLoading != cur.isCompOffBalanceLoading);
      },
      builder: (context, state) {
        if(state.isCompOffBalanceLoading ?? false) {
          return const SizedBox();
        } else if(state.compOffBalance != null) {
          return buildCompOffBalanceWidget(state.compOffBalance!);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildCompOffBalanceWidget(double compOffBalance) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.padding_16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.radius_8)),
          color: Get.theme.colorScheme.primary),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimens.padding_20, Dimens.padding_16,
            Dimens.padding_20, Dimens.padding_16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'comp_off_balance'.tr,
              style: Get.textTheme.titleMedium?.copyWith(
                  color: Get.theme.colorScheme.background,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              compOffBalance.toString(),
              style: Get.textTheme.headlineSmall?.copyWith(
                  color: Get.theme.colorScheme.background,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectBillingCycleWidgets(BuildContext context) {
    return BlocProvider(
      create: (context) => BillingCycleCubit(),
      child: BillingCycleWidget(label: 'select_billing_cycle'.tr, isShowNextBillingCycle: true, onChanged: (selectedValue) {
        context.read<CompOffListingCubit>().updateSelectedBillingCycle(selectedValue);
      }),
    );
  }

  Widget buildCompOffTabBar(BuildContext context) {
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
                context.read<CompOffListingCubit>().updateCurrentTabIndex(index);
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

  Widget buildCompOffList() {
    return BlocBuilder<CompOffListingCubit, CompOffListingState>(
      buildWhen: (preState, curState) {
        return (preState.currentTabIndex != curState.currentTabIndex
            || preState.isLoading != curState.isLoading);
      },
      builder: (context, state) {
        List<CompOff>? compOffList = [];
        switch(state.currentTabIndex) {
          case 0:
            compOffList = state.pendingList;
          case 1:
            compOffList = state.approvedList;
          case 2:
            compOffList = state.rejectedList;
          case 3:
            compOffList = state.cancelledList;
          default:
            compOffList = [];
        }
        if(state.isLoading ?? false) {
          return const Padding(
            padding: EdgeInsets.all(Dimens.padding_150),
            child: AppCircularProgressIndicator(),
          );
        } else if(!compOffList.isNullOrEmpty) {
          return ListView.separated(
            itemCount: compOffList!.length,
            shrinkWrap: true,
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: Dimens.padding_16),
            itemBuilder: (context, i) {
              return CompOffTile(compOff: compOffList![i], onCompOffTap: _onCompOffTap);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: Dimens.padding_12);
            },
          );
        } else {
          return buildEmptyWidgets(context, state.currentTabIndex);
        }
      },
    );
  }

  _onCompOffTap(BuildContext context, CompOff compOff) async {
    bool? isRefresh = await MRouter.pushNamed(MRouter.compOffDetailsWidget, arguments: compOff.id ?? -1);
    if(isRefresh ?? false) {
      _refreshWidget(context);
    }
  }

  Widget buildEmptyWidgets(BuildContext context, int? currentTabIndex) {
    String message = 'no_comp_off_application_yet'.tr;
    if(currentTabIndex == 1) {
      message = 'no_approved_comp_off_application_yet'.tr;
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

  Widget buildApplyCompOffButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.padding_16),
      child: RaisedRectButton(
        text: 'apply_comp_off'.tr,
        onPressed: () async {
          bool? doRefresh = await MRouter.pushNamed(MRouter.applyCompOffWidget);
          if(doRefresh ?? false) {
            _refreshWidget(context);
          }
        },
      ),
    );
  }

  _refreshWidget(BuildContext context) {
    context.read<CompOffListingCubit>().getEmployeeCompOffList();
    context.read<CompOffListingCubit>().getLeaveBalance();
  }
}

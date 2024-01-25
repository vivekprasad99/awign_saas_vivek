import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/app_bar/default_app_bar.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/billing_cycle/cubit/billing_cycle_cubit.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/billing_cycle/widget/billing_cycle_widget.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements/cubit/reimbursement_cubit.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements/cubit/reimbursement_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/widget/buttons/raised_rect_button.dart';
import 'tile/all_tile.dart';

class ReimbursementsWidget extends StatelessWidget {
  const ReimbursementsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidgetsForMobile(context);
  }

  Widget buildWidgetsForMobile(BuildContext context) {
    return BlocConsumer<ReimbursementCubit, ReimbursementState>(
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
                                    buildSelectBillingCycleWidgets(context),
                                    const SizedBox(height: Dimens.padding_16),
                                    buildTabs(context),
                                    const SizedBox(height: Dimens.padding_16),
                                    buildAllList()
                                  ],
                                ),
                              ),
                            ),
                          ),
                          buildRequestReimbursementButtonWidgets(context),
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
      child: BillingCycleWidget(label: 'select_billing_cycle'.tr, onChanged: (selectedValue) {
        context.read<ReimbursementCubit>().updateSelectedBillingCycle(selectedValue);
      }),
    );
  }

  Widget buildTabs(BuildContext context) {
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
              labelStyle: Get.textTheme.labelLarge?.copyWith(
                  color: Get.theme.getCustomColor(context).backgroundgrey900,
                  fontWeight: FontWeight.w700),
              unselectedLabelStyle: Get.textTheme.labelLarge?.copyWith(
                  color: Get.theme.getCustomColor(context).backgroundgrey900),
              onTap: (index) {
                context.read<ReimbursementCubit>().updateCurrentTabIndex(index);
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAllList() {
    return BlocBuilder<ReimbursementCubit, ReimbursementState>(
      buildWhen: (preState, curState) {
        return (preState.isSearchReimbursementLoading !=
            curState.isSearchReimbursementLoading);
      },
      builder: (context, state) {
        if (state.isSearchReimbursementLoading ?? false) {
          return const Padding(
            padding: EdgeInsets.all(Dimens.padding_150),
            child: AppCircularProgressIndicator(),
          );
        } else if (state.reimbursementResponse?.data != null && !state.reimbursementResponse!.data!.isNullOrEmpty) {
          return ListView.separated(
            itemCount: state.reimbursementResponse!.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 0),
            itemBuilder: (context, i) {
              return MyInkWell(
                  onTap: () async {
                    bool? isRefresh = await MRouter.pushNamed(MRouter.reimbursementsDetailWidget,
                        arguments: state.reimbursementResponse!.data![i].uuid);
                    if (isRefresh ?? false) {
                      context
                          .read<ReimbursementCubit>()
                          .getAllReimbursement(0,);
                    }
                  },
                  child: AllTile(
                    reimbursement: state.reimbursementResponse!.data![i],
                    index: i,
                  ));
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
                  Text(
                    'no_reimbursement_application_yet'.tr,
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
      },
    );
  }

  Widget buildRequestReimbursementButtonWidgets(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_24,
          Dimens.padding_24, Dimens.padding_24),
      child: RaisedRectButton(
        backgroundColor: Get.theme.getCustomColor(context).secondary1300!,
        text: 'request_reimbursement'.tr,
        fontSize: Dimens.padding_16,
        onPressed: () async {
          bool? isRefresh =
              await MRouter.pushNamed(MRouter.reimbursementsFormWidget);
          if (isRefresh ?? false) {
            context
                .read<ReimbursementCubit>()
                .getAllReimbursement(0,);
          }
        },
      ),
    );
  }
}

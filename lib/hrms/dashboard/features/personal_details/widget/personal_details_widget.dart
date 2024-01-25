import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/dashboard/features/personal_details/cubit/personal_details_cubit.dart';
import 'package:awign_saas/hrms/dashboard/features/personal_details/cubit/personal_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import 'tab_view/basic_details_widget.dart';
import 'tab_view/work_details_widget.dart';

class PersonalDetailsWidget extends StatelessWidget {
  const PersonalDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PersonalDetailsCubit>().getEmployeeDetails();
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<PersonalDetailsCubit, PersonalDetailsState>(
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
              children: [
                DefaultAppBar(
                    isBackIconVisible: true, title: 'personal_details'.tr),
                Expanded(
                  child: InternetSensitive(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimens.padding_16),
                          buildTabBar(context),
                          buildWidgetAccordingToIndex(),
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

  Widget buildTabBar(BuildContext context) {
    return BlocBuilder<PersonalDetailsCubit, PersonalDetailsState>(
      buildWhen: (prev, cur) {
        return false;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
          child: DefaultTabController(
            length: 2,
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
                      // color: Get.theme.colorScheme.onPrimary,
                      // borderRadius: BorderRadius.circular(Dimens.radius_6),
                      border: Border(
                        bottom: BorderSide(
                          color: Get.theme.colorScheme.primary,
                          width: Dimens.border_3,
                        ),
                      ),
                    ),
                    labelColor: Get.theme.colorScheme.primary,
                    labelPadding: EdgeInsets.zero,
                    labelStyle: Get.textTheme.labelLarge?.copyWith(
                        color: Get.theme.colorScheme.primary,
                        fontWeight: FontWeight.w700),
                    unselectedLabelStyle: Get.textTheme.labelLarge?.copyWith(
                        color: Get.theme
                            .getCustomColor(context)
                            .backgroundgrey900),
                    onTap: (index) {
                      context
                          .read<PersonalDetailsCubit>()
                          .updateCurrentTabIndex(index);
                    },
                    tabs: [
                      Tab(child: Text('basic_details'.tr)),
                      Tab(child: Text('work_details'.tr)),
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

  Widget buildWidgetAccordingToIndex() {
    return BlocBuilder<PersonalDetailsCubit, PersonalDetailsState>(
      buildWhen: (preState, curState) {
        return ((preState.currentTabIndex != curState.currentTabIndex) || (preState.isLoading != curState.isLoading));
      },
      builder: (context, state) {
        if (state.isLoading ?? false) {
          return const Padding(
            padding: EdgeInsets.all(Dimens.padding_150),
            child: AppCircularProgressIndicator(),
          );
        } else if (state.employeeDetails != null) {
          switch (state.currentTabIndex) {
            case 0:
              return  BasicDetailsWidget(state.employeeDetails);
            case 1:
              return  WorkDetailsWidget(state.employeeDetails);
            default:
              return const SizedBox();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

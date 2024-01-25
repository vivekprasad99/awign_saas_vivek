import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/app_bar/default_app_bar.dart';
import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/hrms/holidays/features/holidays_listing/cubit/holiday_listing_cubit.dart';
import 'package:awign_saas/hrms/holidays/features/holidays_listing/widget/tile/holiday_tile.dart';
import 'package:awign_saas/hrms/leaves/data/model/leaves_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/widget/theme/dimens.dart';
import '../../../data/model/holiday_search_response.dart';
import '../cubit/holiday_listing_state.dart';

class HolidaysListingWidget extends StatelessWidget {
  const HolidaysListingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HolidayListingCubit>().searchHoliday();
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<HolidayListingCubit, HolidayListingState>(
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
              child: Column(children: [
          DefaultAppBar(
              isBackIconVisible: true,
              title: 'holidays'.tr,
          ),
          Expanded(
              child: InternetSensitive(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Dimens.padding_16),
                            buildHolidayTypeTabBar(context),
                            const SizedBox(height: Dimens.padding_16),
                            buildHolidayType(context),
                            buildHolidayList(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          )
        ]),
            ));
      },
    );
  }

  Widget buildHolidayTypeTabBar(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
        child: Container(
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
            labelColor:
                Get.theme.getCustomColor(context).backgroundgrey900!,
            labelPadding: EdgeInsets.zero,
            labelStyle: Get.textTheme.labelLarge?.copyWith(
                color: Get.theme.getCustomColor(context).backgroundgrey900,
                fontWeight: FontWeight.w700),
            unselectedLabelStyle: Get.textTheme.labelLarge?.copyWith(
                color: Get.theme.getCustomColor(context).backgroundgrey900),
            onTap: (index) {
              context.read<HolidayListingCubit>().updateCurrentTabIndex(index);
            },
            tabs: [
              Tab(
                  child: Text(
                'all'.tr,
              )),
              Tab(
                  child: Text(
                'regular'.tr,
              )),
              Tab(
                  child: Text(
                'restricted'.tr,
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHolidayType(BuildContext context) {
    return BlocBuilder<HolidayListingCubit, HolidayListingState>(
      buildWhen: (prevState, curState) {
        return prevState.currentTabIndex != curState.currentTabIndex;
      },
      builder: (context, state) {
        String strHolidayType = '';
        bool isShowRestrictedHolidayBalance = false;
        switch (state.currentTabIndex) {
          case 0:
            strHolidayType = 'all_holidays'.tr;
            // isShowRestrictedHolidayBalance = true;
          case 1:
            strHolidayType = 'regular_holidays'.tr;
          case 2:
            strHolidayType = 'restricted_holidays'.tr;
            // isShowRestrictedHolidayBalance = true;
          default:
            strHolidayType = '';
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
              child: Text(
                strHolidayType,
                style: Get.textTheme.titleSmall?.copyWith(
                    color: Get.theme.getCustomColor(context).backgroundblack!),
              ),
            ),
            isShowRestrictedHolidayBalance
                ? buildRestrictedHolidayBalance(context)
                : const SizedBox(),
          ],
        );
      },
    );
  }

  Widget buildRestrictedHolidayBalance(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
          0, Dimens.padding_24, 0, 0),
      padding: const EdgeInsets.all(Dimens.padding_12),
      color: Get.theme.getCustomColor(context).warning250!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'restircted_holidays_balance'.tr,
            style: Get.textTheme.titleMedium
                ?.copyWith(color: Get.theme.getCustomColor(context).onGeyser!),
          ),
          Text(
            '01 /02',
            style: Get.textTheme.titleMedium
                ?.copyWith(color: Get.theme.getCustomColor(context).onGeyser!),
          )
        ],
      ),
    );
  }

  Widget buildHolidayList() {
    return BlocBuilder<HolidayListingCubit, HolidayListingState>(
      buildWhen: (preState, curState) {
        return (preState.currentTabIndex != curState.currentTabIndex || preState.isLoading != curState.isLoading);
      },
      builder: (context, state) {
        List<Holiday>? holidayList = [];
        switch(state.currentTabIndex) {
          case 0:
            holidayList = state.allHolidayList;
          case 1:
            holidayList = state.regularHolidayList;
          case 2:
            holidayList = state.restrictedHolidayList;
          default:
            holidayList = [];
        }
        if(state.isLoading ?? false) {
          return const Padding(
            padding: EdgeInsets.all(Dimens.padding_150),
            child: AppCircularProgressIndicator(),
          );
        } else if(!holidayList.isNullOrEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
            child: ListView.separated(
              itemCount: holidayList!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: Dimens.padding_16),
              itemBuilder: (context, i) {
                return HolidayTile(context: context, holiday: holidayList![i], onApplyLeaveTap: _onApplyLeaveTap);
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

  _onApplyLeaveTap(BuildContext context, Holiday holiday) async {
    bool? doRefresh = await MRouter.pushNamed(MRouter.applyHolidayWidget, arguments: holiday);
    if(doRefresh ?? false) {
      context.read<HolidayListingCubit>().searchHoliday();
    }
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
            Text('holidays_not_not_found'.tr, style: Get.textTheme.titleMedium?.copyWith(color:
            Theme.of(context).getCustomColor(context).secondary1300, fontSize: Dimens.font_18),),
          ],
        ),
      ),
    );
  }
}

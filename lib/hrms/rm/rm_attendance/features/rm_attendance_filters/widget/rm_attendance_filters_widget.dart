import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/divider/h_divider.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/date_filter_option.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/filter_option.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/shift_filter_option.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/work_location_filter_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/data/model/ui_state.dart';
import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../../core/utils/helper.dart';
import '../../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../../core/widget/common/form_error_widget.dart';
import '../../../../../../core/widget/common/form_label_widget.dart';
import '../../../../../../core/widget/dialog/loading/app_circular_progress_indicator.dart';
import '../../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../../core/widget/scaffold/app_scaffold.dart';
import '../cubit/rm_attendance_filters_cubit.dart';
import '../cubit/rm_attendance_filters_state.dart';
import 'tile/main_filter_option_tile.dart';

class RMAttendanceFiltersWidget extends StatelessWidget {
  const RMAttendanceFiltersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidgetsForMobile(context);
  }

  Widget buildWidgetsForMobile(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultAppBar(
              isBackIconVisible: true,
              title: 'filters'.tr,
              isShowClearAll: true,
              onClearAllTap: () {},
              backgroundColor: Get.theme.getCustomColor(context).backgroundwhite,
            ),
            Expanded(
              child: InternetSensitive(
                child: BlocConsumer<RMAttendanceFiltersCubit, RMAttendanceFiltersState>(
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
                    if (state.uiState?.isOnScreenLoading ?? false) {
                      return const AppCircularProgressIndicator();
                    } else {
                      return buildBody(context, state);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, RMAttendanceFiltersState state) {
    return Column(
      children: [
        HDivider(dividerColor: Get.theme.getCustomColor(context).secondary1200),
        Expanded(
          child: Row(
            children: [
              buildMainFilterList(),
              buildCurrentSelectedFilterWidget(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMainFilterList() {
    return BlocBuilder<RMAttendanceFiltersCubit, RMAttendanceFiltersState>(
      buildWhen: (prev, cur) {
        return (prev.filterOptionList != cur.filterOptionList);
      },
      builder: (context, state) {
        if(!state.filterOptionList.isNullOrEmpty) {
          return Expanded(
            flex: 3,
            child: Container(
              color: Get.theme.colorScheme.background,
              child: ListView.separated(
                itemCount: state.filterOptionList!.length,
                padding: const EdgeInsets.only(top: 0),
                itemBuilder: (context, i) {
                  return MainFilterOptionTile(index: i, filterOption: state.filterOptionList![i], onFilterOptionTap: _onFilterOptionTap);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return HDivider(
                      dividerColor: Get.theme.colorScheme.inversePrimary);
                },
              ),
            ),
          );
        } else {
          return const AppCircularProgressIndicator();
        }
      },
    );
  }

  _onFilterOptionTap(BuildContext context, int index, FilterOption filterOption) {
    context.read<RMAttendanceFiltersCubit>().updateMainFilterList(index, filterOption);
  }

  Widget buildCurrentSelectedFilterWidget(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        color: Get.theme.getCustomColor(context).backgroundwhite,
        child: BlocBuilder<RMAttendanceFiltersCubit, RMAttendanceFiltersState>(
          buildWhen: (prev, cur) {
            return (prev.lastSelectedFilter != cur.lastSelectedFilter);
          },
          builder: (context, state) {
            if(state.lastSelectedFilter is DateFilterOption) {
             return buildDateFilterOption(context, state.lastSelectedFilter as DateFilterOption);
            } else if(state.lastSelectedFilter is ShiftFilterOption) {
              return const SizedBox();
            } else if(state.lastSelectedFilter is WorkLocationFilterOption) {
              return const SizedBox();
            } else {
              return const AppCircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget buildDateFilterOption(BuildContext context, DateFilterOption dateFilterOption) {
    return Column(
      children: [
        buildDateOption('today'.tr, 0, dateFilterOption.groupValue, () {
          context.read<RMAttendanceFiltersCubit>().updateDateOption(0);
        }),
        buildDateOption('this_week'.tr, 1, dateFilterOption.groupValue, () {
          context.read<RMAttendanceFiltersCubit>().updateDateOption(1);
        }),
        Column(
          children: [
            buildDateOption('custom_date'.tr, 2, dateFilterOption.groupValue, () {
              context.read<RMAttendanceFiltersCubit>().updateDateOption(2);
            }),
            buildSelectCustomDateWidget(),
          ],
        ),
      ],
    );
  }

  Widget buildDateOption(String label, int value, int? groupValue, Function onTap) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.padding_16),
      child: MyInkWell(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(
              width: Dimens.iconSize_16,
              height: Dimens.iconSize_16,
              child: Radio<int?>(
                value: value,
                groupValue: groupValue,
                onChanged: (v) {}
              ),
            ),
            const SizedBox(width: Dimens.padding_16),
            Text(label, style: Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget buildSelectCustomDateWidget() {
    return BlocBuilder<RMAttendanceFiltersCubit, RMAttendanceFiltersState>(
      buildWhen: (previous, state) {
        return previous.lastSelectedFilter != state.lastSelectedFilter;
      },
      builder: (context, state) {
        if(state.lastSelectedFilter is DateFilterOption) {
          DateFilterOption dateFilterOption = state.lastSelectedFilter as DateFilterOption;
          if(dateFilterOption.groupValue == 2) {
            return buildSelectDateWidgets(context, dateFilterOption.customDateTime, null, () async {
              DateTime now = DateTime.now();
              DateTime firstDate = DateTime(now.year - 1, now.month, now.day);
              DateTime? dateTime =
              await DateTimeHelper.showDatePickerDialog(context, firstDate: firstDate, initialDate: now, lastDate: now);
              if (dateTime != null) {
                context.read<RMAttendanceFiltersCubit>().updateCustomDate(dateTime);
              }
            });
          } else {
            return const SizedBox();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildSelectDateWidgets(
      BuildContext context, DateTime? selectedDate, String? errorText, Function onTap) {
    String? strSelectedDate;
    if(selectedDate != null) {
      strSelectedDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatDDMMMYYYY, inputDateTime: selectedDate);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyInkWell(
            onTap: () {
              onTap();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.radius_8),
                border: Border.all(
                  width: Dimens.border_1,
                  color: Get.theme.getCustomColor(context).secondary1200!,
                  style: BorderStyle.solid,
                ),
                color: Get.theme.colorScheme.background,
              ),
              padding: const EdgeInsets.fromLTRB(Dimens.padding_12,
                  Dimens.padding_12, Dimens.padding_12, Dimens.padding_12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (strSelectedDate == null) ? FormLabelWidget(
                      labelText: 'select_date'.tr,
                      textColor: Theme.of(context)
                          .getCustomColor(context)
                          .backgroundgrey700) : Text(strSelectedDate,
                      style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                  SvgPicture.asset(
                    'assets/images/ic_calendar.svg',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimens.padding_8),
          FormErrorWidget(errorText: errorText),
        ],
      ),
    );
  }
}
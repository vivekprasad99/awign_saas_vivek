import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../core/widget/buttons/raised_rect_button.dart';
import '../../../../../core/widget/common/form_error_widget.dart';
import '../../../../../core/widget/common/form_label_widget.dart';
import '../../../../../core/widget/common/form_text_field.dart';
import '../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../../reimbursements/data/model/manager_response.dart';
import '../../../data/model/holiday_search_response.dart';
import '../cubit/apply_holiday_cubit.dart';
import '../cubit/apply_holiday_state.dart';

class ApplyHolidayWidget extends StatelessWidget {
  final Holiday holiday;
  const ApplyHolidayWidget(this.holiday, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ApplyHolidayCubit>().updateHoliday(holiday);
    context.read<ApplyHolidayCubit>().getManagerList();
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultAppBar(
              isBackIconVisible: true,
              title: 'apply_holiday'.tr,
            ),
            Expanded(
              child: InternetSensitive(
                child: BlocConsumer<ApplyHolidayCubit, ApplyHolidayState>(
                  listenWhen: (previous, current) {
                    return previous.uiState != current.uiState;
                  },
                  listener: (context, state) {
                    if(state.uiState != null && state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
                      Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
                    }
                    if(state.uiState?.event == Event.success) {
                      Helper.showSuccessAlertDialogWithOnTap(context, state.uiState?.successWithoutAlertMessage ?? '', () {
                        MRouter.pop(true);
                      });
                    }
                  },
                  buildWhen: (previous, state) {
                    return ((state.uiState?.event == Event.reloadWidget && previous.uiState != state.uiState));
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

  Widget buildBody(BuildContext context, ApplyHolidayState state) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.padding_16, vertical: Dimens.padding_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildFormContainer(context, state),
                ],
              ),
            ),
          ),
        ),
        buildApplyCompOffButton(),
      ],
    );
  }

  Widget buildFormContainer(BuildContext context, ApplyHolidayState state) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.radius_8),
        border: Border.all(
          width: Dimens.border_1,
          color: Get.theme.getCustomColor(context).secondary1200!,
          style: BorderStyle.solid,
        ),
        color: Get.theme.colorScheme.primaryContainer,
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.padding_16, vertical: Dimens.padding_24),
      child: Column(
        children: [
          buildSelectDateWidget(state),
          const SizedBox(height: Dimens.padding_16),
          buildSelectApplyingToWidgets(context),
          const SizedBox(height: Dimens.padding_16),
          buildReasonTextFieldWidget(),
        ],
      ),
    );
  }

  Widget buildSelectDateWidget(ApplyHolidayState state) {
    return BlocBuilder<ApplyHolidayCubit, ApplyHolidayState>(
      buildWhen: (previous, state) {
        return (previous.date != state.date || previous.dateError != state.dateError);
      },
      builder: (context, state) {
        String label = 'date'.tr;
        return buildSelectDateWidgets(context, state, label, state.date, state.dateError, () async {});
      },
    );
  }

  Widget buildSelectDateWidgets(
      BuildContext context, ApplyHolidayState state, String labelText, DateTime? selectedDate, String? errorText, Function onTap) {
    String? strSelectedDate;
    if(selectedDate != null) {
      strSelectedDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatDDMMMYYYY, inputDateTime: selectedDate);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Dimens.padding_16),
        FormLabelWidget(labelText: labelText, requiredText: '*'),
        const SizedBox(height: Dimens.padding_8),
        MyInkWell(
          onTap: onTap,
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
                        .backgroundgrey700)
                    : Text(strSelectedDate, style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
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
    );
  }

  Widget buildSelectApplyingToWidgets(BuildContext context) {
    return BlocBuilder<ApplyHolidayCubit, ApplyHolidayState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormLabelWidget(labelText: 'applying_to'.tr, requiredText: '*'),
            const SizedBox(height: Dimens.padding_8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.radius_8),
                border: Border.all(
                  width: Dimens.border_1,
                  color: Get.theme.getCustomColor(context).secondary1200!,
                  style: BorderStyle.solid,
                ),
                color: Get.theme.colorScheme.background,
              ),
              padding: const EdgeInsets.fromLTRB(Dimens.padding_12, 0, Dimens.padding_12, 0),
              child: DropdownButton<Manager>(
                isExpanded: true,
                value: state.selectedManager,
                hint: FormLabelWidget(labelText: 'please_picks'.tr,
                    textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                icon: SvgPicture.asset(
                  'assets/images/ic_drop_down_blue.svg',
                ),
                // elevation: 16,
                underline: const SizedBox(),
                onChanged: (Manager? manager) {
                  context.read<ApplyHolidayCubit>().updateSelectedManager(manager!);
                },
                items: state.managerList!
                    .map<DropdownMenuItem<Manager>>((Manager value) {
                  return DropdownMenuItem<Manager>(
                    value: value,
                    child: Text(value.name!, style: Get.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600)),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildReasonTextFieldWidget() {
    return BlocBuilder<ApplyHolidayCubit, ApplyHolidayState>(
      buildWhen: (previousState, state) {
        if ((previousState.reasonError == null && state.reasonError != null) ||
            (previousState.reasonError != null && state.reasonError == null)) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimens.padding_8),
            FormLabelWidget(labelText: 'reason'.tr, requiredText: '*'),
            const SizedBox(height: Dimens.padding_8),
            FormTextField(
              onChanged: context.read<ApplyHolidayCubit>().updateReason,
              keyboardType: TextInputType.text,
              maxLines: 3,
              textInputAction: TextInputAction.done,
              errorText: state.reasonError,
            ),
          ],
        );
      },
    );
  }

  Widget buildApplyCompOffButton() {
    return BlocBuilder<ApplyHolidayCubit, ApplyHolidayState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.padding_16),
          child: RaisedRectButton(
            buttonState: state.buttonState,
            text: 'apply'.tr,
            onPressed: () {
              context.read<ApplyHolidayCubit>().applyHolidayLeave();
            },
          ),
        );
      },
    );
  }
}

import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/leaves/data/model/leave_types_response.dart';
import 'package:awign_saas/hrms/leaves/data/model/leaves_arguments.dart';
import 'package:awign_saas/hrms/leaves/features/apply_leave/cubit/apply_leave_cubit.dart';
import 'package:awign_saas/hrms/leaves/features/apply_leave/cubit/apply_leave_state.dart';
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

class ApplyLeaveWidget extends StatelessWidget {
  final LeavesArgument? leavesArgument;
  const ApplyLeaveWidget(this.leavesArgument, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ApplyLeaveCubit>().getLeaveTypes();
    context.read<ApplyLeaveCubit>().getLeaveBalance();
    if(leavesArgument?.attendanceDetails != null) {
      context.read<ApplyLeaveCubit>().updateAttendanceDetails(leavesArgument!.attendanceDetails!, leavesArgument!.attendanceStatusEntity);
    } else if(leavesArgument?.regularisation != null) {
      context.read<ApplyLeaveCubit>().updateRegularisation(leavesArgument!.regularisation!);
    }
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultAppBar(
              isBackIconVisible: true,
              title: 'apply_leave'.tr,
            ),
            Expanded(
              child: InternetSensitive(
                child: BlocConsumer<ApplyLeaveCubit, ApplyLeaveState>(
                  listenWhen: (previous, current) {
                    return previous.uiState != current.uiState;
                  },
                  listener: (context, state) {
                    if(state.uiState != null && state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
                      Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
                    }
                    if(state.uiState?.event == Event.success) {
                      Helper.showSuccessAlertDialogWithOnTap(context, 'leave_applied_successfully'.tr, () {
                        MRouter.pop(true);
                      });
                    }
                  },
                  buildWhen: (previous, state) {
                    return ((state.uiState?.event == Event.reloadWidget &&
                        previous.uiState != state.uiState) || previous.isLeaveBalanceLoading != state.isLeaveBalanceLoading
                        || previous.attendanceDetails != state.attendanceDetails || previous.regularisation != state.regularisation);
                  },
                  builder: (context, state) {
                    if ((state.uiState?.isOnScreenLoading ?? false) || (state.isLeaveBalanceLoading ?? false)) {
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

  Widget buildBody(BuildContext context, ApplyLeaveState state) {
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
        buildApplyLeaveButton(),
      ],
    );
  }

  Widget buildFormContainer(BuildContext context, ApplyLeaveState state) {
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
          buildSelectLeaveTypeWidgets(context, state),
          buildLeaveBalanceMessageWidget(),
          buildSelectFromDateWidget(state),
          buildSelectToDateWidget(state),
          buildShiftsWidget(context),
          buildReasonTextFieldWidget(),
        ],
      ),
    );
  }

  Widget buildSelectFromDateWidget(ApplyLeaveState state) {
    return BlocBuilder<ApplyLeaveCubit, ApplyLeaveState>(
      buildWhen: (previous, state) {
        return (previous.fromDate != state.fromDate || previous.fromDateError != state.fromDateError);
      },
      builder: (context, state) {
        String label = 'from_date'.tr;
        if(state.attendanceDetails != null || state.regularisation != null) {
          label = 'date'.tr;
        }
        return buildSelectDateWidgets(context, state, label, state.fromDate, state.fromDateError,
                () async {
                  if(state.attendanceDetails == null && state.regularisation == null) {
                    DateTime? dateTime =
                    await DateTimeHelper.showDatePickerDialog(context);
                    if (dateTime != null) {
                      context.read<ApplyLeaveCubit>().updateFromDate(
                          dateTime);
                    }
                  }
        });
      },
    );
  }

  Widget buildSelectToDateWidget(ApplyLeaveState state) {
    return Visibility(
      visible: (state.attendanceDetails == null && state.regularisation == null),
      child: BlocBuilder<ApplyLeaveCubit, ApplyLeaveState>(
        buildWhen: (previous, state) {
          return previous.toDate != state.toDate || previous.toDateError != state.toDateError || previous.fromDate != state.fromDate;
        },
        builder: (context, state) {
          return buildSelectDateWidgets(context, state, 'to_date'.tr, state.toDate,state.toDateError, () async {
              DateTime? dateTime =
              await DateTimeHelper.showDatePickerDialog(context, initialDate: state.fromDate, firstDate: state.fromDate);
              if (dateTime != null) {
                context.read<ApplyLeaveCubit>().updateToDate(dateTime);
              }
          });
        },
      ),
    );
  }

  Widget buildSelectLeaveTypeWidgets(BuildContext context, ApplyLeaveState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'leave_type'.tr, requiredText: '*'),
        const SizedBox(height: Dimens.padding_8),
        BlocBuilder<ApplyLeaveCubit, ApplyLeaveState>(
          buildWhen: (previous, state) {
            return previous.selectedLeaveTypeEntity !=
                state.selectedLeaveTypeEntity;
          },
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.radius_8),
                border: Border.all(
                  width: Dimens.border_1,
                  color: Get.theme.getCustomColor(context).secondary1200!,
                  style: BorderStyle.solid,
                ),
                color: Get.theme.colorScheme.background,
              ),
              padding: const EdgeInsets.fromLTRB(
                  Dimens.padding_12, 0, Dimens.padding_12, 0),
              child: DropdownButton<LeaveTypeEntity>(
                isExpanded: true,
                value: state.selectedLeaveTypeEntity,
                hint: FormLabelWidget(
                    labelText: 'select_leave'.tr,
                    textColor: Theme.of(context)
                        .getCustomColor(context)
                        .backgroundgrey700),
                icon: SvgPicture.asset(
                  'assets/images/ic_drop_down_blue.svg',
                ),
                underline: const SizedBox(),
                onChanged: (LeaveTypeEntity? selectedLeaveType) {
                  context
                      .read<ApplyLeaveCubit>()
                      .updateSelectedLeaveType(selectedLeaveType);
                },
                items: state.leaves?.map<DropdownMenuItem<LeaveTypeEntity>>(
                    (LeaveTypeEntity leaveTypeEntity) {
                  return DropdownMenuItem<LeaveTypeEntity>(
                    value: leaveTypeEntity,
                    child: Text(leaveTypeEntity.name?.toCapitalized() ?? '',
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildLeaveBalanceMessageWidget() {
    return BlocBuilder<ApplyLeaveCubit, ApplyLeaveState>(
      buildWhen: (prevState, curState) {
        return prevState.leavesBalanceMessage != curState.leavesBalanceMessage;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: Dimens.padding_8),
          child: Align(
              alignment: Alignment.topLeft,
              child: FormErrorWidget(errorText: state.leavesBalanceMessage)
          ),
        );
      },
    );
  }

  Widget buildSelectDateWidgets(
      BuildContext context, ApplyLeaveState state, String labelText, DateTime? selectedDate, String? errorText, Function onTap) {
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
          onTap: (){
            (state.attendanceDetails == null && state.regularisation == null) ? onTap() : null;
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
            state.attendanceDetails == null ? SvgPicture.asset(
                  'assets/images/ic_calendar.svg',
                ) : const SizedBox(),
              ],
            ),
          ),
        ),
        const SizedBox(height: Dimens.padding_8),
        FormErrorWidget(errorText: errorText),
      ],
    );
  }

  Widget buildShiftsWidget(BuildContext context) {
    return BlocBuilder<ApplyLeaveCubit, ApplyLeaveState>(
      buildWhen: (prev, cur) {
        return (prev.selectedShiftType != cur.selectedShiftType || prev.fromDate != cur.fromDate || prev.toDate != cur.toDate);
      },
      builder: (context, state) {
        if(state.fromDate != null && state.toDate != null && state.fromDate!.isAtSameMomentAs(state.toDate!)) {
          return Padding(
            padding: const EdgeInsets.only(top: Dimens.padding_4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildShiftChip(context, state, ShiftType.firstHalf, state.selectedShiftType),
                  const SizedBox(width: Dimens.padding_8),
                  buildShiftChip(context, state, ShiftType.secondHalf, state.selectedShiftType),
                  const SizedBox(width: Dimens.padding_8),
                  buildShiftChip(context, state, ShiftType.fullDay, state.selectedShiftType),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildShiftChip(BuildContext context, ApplyLeaveState state, ShiftType shiftType, ShiftType? selectedShift) {
    bool isSelected = false;
    if(shiftType == selectedShift) {
      isSelected = true;
    }
    return ChoiceChip(label: Text(shiftType.value.replaceAll('_', ' ').toTitleCase(),
        style: Get.textTheme.bodyMedium?.copyWith(color: isSelected ? Get.theme.getCustomColor(context).backgroundwhite : Get.theme.getCustomColor(context).backgroundblack)),
        selectedColor: Get.theme.colorScheme.primary,
        selected: isSelected, onSelected: (bool isSelected) {
          if(state.attendanceStatusEntity == null) {
            context.read<ApplyLeaveCubit>().updateSelectedShift(shiftType);
          }
        });
  }

  Widget buildReasonTextFieldWidget() {
    return BlocBuilder<ApplyLeaveCubit, ApplyLeaveState>(
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
              onChanged: context.read<ApplyLeaveCubit>().updateReason,
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

  Widget buildApplyLeaveButton() {
    return BlocBuilder<ApplyLeaveCubit, ApplyLeaveState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.padding_16),
          child: RaisedRectButton(
            buttonState: state.buttonState,
            text: 'apply_leave'.tr,
            onPressed: () {
              context.read<ApplyLeaveCubit>().applyLeave();
            },
          ),
        );
      },
    );
  }
}

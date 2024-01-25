import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/widget/divider/h_divider.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/leaves/features/leave_details/cubit/leave_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/router/router.dart';
import '../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../core/widget/buttons/raised_rect_button.dart';
import '../../../../../core/widget/common/form_label_widget.dart';
import '../../../../../core/widget/dialog/loading/app_circular_progress_indicator.dart';
import '../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../data/model/leave.dart';
import '../cubit/leave_details_cubit.dart';

class LeaveDetailsWidget extends StatelessWidget {
  final int leaveID;
  const LeaveDetailsWidget(this.leaveID, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LeaveDetailsCubit>().getLeaveDetails(leaveID);
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultAppBar(
              isBackIconVisible: true,
              title: 'leave_details'.tr,
            ),
            Expanded(
              child: InternetSensitive(
                child: BlocConsumer<LeaveDetailsCubit, LeaveDetailsState>(
                  listenWhen: (previous, current) {
                    return previous.uiState != current.uiState;
                  },
                  listener: (context, state) {
                    if(state.uiState != null && state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
                      Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
                    }
                    if(state.uiState?.event == Event.success) {
                      Helper.showSuccessAlertDialogWithOnTap(context, 'leave_cancelled_successfully'.tr, () {
                        MRouter.pop(true);
                      });
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

  Widget buildBody(BuildContext context, LeaveDetailsState state) {
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
                  buildLeaveDetailsContainer(context, state),
                ],
              ),
            ),
          ),
        ),
        buildCancelLeaveButton(),
      ],
    );
  }

  Widget buildLeaveDetailsContainer(BuildContext context, LeaveDetailsState state) {
    var (String icon, String text, Color? bgColor) =
    switch (state.leave!.status) {
      LeaveStatus.pending => ('assets/images/ic_pending.png', 'approval_pending'.tr,
      Get.theme.getCustomColor(context).warning250),
      LeaveStatus.approved => ('assets/images/ic_approved.png', 'approval_successfully'.tr,
      Get.theme.getCustomColor(context).skirretgreen),
      LeaveStatus.rejected => ('assets/images/ic_rejected.png', 'application_rejected'.tr,
      Get.theme.colorScheme.error),
      LeaveStatus.withdrawn => ('assets/images/ic_withdraw.png', 'cancelled_leave'.tr,
      Get.theme.getCustomColor(context).backgroundgrey800),
      _ => ('assets/images/ic_pending.png', 'approval_pending'.tr,
      Get.theme.getCustomColor(context).warning250),
    };
    String fromDateLabel = 'from_date'.tr;
    String strFromDate = '';
    if(state.leave?.startDate != null) {
     strFromDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.leave!.startDate!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    String toDateLabel = 'to_date'.tr;
    String strToDate = '';
    if(state.leave?.endDate != null) {
      strToDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.leave!.endDate!), DateTimeHelper.dateFormatDDMMMYYYY);
    } else {
      fromDateLabel = 'date'.tr;
      toDateLabel = 'half_day'.tr;
      strToDate = state.leave?.workingShift?.value.toTitleCase().replaceFirst('_', ' ') ?? '';
      if(strToDate.isEmpty) {
        toDateLabel = '';
      }
    }
    String strAppliedOnDate = '';
    if(state.leave?.createdAt != null) {
      strAppliedOnDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.leave!.createdAt!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    String approvedOnLabel = '';
    String strApprovedOn = '';
    if(state.leave?.updatedAt != null && state.leave?.status == LeaveStatus.approved) {
      approvedOnLabel = 'approved_on'.tr;
      strApprovedOn = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.leave!.updatedAt!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.radius_8),
        border: Border.all(
          width: Dimens.border_1,
          color: bgColor!,
          style: BorderStyle.solid,
        ),
        color: Get.theme.colorScheme.background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLeaveDetailsHeaderWidget(context, icon, text, bgColor),
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_24, Dimens.padding_16, Dimens.padding_24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormLabelWidget(labelText: 'leave_type'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                const SizedBox(height: Dimens.padding_4),
                buildAnswerValueWidget(context, state.leave?.leaveType ?? ''),
                const SizedBox(height: Dimens.padding_12),
                HDivider(dividerColor: Get.theme.getCustomColor(context).backgroundgrey400, verticalPadding: Dimens.padding_8),
                const SizedBox(height: Dimens.padding_12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: fromDateLabel, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, strFromDate),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: toDateLabel, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, strToDate),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.padding_12),
                HDivider(dividerColor: Get.theme.getCustomColor(context).backgroundgrey400, verticalPadding: Dimens.padding_8),
                const SizedBox(height: Dimens.padding_12),
                FormLabelWidget(labelText: 'reason'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                const SizedBox(height: Dimens.padding_4),
                buildAnswerValueWidget(context, state.leave!.reason ?? ''),
                const SizedBox(height: Dimens.padding_12),
                HDivider(dividerColor: Get.theme.getCustomColor(context).backgroundgrey400, verticalPadding: Dimens.padding_8),
                const SizedBox(height: Dimens.padding_12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: 'applied_on'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, strAppliedOnDate),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: approvedOnLabel, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, strApprovedOn),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.padding_12),
                HDivider(dividerColor: Get.theme.getCustomColor(context).backgroundgrey400, verticalPadding: Dimens.padding_8),
                const SizedBox(height: Dimens.padding_12),
                FormLabelWidget(labelText: 'approver'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                const SizedBox(height: Dimens.padding_4),
                buildAnswerValueWidget(context, state.leave!.managerName ?? ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLeaveDetailsHeaderWidget(BuildContext context, String icon, String text, Color? bgColor) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimens.radius_8),
              topRight: Radius.circular(Dimens.radius_8)),
          color: bgColor),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimens.padding_20, Dimens.padding_16,
            Dimens.padding_20, Dimens.padding_16),
        child: Row(
          children: [
            Image.asset(icon),
            const SizedBox(width: Dimens.padding_8),
            Text(
              text,
              style: Get.textTheme.titleMedium?.copyWith(
                  color: Get.theme.colorScheme.background,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAnswerValueWidget(BuildContext context, String answerValue) {
    return Text(answerValue, style: Get.textTheme.bodyMedium?.copyWith(
        color: Theme.of(context)
            .extension<CustomColors>()!
            .backgroundgrey900,
        fontWeight: FontWeight.w600));
  }

  Widget buildCancelLeaveButton() {
    return BlocBuilder<LeaveDetailsCubit, LeaveDetailsState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        if(state.leave?.status == LeaveStatus.pending || state.leave?.status == LeaveStatus.approved) {
          return Padding(
            padding: const EdgeInsets.all(Dimens.padding_16),
            child: RaisedRectButton(
              buttonState: state.buttonState,
              text: 'cancel_leave'.tr,
              textColor: Get.theme.colorScheme.primary,
              backgroundColor: AppColors.transparent,
              borderColor: Get.theme.colorScheme.primary,
              onPressed: () {
                Helper.showConfirmAlertDialog(context, message: 'you_are_about_to_cancel_the_leave_request'.tr, onYesTap: () {
                  if(state.leave?.holidayId != null) {
                    context.read<LeaveDetailsCubit>().withdrawHolidayLeave(state.leave!.holidayId!);
                  } else {
                    context.read<LeaveDetailsCubit>().withdrawLeave(leaveID);
                  }
                });
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
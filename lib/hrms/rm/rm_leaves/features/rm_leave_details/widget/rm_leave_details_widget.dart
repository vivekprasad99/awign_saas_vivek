import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/widget/divider/h_divider.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/rm/rm_leaves/features/rm_leave_details/cubit/rm_leave_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/data/model/ui_state.dart';
import '../../../../../../core/router/router.dart';
import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../../core/utils/helper.dart';
import '../../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../../core/widget/buttons/raised_rect_button.dart';
import '../../../../../../core/widget/common/form_label_widget.dart';
import '../../../../../../core/widget/dialog/loading/app_circular_progress_indicator.dart';
import '../../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../../../leaves/data/model/leave.dart';
import '../cubit/rm_leave_details_state.dart';
import 'dialog/rm_leave_approve/widget/rm_leave_approve_dialog.dart';

class RMLeaveDetailsWidget extends StatelessWidget {
  final Leave leave;
  const RMLeaveDetailsWidget(this.leave, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RMLeaveDetailsCubit>().updateLeave(leave);
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
                child: BlocConsumer<RMLeaveDetailsCubit, RMLeaveDetailsState>(
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

  Widget buildBody(BuildContext context, RMLeaveDetailsState state) {
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
        buildApproveAndRejectWidget(state),
      ],
    );
  }

  Widget buildLeaveDetailsContainer(BuildContext context, RMLeaveDetailsState state) {
    var (String icon, String text, Color? bgColor) =
    switch (state.leave!.leaveStatus) {
      LeaveStatus.pending => ('assets/images/ic_pending.png', 'approval_pending'.tr,
      Get.theme.getCustomColor(context).warning250),
      LeaveStatus.approved => ('assets/images/ic_approved.png', 'approval_successfully'.tr,
      Get.theme.getCustomColor(context).skirretgreen),
      LeaveStatus.rejected => ('assets/images/ic_rejected.png', 'application_rejected'.tr,
      Get.theme.colorScheme.error),
      _ => ('assets/images/ic_pending.png', 'approval_pending'.tr,
      Get.theme.getCustomColor(context).warning250),
    };
    String strFromDate = '';
    if(state.leave?.startDate != null) {
      strFromDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.leave!.startDate!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    String strToDate = '';
    if(state.leave?.endDate != null) {
      strToDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.leave!.endDate!), DateTimeHelper.dateFormatDDMMMYYYY);
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
            padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_24, Dimens.padding_16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildAvatar(),
                const SizedBox(width: Dimens.padding_8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildName(context),
                    buildEmployeeID(context),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_24, Dimens.padding_16, Dimens.padding_24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: 'from_date'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, strFromDate),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: 'to_date'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: 'no_of_days'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, '${leave.numberOfDays?.round()}'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: 'leave_type'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, state.leave?.leaveType ?? ''),
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
                FormLabelWidget(labelText: 'approver'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                const SizedBox(height: Dimens.padding_4),
                buildAnswerValueWidget(context, UserPreferences.getInstance().getCurrentUser()?.name ?? ''),
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

  Widget buildAvatar() {
    return SvgPicture.asset(
      'assets/images/ic_circular_profile_place_holder.svg',
      width: Dimens.imageWidth_56,
      height: Dimens.imageHeight_56,
    );
  }

  Widget buildName(BuildContext context) {
    String name = leave.employeeName ?? '';
    return Text(name,
        style: Get.textTheme.labelLarge?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey900, fontWeight: FontWeight.w700));
  }

  Widget buildEmployeeID(BuildContext context) {
    String employeeID = leave.employeeUid ?? '';
    return Text(employeeID,
        style: Get.textTheme.labelMedium?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey700, fontWeight: FontWeight.w400));
  }

  Widget buildAnswerValueWidget(BuildContext context, String answerValue) {
    return Text(answerValue, style: Get.textTheme.bodyMedium?.copyWith(
        color: Theme.of(context)
            .extension<CustomColors>()!
            .backgroundgrey900,
        fontWeight: FontWeight.w600));
  }

  Widget buildApproveAndRejectWidget(RMLeaveDetailsState state) {
    if(state.leave!.leaveStatus == LeaveStatus.pending) {
      return Row(
        children: [
          buildApproveLeaveButton(),
          buildCancelLeaveButton(),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildApproveLeaveButton() {
    return BlocBuilder<RMLeaveDetailsCubit, RMLeaveDetailsState>(
      buildWhen: (previousState, state) {
        return previousState.approveButtonState != state.approveButtonState;
      },
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_16, Dimens.padding_8, Dimens.padding_16),
            child: RaisedRectButton(
              buttonState: state.approveButtonState,
              text: 'approve'.tr,
              onPressed: () {
                showRMLeaveApproveDialog(context, state.leave!, LeaveStatus.approved);
              },
            ),
          ),
        );
      },
    );
  }

  Widget buildCancelLeaveButton() {
    return BlocBuilder<RMLeaveDetailsCubit, RMLeaveDetailsState>(
      buildWhen: (previousState, state) {
        return previousState.rejectButtonState != state.rejectButtonState;
      },
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.padding_8, Dimens.padding_16, Dimens.padding_16, Dimens.padding_16),
            child: RaisedRectButton(
              buttonState: state.rejectButtonState,
              text: 'reject'.tr,
              textColor: Get.theme.colorScheme.primary,
              backgroundColor: AppColors.transparent,
              borderColor: Get.theme.colorScheme.primary,
              onPressed: () {
                showRMLeaveApproveDialog(context, state.leave!, LeaveStatus.rejected);
              },
            ),
          ),
        );
      },
    );
  }
}
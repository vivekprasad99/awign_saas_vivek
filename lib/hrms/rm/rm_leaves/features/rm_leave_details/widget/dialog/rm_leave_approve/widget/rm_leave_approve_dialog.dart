import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/rm/rm_leaves/features/rm_leave_details/widget/dialog/rm_leave_approve/cubit/rm_leave_approve_cubit.dart';
import 'package:awign_saas/hrms/rm/rm_leaves/features/rm_leave_details/widget/dialog/rm_leave_approve/cubit/rm_leave_approve_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../../../../../core/data/model/ui_state.dart';
import '../../../../../../../../../core/di/app_injection_container.dart';
import '../../../../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../../../../../core/utils/helper.dart';
import '../../../../../../../../../core/widget/buttons/my_ink_well.dart';
import '../../../../../../../../../core/widget/buttons/raised_rect_button.dart';
import '../../../../../../../../../core/widget/common/form_label_widget.dart';
import '../../../../../../../../../core/widget/common/form_text_field.dart';
import '../../../../../../../../leaves/data/model/leave.dart';

void showRMLeaveApproveDialog(
    BuildContext context, Leave leave, LeaveStatus leaveStatus) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => BlocProvider(
      create: (context) => RMLeaveApproveCubit(sl()),
      child: RMLeaveApproveDialog(leave, leaveStatus),
    ),
  );
}

class RMLeaveApproveDialog extends StatelessWidget {
  final Leave leave;
  final LeaveStatus leaveStatus;

  const RMLeaveApproveDialog(this.leave, this.leaveStatus, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: Dimens.elevation_8,
      insetAnimationCurve: Curves.easeInOut,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      insetPadding: const EdgeInsets.all(Dimens.padding_20),
      child: buildDialogContent(context),
    );
  }

  Widget buildDialogContent(BuildContext context) {
    context.read<RMLeaveApproveCubit>().updateLeave(leave);
    return BlocConsumer<RMLeaveApproveCubit, RMLeaveApproveState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {
        if(state.uiState != null && state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
          Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
        }
        if(state.uiState?.event == Event.success) {
          MRouter.pop(null);
          MRouter.pop(true);
        }
      },
      builder: (context, state) {
        if(state.leave != null) {
          return Container(
            padding: const EdgeInsets.all(Dimens.padding_16),
            decoration: BoxDecoration(
              color: Get.theme.getCustomColor(context).backgroundwhite,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Dimens.radius_8),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: Dimens.padding_8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildTitle(),
                      buildCloseIcon(),
                    ],
                  ),
                  const SizedBox(height: Dimens.padding_24),
                  buildFromDateToDateWidgets(context, state),
                  buildRemarksTextFieldWidget(),
                  const SizedBox(height: Dimens.padding_24),
                  buildApproveOrRejectButton(),
                  const SizedBox(height: Dimens.padding_8),
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

  Widget buildCloseIcon() {
    return Align(
      alignment: Alignment.topRight,
      child: MyInkWell(
        onTap: () {
          MRouter.pop(null);
        },
        child: SvgPicture.asset('assets/images/ic_close_dialog.svg'),
      ),
    );
  }

  Widget buildTitle() {
    String title = '';
    if(leaveStatus == LeaveStatus.approved) {
      title = '${'leave'.tr} - ${'approve'.tr}';
    } else {
      title = '${'leave'.tr} - ${'reject'.tr}';
    }
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Get.textTheme.headlineSmall?.copyWith(fontSize: Dimens.font_20, fontWeight: FontWeight.w700),
    );
  }

  Widget buildFromDateToDateWidgets(BuildContext context, RMLeaveApproveState state) {
    if(leaveStatus == LeaveStatus.approved) {
      String strFromDate = '';
      if(state.leave?.startDate != null) {
        strFromDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.leave!.startDate!), DateTimeHelper.dateFormatDDMMMYYYY);
      }
      String strToDate = '';
      if(state.leave?.endDate != null) {
        strToDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.leave!.endDate!), DateTimeHelper.dateFormatDDMMMYYYY);
      }
      return Column(
        children: [
          buildDateWidgets(context, 'from_date'.tr, strFromDate),
          const SizedBox(height: Dimens.margin_16),
          buildDateWidgets(context, 'to_date'.tr, strToDate),
          const SizedBox(height: Dimens.margin_16),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildDateWidgets(
      BuildContext context, String labelText, String? strDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: FormLabelWidget(labelText: labelText),
        ),
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
          padding: const EdgeInsets.fromLTRB(Dimens.padding_12,
              Dimens.padding_12, Dimens.padding_12, Dimens.padding_12),
          child: Text(strDate ?? '',
              style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Widget buildRemarksTextFieldWidget() {
    return BlocBuilder<RMLeaveApproveCubit, RMLeaveApproveState>(
      buildWhen: (previousState, state) {
        return false;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormLabelWidget(labelText: 'remarks'.tr),
            const SizedBox(height: Dimens.padding_8),
            FormTextField(
              onChanged: context.read<RMLeaveApproveCubit>().updateRemarks,
              keyboardType: TextInputType.text,
              maxLines: 3,
              textInputAction: TextInputAction.done,
            ),
          ],
        );
      },
    );
  }

  Widget buildApproveOrRejectButton() {
    return BlocBuilder<RMLeaveApproveCubit, RMLeaveApproveState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        String text = '';
        if(leaveStatus == LeaveStatus.approved) {
          text = 'approve'.tr;
        } else if(leaveStatus == LeaveStatus.rejected) {
          text = 'reject'.tr;
        }
        return RaisedRectButton(
          buttonState: state.buttonState,
          text: text,
          onPressed: () {
            if(leave.holidayId != null && leaveStatus == LeaveStatus.approved) {
              context.read<RMLeaveApproveCubit>().approveHolidayLeave(leave.holidayId!);
            } else if(leave.holidayId != null && leaveStatus == LeaveStatus.rejected) {
              context.read<RMLeaveApproveCubit>().rejectHolidayLeave(leave.holidayId!);
            } else {
              context.read<RMLeaveApproveCubit>().approveOrDeclineLeave(leaveStatus);
            }

          },
        );
      },
    );
  }
}

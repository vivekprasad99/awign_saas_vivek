import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/utils/date_time_helper/date_time_helper.dart';
import 'package:awign_saas/core/utils/helper.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/buttons/raised_rect_button.dart';
import 'package:awign_saas/core/widget/common/form_text_field.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../hrms/rm/rm_regularisation/data/model/regularize_search_response.dart';
import '../../../../di/app_injection_container.dart';
import '../../../common/form_label_widget.dart';
import '../../../theme/dimens.dart';
import '../cubit/rm_regularise_approved_dialog_cubit.dart';
import '../cubit/rm_regularise_approved_dialog_state.dart';

showRMRegulariseApprovedDialog(
    BuildContext context, Regularization? regularization, bool isApproved) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) =>
        BlocProvider(
  create: (context) => RmRegulariseApprovedDialogCubit(sl()),
  child: RMRegulariseApprovedDialog(regularization!, isApproved),
),
  );
}

class RMRegulariseApprovedDialog extends StatelessWidget {
  final Regularization? regularization;
  final bool? isApproved;

  const RMRegulariseApprovedDialog(this.regularization, this.isApproved,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RmRegulariseApprovedDialogCubit>().updateButtonState(isApproved);
    return Dialog(
      elevation: Dimens.elevation_8,
      insetAnimationCurve: Curves.easeInOut,
      backgroundColor: Get.theme.getCustomColor(Get.context!).onPrimary100,
      insetPadding: const EdgeInsets.all(Dimens.padding_20),
      child: buildDialogContent(context),
    );
  }

  Widget buildDialogContent(BuildContext context) {
    return BlocConsumer<RmRegulariseApprovedDialogCubit,
        RmRegulariseApprovedDialogState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {
        if (state.uiState != null &&
            state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
          Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
        }
        if (state.uiState?.event == Event.success) {
          MRouter.pop(null);
          MRouter.pop(true);
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.margin_16, vertical: Dimens.margin_24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${'regularisations'.tr} ${isApproved! ? 'Approve' : 'Reject'}',
                    style: Get.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Get.theme
                            .getCustomColor(Get.context!)
                            .backgroundblack),
                  ),
                  MyInkWell(
                      onTap: () {
                        MRouter.pop(null);
                      },
                      child: SvgPicture.asset('assets/images/ic_close.svg'))
                ],
              ),
              const SizedBox(
                height: Dimens.margin_16,
              ),
              Visibility(
                  visible: isApproved!, child: buildPunchInTimeTextField()),
              const SizedBox(
                height: Dimens.margin_16,
              ),
              Visibility(
                  visible: isApproved!, child: buildPunchOutTimeTextField()),
              const SizedBox(
                height: Dimens.margin_16,
              ),
              buildRemarksTextField(),
              const SizedBox(
                height: Dimens.margin_8,
              ),
              buildReimbursementButtonWidgets(context),
            ],
          ),
        );
      },
    );
  }

  Widget buildPunchInTimeTextField() {
    String punchInTime = '';
    if(regularization?.getPunchInTime() != null) {
      String strTime = DateTimeHelper.getFormattedDateTime(inputDateTime: DateFormat(DateTimeHelper.timeFormatHMS).parse(regularization!.getPunchInTime()!), DateTimeHelper.timeFormatHMA);
      punchInTime = strTime;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'punch_in_time'.tr, requiredText: ''),
        const SizedBox(height: Dimens.padding_8),
        FormTextField(
          textEditingController: TextEditingController(
              text: punchInTime),
          onChanged: (String value) {},
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          hintText: '',
          errorText: null,
          readOnly: true,
        )
      ],
    );
  }

  Widget buildPunchOutTimeTextField() {
    String punchOutTime = '';
    if(regularization?.getPunchOutTime() != null) {
      String strTime = DateTimeHelper.getFormattedDateTime(inputDateTime: DateFormat(DateTimeHelper.timeFormatHMS).parse(regularization!.getPunchOutTime()!), DateTimeHelper.timeFormatHMA);
      punchOutTime = strTime;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'punch_out_time'.tr, requiredText: ''),
        const SizedBox(height: Dimens.padding_8),
        FormTextField(
          textEditingController: TextEditingController(
              text: punchOutTime),
          onChanged: (String value) {},
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          hintText: '',
          errorText: null,
          readOnly: true,
        )
      ],
    );
  }

  Widget buildRemarksTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: '${'remark_optional'.tr} ${isApproved! ? '(Optional)' : ''}', requiredText: isApproved! ? '' : '*'),
        const SizedBox(height: Dimens.padding_8),
        BlocBuilder<RmRegulariseApprovedDialogCubit, RmRegulariseApprovedDialogState>(
          buildWhen: (previousState, state) {
            if ((previousState.remarkError == null &&
                state.remarkError != null) ||
                (previousState.remarkError != null &&
                    state.remarkError == null)) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            return FormTextField(
              onChanged: context.read<RmRegulariseApprovedDialogCubit>().updateRemark,
              keyboardType: TextInputType.text,
              maxLines: 4,
              textInputAction: TextInputAction.done,
              hintText: 'Enter a reason',
              errorText: state.remarkError,
            );
          },
        )
      ],
    );
  }

  Widget buildReimbursementButtonWidgets(BuildContext context) {
    return BlocBuilder<RmRegulariseApprovedDialogCubit,
        RmRegulariseApprovedDialogState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
              0, Dimens.padding_24, 0, Dimens.padding_24),
          child: RaisedRectButton(
            backgroundColor: Get.theme.getCustomColor(context).secondary1300!,
            text: isApproved! ? 'approve'.tr : 'rejected'.tr,
            buttonState: state.buttonState,
            fontSize: Dimens.padding_16,
            onPressed: () {
              context
                  .read<RmRegulariseApprovedDialogCubit>()
                  .onApproveTap(regularization?.id, isApproved);
            },
          ),
        );
      },
    );
  }
}

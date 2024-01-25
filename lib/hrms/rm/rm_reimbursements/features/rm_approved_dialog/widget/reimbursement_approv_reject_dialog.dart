import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/utils/helper.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/buttons/raised_rect_button.dart';
import 'package:awign_saas/core/widget/common/form_label_widget.dart';
import 'package:awign_saas/core/widget/common/form_text_field.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../core/di/app_injection_container.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/widget/theme/theme_manager.dart';
import '../../../../../reimbursements/data/model/reimbursement_detail_response.dart';
import '../cubit/rm_approved_dialog_cubit.dart';
import '../cubit/rm_approved_dialog_state.dart';

showReimbursementApproveRejectDialog(BuildContext context,
    ReimbursementDetail? reimbursementDetail, bool isApproved) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) =>
        RMApproveRejectDialog(reimbursementDetail!, isApproved),
  );
}

class RMApproveRejectDialog extends StatelessWidget {
  final ReimbursementDetail? reimbursementDetail;
  final bool? isApproved;
  const RMApproveRejectDialog(this.reimbursementDetail, this.isApproved, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RmApprovedDialogCubit(sl()),
      child: Dialog(
        elevation: Dimens.elevation_8,
        insetAnimationCurve: Curves.easeInOut,
        backgroundColor: Get.theme.getCustomColor(Get.context!).onPrimary100,
        insetPadding: const EdgeInsets.all(Dimens.padding_16),
        child: buildDialogContent(context),
      ),
    );
  }

  Widget buildDialogContent(BuildContext context) {
    return BlocConsumer<RmApprovedDialogCubit, RmApprovedDialogState>(
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${'claim_approve'.tr} ${isApproved! ? 'approve'.tr : 'reject'.tr}',
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
                    visible: isApproved!, child: buildRequestAmtTextField()),
                const SizedBox(
                  height: Dimens.margin_16,
                ),
                Visibility(
                    visible: isApproved!, child: buildApprovedAmtTextField()),
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
          ),
        );
      },
    );
  }

  Widget buildRequestAmtTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'requested_amount'.tr, requiredText: ''),
        const SizedBox(height: Dimens.padding_8),
        FormTextField(
          textEditingController: TextEditingController(
              text: "${Constants.rs} ${reimbursementDetail?.amount}"),
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

  Widget buildApprovedAmtTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'approved_amount'.tr, requiredText: '*'),
        const SizedBox(height: Dimens.padding_8),
        BlocBuilder<RmApprovedDialogCubit, RmApprovedDialogState>(
          buildWhen: (previousState, state) {
            if ((previousState.amountError == null &&
                    state.amountError != null) ||
                (previousState.amountError != null &&
                    state.amountError == null)) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            return FormTextField(
              onChanged: context.read<RmApprovedDialogCubit>().updateAmount,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              errorText: state.amountError,
            );
          },
        )
      ],
    );
  }

  Widget buildRemarksTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(
            labelText:
                '${'remark_optional'.tr} ${isApproved! ? '(Optional)' : ''}',
            requiredText: isApproved! ? '' : '*'),
        const SizedBox(height: Dimens.padding_8),
        BlocBuilder<RmApprovedDialogCubit, RmApprovedDialogState>(
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
              onChanged: context.read<RmApprovedDialogCubit>().updateRemark,
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
    return BlocBuilder<RmApprovedDialogCubit, RmApprovedDialogState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
              0, Dimens.padding_24, 0, Dimens.padding_24),
          child: RaisedRectButton(
            backgroundColor: Get.theme.getCustomColor(context).secondary1300!,
            text: isApproved! ? 'approve'.tr : 'reject'.tr,
            buttonState: state.buttonState,
            fontSize: Dimens.padding_16,
            onPressed: () {
              context
                  .read<RmApprovedDialogCubit>()
                  .onApproveTap(reimbursementDetail?.expenseId, isApproved);
            },
          ),
        );
      },
    );
  }
}

import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/comp_off/data/model/comp_off.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/feature/rm_comp_off_details/widget/dialog/rm_comp_off_approve_reject_dialog/cubit/rm_comp_off_approve_reject_cubit.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/feature/rm_comp_off_details/widget/dialog/rm_comp_off_approve_reject_dialog/cubit/rm_comp_off_approve_reject_state.dart';
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

void showRMCompOffApproveRejectDialog(
    BuildContext context, CompOff compOff, CompOffStatus compOffStatus) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => BlocProvider(
      create: (context) => RMCompOffApproveRejectCubit(sl()),
      child: RMCompOffApproveRejectDialog(compOff, compOffStatus),
    ),
  );
}

class RMCompOffApproveRejectDialog extends StatelessWidget {
  final CompOff compOff;
  final CompOffStatus compOffStatus;

  const RMCompOffApproveRejectDialog(this.compOff, this.compOffStatus, {super.key});

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
    context.read<RMCompOffApproveRejectCubit>().updateLeave(compOff);
    return BlocConsumer<RMCompOffApproveRejectCubit, RMCompOffApproveRejectState>(
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
        if(state.compOff != null) {
          String strDate = '';
          if(state.compOff?.workDate != null) {
            strDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.compOff!.workDate!), DateTimeHelper.dateFormatDDMMMYYYY);
          }
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
                  buildDateWidgets(context, 'date'.tr, strDate),
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
    if(compOffStatus == CompOffStatus.accepted) {
      title = '${'comp_off'.tr} - ${'accept'.tr}';
    } else {
      title = '${'comp_off'.tr} - ${'reject'.tr}';
    }
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Get.textTheme.headlineSmall?.copyWith(fontSize: Dimens.font_20, fontWeight: FontWeight.w700),
    );
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
    return BlocBuilder<RMCompOffApproveRejectCubit, RMCompOffApproveRejectState>(
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
              onChanged: context.read<RMCompOffApproveRejectCubit>().updateRemarks,
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
    return BlocBuilder<RMCompOffApproveRejectCubit, RMCompOffApproveRejectState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        String text = '';
        if(compOffStatus == CompOffStatus.accepted) {
          text = 'accept'.tr;
        } else if(compOffStatus == CompOffStatus.rejected) {
          text = 'reject'.tr;
        }
        return RaisedRectButton(
          buttonState: state.buttonState,
          text: text,
          onPressed: () {
            context.read<RMCompOffApproveRejectCubit>().approveOrDeclineCompOff(compOffStatus);
          },
        );
      },
    );
  }
}

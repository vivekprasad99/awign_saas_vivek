import 'package:awign_saas/core/widget/divider/h_divider.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
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
import '../../../data/model/comp_off.dart';
import '../cubit/comp_off_details_cubit.dart';
import '../cubit/comp_off_details_state.dart';

class CompOffDetailsWidget extends StatelessWidget {
  final int compOffID;
  const CompOffDetailsWidget(this.compOffID, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CompOffDetailsCubit>().getCompOffDetails(compOffID);
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultAppBar(
              isBackIconVisible: true,
              title: 'comp_off_details'.tr,
            ),
            Expanded(
              child: InternetSensitive(
                child: BlocConsumer<CompOffDetailsCubit, CompOffDetailsState>(
                  listenWhen: (previous, current) {
                    return previous.uiState != current.uiState;
                  },
                  listener: (context, state) {
                    if(state.uiState != null && state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
                      Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
                    }
                    if(state.uiState?.event == Event.success) {
                      Helper.showSuccessAlertDialogWithOnTap(context, 'comp_off_cancelled_successfully'.tr, () {
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

  Widget buildBody(BuildContext context, CompOffDetailsState state) {
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
                  buildCompOffDetailsContainer(context, state),
                ],
              ),
            ),
          ),
        ),
        buildCancelCompOffButton(),
      ],
    );
  }

  Widget buildCompOffDetailsContainer(BuildContext context, CompOffDetailsState state) {
    var (String icon, String text, Color? bgColor) =
    switch (state.compOff!.status) {
      CompOffStatus.pending => ('assets/images/ic_pending.png', 'approval_pending'.tr,
      Get.theme.getCustomColor(context).warning250),
      CompOffStatus.accepted => ('assets/images/ic_approved.png', 'approval_successfully'.tr,
      Get.theme.getCustomColor(context).skirretgreen),
      CompOffStatus.rejected => ('assets/images/ic_rejected.png', 'application_rejected'.tr,
      Get.theme.colorScheme.error),
      CompOffStatus.withdraw => ('assets/images/ic_withdraw.png', 'cancelled_comp_off'.tr,
      Get.theme.getCustomColor(context).backgroundgrey800),
      _ => ('assets/images/ic_pending.png', 'approval_pending'.tr,
      Get.theme.getCustomColor(context).warning250),
    };
    String compOffDateLabel = 'date'.tr;
    String strDate = '';
    if(state.compOff?.workDate != null) {
      strDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.compOff!.workDate!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    String strAppliedOnDate = '';
    if(state.compOff?.createdAt != null) {
      strAppliedOnDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.compOff!.createdAt!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    String approvedOnLabel = '';
    String strApprovedOn = '';
    if(state.compOff?.updatedAt != null && state.compOff?.status == CompOffStatus.accepted) {
      approvedOnLabel = 'approved_on'.tr;
      strApprovedOn = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.compOff!.updatedAt!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    if(state.compOff?.updatedAt != null && state.compOff?.status == CompOffStatus.rejected) {
      approvedOnLabel = 'rejected_on'.tr;
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
                FormLabelWidget(labelText: compOffDateLabel, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                const SizedBox(height: Dimens.padding_4),
                buildAnswerValueWidget(context, strDate),
                const SizedBox(height: Dimens.padding_12),
                HDivider(dividerColor: Get.theme.getCustomColor(context).backgroundgrey400, verticalPadding: Dimens.padding_8),
                const SizedBox(height: Dimens.padding_12),
                FormLabelWidget(labelText: 'reason'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                const SizedBox(height: Dimens.padding_4),
                buildAnswerValueWidget(context, state.compOff!.employeeRemark ?? ''),
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
                buildAnswerValueWidget(context, state.compOff?.managerName ?? ''),
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

  Widget buildCancelCompOffButton() {
    return BlocBuilder<CompOffDetailsCubit, CompOffDetailsState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        if(state.compOff?.status == CompOffStatus.pending || state.compOff?.status == CompOffStatus.accepted) {
          return Padding(
            padding: const EdgeInsets.all(Dimens.padding_16),
            child: RaisedRectButton(
              buttonState: state.buttonState,
              text: 'cancel_comp_off'.tr,
              textColor: Get.theme.colorScheme.primary,
              backgroundColor: AppColors.transparent,
              borderColor: Get.theme.colorScheme.primary,
              onPressed: () {
                Helper.showConfirmAlertDialog(context, message: 'you_are_about_to_cancel_the_comp_off_request'.tr, onYesTap: () {
                  context.read<CompOffDetailsCubit>().withdrawCompOff(compOffID);
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
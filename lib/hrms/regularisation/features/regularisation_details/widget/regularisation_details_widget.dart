import 'package:awign_saas/core/widget/divider/h_divider.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
import '../../../data/model/regularisation_status_response.dart';
import '../cubit/regularisation_details_cubit.dart';
import '../cubit/regularisation_details_state.dart';

class RegularisationDetailsWidget extends StatelessWidget {
  final Regularisation regularisation;
  const RegularisationDetailsWidget(this.regularisation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RegularisationDetailsCubit>().updateRegularisation(regularisation);
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultAppBar(
              isBackIconVisible: true,
              title: 'regularisation_details'.tr,
            ),
            Expanded(
              child: InternetSensitive(
                child: BlocConsumer<RegularisationDetailsCubit, RegularisationDetailsState>(
                  listenWhen: (previous, current) {
                    return previous.uiState != current.uiState;
                  },
                  listener: (context, state) {
                    if(state.uiState != null && state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
                      Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
                    }
                    if(state.uiState?.event == Event.success) {
                      Helper.showSuccessAlertDialogWithOnTap(context, 'regularisation_cancelled_successfully'.tr, () {
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

  Widget buildBody(BuildContext context, RegularisationDetailsState state) {
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
        buildCancelRegularisationButton(),
      ],
    );
  }

  Widget buildLeaveDetailsContainer(BuildContext context, RegularisationDetailsState state) {
    var (String icon, String text, Color? bgColor) =
    switch (state.regularisation!.status) {
      RegularisationStatus.pending => ('assets/images/ic_pending.png', 'approval_pending'.tr,
      Get.theme.getCustomColor(context).warning250),
      RegularisationStatus.approved => ('assets/images/ic_approved.png', 'approval_successfully'.tr,
      Get.theme.getCustomColor(context).skirretgreen),
      RegularisationStatus.rejected => ('assets/images/ic_rejected.png', 'application_rejected'.tr,
      Get.theme.colorScheme.error),
      _ => ('assets/images/ic_pending.png', 'approval_pending'.tr,
      Get.theme.getCustomColor(context).warning250),
    };
    String strDate = '';
    if(state.regularisation?.date != null) {
      strDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.regularisation!.date!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    String punchInTime = '--:--';
    if(state.regularisation?.getPunchInTime() != null) {
      String strTime = DateTimeHelper.getFormattedDateTime(inputDateTime: DateFormat(DateTimeHelper.timeFormatHMS).parse(state.regularisation!.getPunchInTime()!),
          DateTimeHelper.timeFormatHMA);
      punchInTime = strTime;
    }
    String punchOutTime = '--:--';
    if(state.regularisation?.getPunchOutTime() != null) {
      String strTime = DateTimeHelper.getFormattedDateTime(inputDateTime: DateFormat(DateTimeHelper.timeFormatHMS).parse(state.regularisation!.getPunchOutTime()!),
          DateTimeHelper.timeFormatHMA);
      punchOutTime = strTime;
    }
    String strAppliedOnDate = '';
    if(state.regularisation?.createdAt != null) {
      strAppliedOnDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.regularisation!.createdAt!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    String labelUpdatedAt = switch(state.regularisation!.status) {
      RegularisationStatus.approved => 'approved_on'.tr,
      RegularisationStatus.rejected => 'rejected_on'.tr,
      _ => '',
    };
    String strApprovedOn = '';
    if(state.regularisation?.updatedAt != null && state.regularisation!.status != RegularisationStatus.pending) {
      strApprovedOn = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(state.regularisation!.updatedAt!), DateTimeHelper.dateFormatDDMMMYYYY);
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
                FormLabelWidget(labelText: 'date'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                const SizedBox(height: Dimens.padding_4),
                buildAnswerValueWidget(context, strDate),
                const SizedBox(height: Dimens.padding_12),
                HDivider(dividerColor: Get.theme.getCustomColor(context).backgroundgrey400, verticalPadding: Dimens.padding_8),
                const SizedBox(height: Dimens.padding_12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: 'punch_in_time'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, punchInTime),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: 'punch_out_time'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, punchOutTime),
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
                buildAnswerValueWidget(context, state.regularisation!.reasonComment ?? ''),
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
                          FormLabelWidget(labelText: labelUpdatedAt, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
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
                buildAnswerValueWidget(context, state.regularisation?.approval?.managerName ?? ''),
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

  Widget buildCancelRegularisationButton() {
    return BlocBuilder<RegularisationDetailsCubit, RegularisationDetailsState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        if(state.regularisation?.status == RegularisationStatus.pending) {
          return Padding(
            padding: const EdgeInsets.all(Dimens.padding_16),
            child: RaisedRectButton(
              buttonState: state.buttonState,
              text: 'delete'.tr,
              textColor: Get.theme.colorScheme.primary,
              backgroundColor: AppColors.transparent,
              borderColor: Get.theme.colorScheme.primary,
              onPressed: () {
                Helper.showConfirmAlertDialog(context, message: 'you_are_about_to_cancel_the_regularisation_request'.tr, onYesTap: () {
                  context.read<RegularisationDetailsCubit>().withdrawRegularisation();
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
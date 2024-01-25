import 'package:awign_saas/core/utils/date_time_helper/date_time_helper.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/regularisation/features/request_regularise/cubit/request_regularise_cubit.dart';
import 'package:awign_saas/hrms/regularisation/features/request_regularise/cubit/request_regularise_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/router/router.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../core/widget/buttons/my_ink_well.dart';
import '../../../../../core/widget/buttons/raised_rect_button.dart';
import '../../../../../core/widget/common/form_error_widget.dart';
import '../../../../../core/widget/common/form_label_widget.dart';
import '../../../../../core/widget/common/form_text_field.dart';
import '../../../../../core/widget/dialog/loading/app_circular_progress_indicator.dart';
import '../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../../reimbursements/data/model/manager_response.dart';
import '../../../data/model/request_regularize_widget_argument.dart';

class RequestRegulariseWidget extends StatelessWidget {
  final RequestRegularizeWidgetArgument requestRegularizeWidgetArgument;
  const RequestRegulariseWidget(this.requestRegularizeWidgetArgument, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RequestRegulariseCubit>().getManagers();
    context.read<RequestRegulariseCubit>().updateRequestRegularizeWidgetArgument(requestRegularizeWidgetArgument);
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultAppBar(
              isBackIconVisible: true,
              title: 'regularise_now'.tr,
            ),
            Expanded(
              child: InternetSensitive(
                child: BlocConsumer<RequestRegulariseCubit, RequestRegulariseState>(
                  listenWhen: (previous, current) {
                    return previous.uiState != current.uiState;
                  },
                  listener: (context, state) {
                    if(state.uiState != null && state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
                      Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
                    }
                    if(state.uiState?.event == Event.success) {
                      Helper.showSuccessAlertDialogWithOnTap(context, 'regularisation_requested_successfully'.tr, () {
                        MRouter.pop(true);
                        MRouter.pushNamedAndRemoveUntil(MRouter.dashboardWidget);
                        MRouter.pushNamed(MRouter.regularisationDashboardWidget);
                      });
                    }
                  },
                  buildWhen: (previous, state) {
                    return (state.uiState?.event == Event.reloadWidget &&
                        previous.uiState != state.uiState);
                  },
                  builder: (context, state) {
                    if (state.uiState?.isOnScreenLoading ?? false) {
                      return const AppCircularProgressIndicator();
                    } else {
                      return buildBody(context);
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

  Widget buildBody(BuildContext context) {
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
                  buildFormContainer(context),
                ],
              ),
            ),
          ),
        ),
        buildRequestRegularisationButton(),
      ],
    );
  }

  Widget buildFormContainer(BuildContext context) {
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
          const SizedBox(height: Dimens.padding_16),
          buildSelectDateWidgets(context),
          const SizedBox(height: Dimens.padding_16),
          buildPunchInTimeWidget(),
          const SizedBox(height: Dimens.padding_16),
          buildPunchOutTimeWidget(),
          const SizedBox(height: Dimens.padding_16),
          buildSelectApproverWidgets(),
          const SizedBox(height: Dimens.padding_16),
          buildReasonFieldWidget(),
        ],
      ),
    );
  }

  Widget buildSelectDateWidgets(BuildContext context) {
    return BlocBuilder<RequestRegulariseCubit, RequestRegulariseState>(
      buildWhen: (prevState, curState) {
        return prevState.date != curState.date;
      },
      builder: (context, state) {
        String? selectedDate;
        if(state.date != null) {
          selectedDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatDDMMMYYYY, inputDateTime: state.date);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormLabelWidget(labelText: 'date'.tr, requiredText: '*'),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (selectedDate == null)
                      ? FormLabelWidget(
                          labelText: 'select_date'.tr,
                          textColor: Theme.of(context)
                              .getCustomColor(context)
                              .backgroundgrey700)
                      : Text(selectedDate,
                          style: Get.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildPunchInTimeWidget() {
    return BlocBuilder<RequestRegulariseCubit, RequestRegulariseState>(
      buildWhen: (prev, cur) {
        return (prev.punchInTimeOfDay != cur.punchInTimeOfDay || prev.punchInTimeError != cur.punchInTimeError);
      },
      builder: (context, state) {
        String? punchInTime;
        if(state.punchInTimeOfDay != null) {
          punchInTime = MaterialLocalizations.of(context).formatTimeOfDay(state.punchInTimeOfDay!);
        }
        return buildPunchTimeWidgets(context, 'punch_in_time'.tr, punchInTime, state.punchInTimeError, () async {
            TimeOfDay? timeOfDay = await DateTimeHelper.showTimePickerDialog(context);
            if (timeOfDay != null) {
              context.read<RequestRegulariseCubit>().updatePunchInTimeOfDate(timeOfDay);
            }
        });
      },
    );
  }

  Widget buildPunchOutTimeWidget() {
    return BlocBuilder<RequestRegulariseCubit, RequestRegulariseState>(
      buildWhen: (prev, cur) {
        return (prev.punchOutTimeOfDay != cur.punchOutTimeOfDay || prev.punchOutTimeError != cur.punchOutTimeError);
      },
      builder: (context, state) {
        String? punchOutTime;
        if(state.punchOutTimeOfDay != null) {
          punchOutTime = MaterialLocalizations.of(context).formatTimeOfDay(state.punchOutTimeOfDay!);
        }
        return buildPunchTimeWidgets(context, 'punch_out_time'.tr, punchOutTime, state.punchOutTimeError, () async {
          TimeOfDay? timeOfDay = await DateTimeHelper.showTimePickerDialog(context);
          if (timeOfDay != null) {
            context.read<RequestRegulariseCubit>().updatePunchOutTimeOfDate(timeOfDay);
          }
        });
      },
    );
  }

  Widget buildPunchTimeWidgets(BuildContext context, String label, String? selectedTime, String? errorText, Function onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: label, requiredText: '*'),
        const SizedBox(height: Dimens.padding_8),
        MyInkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
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
            child: (selectedTime == null)
                ? FormLabelWidget(
                labelText: label,
                textColor: Theme.of(context)
                    .getCustomColor(context)
                    .backgroundgrey700)
                : Text(selectedTime,
                style: Get.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500)),
          ),
        ),
        const SizedBox(height: Dimens.padding_8),
        FormErrorWidget(errorText: errorText),
      ],
    );
  }

  Widget buildSelectApproverWidgets() {
    return BlocBuilder<RequestRegulariseCubit, RequestRegulariseState>(
      builder: (context, selectedApplyingState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormLabelWidget(
                labelText: 'approver'.tr, requiredText: '*'),
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
              padding: const EdgeInsets.fromLTRB(
                  Dimens.padding_12, 0, Dimens.padding_12, 0),
              child: DropdownButton<Manager>(
                isExpanded: true,
                value: selectedApplyingState.selectedManager,
                hint: FormLabelWidget(labelText: 'select_approvar'.tr, textColor: Theme.of(context)
                    .getCustomColor(context)
                    .backgroundgrey700),
                icon: SvgPicture.asset(
                  'assets/images/ic_drop_down_blue.svg',
                ),
                underline: const SizedBox(),
                onChanged: (Manager? manager) {
                  context.read<RequestRegulariseCubit>().updateSelectedManager(manager);
                },
                items: selectedApplyingState.managers!
                    .map<DropdownMenuItem<Manager>>((Manager value) {
                  return DropdownMenuItem<Manager>(
                    value: value,
                    child: Text(value.name!,
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildReasonFieldWidget() {
    return BlocBuilder<RequestRegulariseCubit, RequestRegulariseState>(
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
            FormLabelWidget(labelText: 'reason'.tr, requiredText: '*'),
            const SizedBox(height: Dimens.padding_8),
            FormTextField(
              onChanged: context.read<RequestRegulariseCubit>().updateReason,
              keyboardType: TextInputType.emailAddress,
              maxLines: 3,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: Dimens.padding_8),
            FormErrorWidget(errorText: state.reasonError),
          ],
        );
      },
    );
  }

  Widget buildRequestRegularisationButton() {
    return BlocBuilder<RequestRegulariseCubit, RequestRegulariseState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.padding_16),
          child: RaisedRectButton(
            buttonState: state.buttonState,
            text: 'submit'.tr,
            onPressed: () {
              context.read<RequestRegulariseCubit>().requestRegularisation(context);
            },
          ),
        );
      },
    );
  }
}

import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/utils/date_time_helper/date_time_helper.dart';
import 'package:awign_saas/core/utils/helper.dart';
import 'package:awign_saas/core/utils/string_utils.dart';
import 'package:awign_saas/core/widget/app_bar/default_app_bar.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/buttons/raised_rect_button.dart';
import 'package:awign_saas/core/widget/common/form_label_widget.dart';
import 'package:awign_saas/core/widget/common/form_text_field.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/manager_response.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements_form/cubit/reimbursement_form_cubit.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements_form/cubit/reimbursement_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/config/cubit/flavor_cubit.dart';
import '../../../../../core/utils/file_utils.dart';
import '../../../../../core/widget/dialog/loading/app_circular_progress_indicator.dart';
import '../../../../../core/widget/dialog/loading/app_linear_progress_indicator.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../data/model/reimbursement_type_response.dart';

class ReimbursementFormWidget extends StatelessWidget {
  const ReimbursementFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ReimbursementFormCubit>().getReimbursementCategories();
    context.read<ReimbursementFormCubit>().getReimbursementTypes();
    getManager(context);
    return AppScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultAppBar(
              isBackIconVisible: true,
              title: 'reimbursements'.tr,
            ),
            Expanded(
                child: InternetSensitive(
                  child: BlocConsumer<ReimbursementFormCubit,
                      ReimbursementFormState>(
                    listenWhen: (previous, current) {
                      return previous.uiState != current.uiState;
                    },
                    listener: (context, state) {
                      if (state.uiState != null && state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
                        Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
                      }
                      if (state.uiState?.event == Event.success) {
                        Helper.showSuccessAlertDialogWithOnTap(context, 'claim_request_initiated_successfully'.tr, () {
                              MRouter.pop(true);
                            });
                      }
                    },
                    buildWhen: (prevState, curState) {
                      return (prevState.isReimbursementTypesLoading != curState.isReimbursementTypesLoading
                      || prevState.isReimbursementCategoriesLoading != curState.isReimbursementCategoriesLoading
                          || prevState.isManagersLoading != curState.isManagersLoading);
                    },
                    builder: (context, state) {
                      if((state.isReimbursementTypesLoading ?? false)
                          || (state.isReimbursementCategoriesLoading ?? false)
                        || (state.isManagersLoading ?? false)) {
                        return const AppCircularProgressIndicator();
                      } else {
                        return buildBody(context);
                      }
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimens.padding_16,
          right: Dimens.padding_16,
          top: Dimens.padding_16,
          bottom: Dimens.padding_16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.padding_16),
                  color: Get.theme.getCustomColor(context).secondary1100!,
                ),
                padding: const EdgeInsets.only(
                    left: Dimens.padding_16,
                    right: Dimens.padding_16,
                    top: Dimens.padding_16,
                    bottom: Dimens.padding_16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimens.padding_16),
                    buildSelectLeaveReimbursementTypeWidgets(context),
                    buildSelectReimbursementSubTypeWidgets(context),
                    buildMetadataWidgets(context),
                    buildSelectFromDateWidgets(),
                    buildSelectToDateWidgets(),
                    const SizedBox(height: Dimens.padding_16),
                    buildReceiptTextField('receipt_no'.tr, false, 1, ""),
                    const SizedBox(height: Dimens.padding_16),
                    buildAmountTextField('amount'.tr, true, 1, ""),
                    const SizedBox(height: Dimens.padding_16),
                    buildFilePicker(context),
                    const SizedBox(height: Dimens.padding_16),
                    buildSelectApplyingToWidgets(context, 'applying_to'.tr, true, 'please_picks'.tr),
                    const SizedBox(height: Dimens.padding_16),
                    buildRemarksTextField('remarks'.tr, false, 3, 'enter_a_reason'.tr),
                    const SizedBox(height: Dimens.padding_16),
                  ],
                ),
              ),
            ),
          ),
          buildReimbursementButtonWidgets(context),
        ],
      ),
    );
  }

  Widget buildSelectLeaveReimbursementTypeWidgets(BuildContext context) {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previous, state) {
        return (previous.reimbursementTypes != state.reimbursementTypes
            || previous.selectedReimbursementType != state.selectedReimbursementType);
      },
      builder: (context, state) {
        return Visibility(
          visible: state.reimbursementTypes != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabelWidget(labelText: 'types_of_claim'.tr, requiredText: '*'),
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
                child: DropdownButton<ReimbursementType>(
                  isExpanded: true,
                  value: state.selectedReimbursementType,
                  hint: FormLabelWidget(labelText: 'please_pick'.tr,
                      textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                  icon: SvgPicture.asset(
                    'assets/images/ic_drop_down_blue.svg',
                  ),
                  underline: const SizedBox(),
                  onChanged: (ReimbursementType? selectedItem) {
                    context.read<ReimbursementFormCubit>().updateSelectedReimbursementType(selectedItem);
                  },
                  items: state.reimbursementTypes?.map<DropdownMenuItem<ReimbursementType>>(
                          (ReimbursementType reimbursementType) {
                        return DropdownMenuItem<ReimbursementType>(
                          value: reimbursementType,
                          child: Text(reimbursementType.type?.toCapitalized() ?? '',
                              style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSelectReimbursementSubTypeWidgets(BuildContext context) {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previous, state) {
        return (previous.reimbursementTypes != state.reimbursementTypes
            || previous.reimbursementSubTypes != state.reimbursementSubTypes
            || previous.selectedReimbursementSubType != state.selectedReimbursementSubType);
      },
      builder: (context, state) {
        return Visibility(
          visible: state.reimbursementSubTypes != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.padding_16),
              FormLabelWidget(labelText: state.reimbursementTypes != null
                  ? 'sub_types_of_claim'.tr : 'types_of_claim'.tr, requiredText: '*'),
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
                child: DropdownButton<ReimbursementSubType>(
                  isExpanded: true,
                  value: state.selectedReimbursementSubType,
                  hint: FormLabelWidget(labelText: 'please_pick'.tr,
                      textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                  icon: SvgPicture.asset(
                    'assets/images/ic_drop_down_blue.svg',
                  ),
                  underline: const SizedBox(),
                  onChanged: (ReimbursementSubType? selectedItem) {
                    context
                        .read<ReimbursementFormCubit>()
                        .updateSelectedReimbursementSubType(selectedItem);
                  },
                  items: state.reimbursementSubTypes?.map<DropdownMenuItem<ReimbursementSubType>>(
                          (ReimbursementSubType reimbursementSubType) {
                        return DropdownMenuItem<ReimbursementSubType>(
                          value: reimbursementSubType,
                          child: Text(reimbursementSubType.subType?.toCapitalized() ?? '',
                              style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildMetadataWidgets(BuildContext context) {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previous, state) {
        return (previous.selectedReimbursementSubType != state.selectedReimbursementSubType);
      },
      builder: (context, state) {
        return Visibility(
          visible: state.selectedReimbursementSubType?.metadata?.isMetadataFieldsAvailable() ?? false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDateOfTravelTextFieldWidget(),
              buildVendorNameTextFieldWidget(),
              buildFromDestinationTextFieldWidget(),
              buildStayLocationTextFieldWidget(),
              buildStayDateTextFieldWidget(),
              buildToDestinationTextFieldWidget(),
              buildDistanceTravelledTextFieldWidget(),
            ],
          ),
        );
      },
    );
  }

  Widget buildDateOfTravelTextFieldWidget() {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previousState, state) {
        if ((previousState.dateOfTravel == null && state.dateOfTravel != null) ||
            (previousState.dateOfTravel != null && state.dateOfTravel == null)
            || (previousState.selectedReimbursementSubType != state.selectedReimbursementSubType)) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Visibility(
          visible: state.selectedReimbursementSubType?.metadata?.dateOfTravel != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.padding_16),
              FormLabelWidget(labelText: 'date_of_travel'.tr),
              const SizedBox(height: Dimens.padding_8),
              FormTextField(
                onChanged: context.read<ReimbursementFormCubit>().updateDateOfTravel,
                keyboardType: TextInputType.text,
                maxLines: 1,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildVendorNameTextFieldWidget() {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previousState, state) {
        if ((previousState.vendorName == null && state.vendorName != null) ||
            (previousState.vendorName != null && state.vendorName == null)
            || (previousState.selectedReimbursementSubType != state.selectedReimbursementSubType)) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Visibility(
          visible: state.selectedReimbursementSubType?.metadata?.vendorName != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.padding_16),
              FormLabelWidget(labelText: 'vendor_name'.tr),
              const SizedBox(height: Dimens.padding_8),
              FormTextField(
                onChanged: context.read<ReimbursementFormCubit>().updateVendorName,
                keyboardType: TextInputType.text,
                maxLines: 1,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildFromDestinationTextFieldWidget() {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previousState, state) {
        if ((previousState.fromDestination == null && state.fromDestination != null) ||
            (previousState.fromDestination != null && state.fromDestination == null)
            || (previousState.selectedReimbursementSubType != state.selectedReimbursementSubType)) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Visibility(
          visible: state.selectedReimbursementSubType?.metadata?.fromDestination != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.padding_16),
              FormLabelWidget(labelText: 'from_destination'.tr),
              const SizedBox(height: Dimens.padding_8),
              FormTextField(
                onChanged: context.read<ReimbursementFormCubit>().updateFromDestination,
                keyboardType: TextInputType.text,
                maxLines: 1,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildStayLocationTextFieldWidget() {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previousState, state) {
        if ((previousState.stayLocation == null && state.stayLocation != null) ||
            (previousState.stayLocation != null && state.stayLocation == null)
            || (previousState.selectedReimbursementSubType != state.selectedReimbursementSubType)) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Visibility(
          visible: state.selectedReimbursementSubType?.metadata?.stayLocation != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.padding_16),
              FormLabelWidget(labelText: 'stay_location'.tr),
              const SizedBox(height: Dimens.padding_8),
              FormTextField(
                onChanged: context.read<ReimbursementFormCubit>().updateStayLocation,
                keyboardType: TextInputType.text,
                maxLines: 1,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildStayDateTextFieldWidget() {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previousState, state) {
        if ((previousState.stayDate == null && state.stayDate != null) ||
            (previousState.stayDate != null && state.stayDate == null)
            || (previousState.selectedReimbursementSubType != state.selectedReimbursementSubType)) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Visibility(
          visible: state.selectedReimbursementSubType?.metadata?.stayDate != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.padding_16),
              FormLabelWidget(labelText: 'stay_date'.tr),
              const SizedBox(height: Dimens.padding_8),
              FormTextField(
                onChanged: context.read<ReimbursementFormCubit>().updateStayDate,
                keyboardType: TextInputType.text,
                maxLines: 1,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildToDestinationTextFieldWidget() {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previousState, state) {
        if ((previousState.toDestination == null && state.toDestination != null) ||
            (previousState.toDestination != null && state.toDestination == null)
            || (previousState.selectedReimbursementSubType != state.selectedReimbursementSubType)) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Visibility(
          visible: state.selectedReimbursementSubType?.metadata?.toDestination != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.padding_16),
              FormLabelWidget(labelText: 'to_destination'.tr),
              const SizedBox(height: Dimens.padding_8),
              FormTextField(
                onChanged: context.read<ReimbursementFormCubit>().updateToDestination,
                keyboardType: TextInputType.text,
                maxLines: 1,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDistanceTravelledTextFieldWidget() {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previousState, state) {
        if ((previousState.distanceTravelled == null && state.distanceTravelled != null) ||
            (previousState.distanceTravelled != null && state.distanceTravelled == null)
            || (previousState.selectedReimbursementSubType != state.selectedReimbursementSubType)) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Visibility(
          visible: state.selectedReimbursementSubType?.metadata?.distanceTravelled != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.padding_16),
              FormLabelWidget(labelText: 'distance_travelled'.tr),
              const SizedBox(height: Dimens.padding_8),
              FormTextField(
                onChanged: context.read<ReimbursementFormCubit>().updateDistanceTravelled,
                keyboardType: TextInputType.text,
                maxLines: 1,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSelectFromDateWidgets() {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previous, state) {
        return previous.fromSelectedDate != state.fromSelectedDate;
      },
      builder: (context, fromDateSelectedState) {
        // return buildSelectDateWidgets(context, 'from_date'.tr, () {
        return buildSelectDateWidgets(context, 'claim_date'.tr, () {
              onDateTap(context, 'from');
            }, fromDateSelectedState.fromSelectedDate);
      },
    );
  }

  Widget buildSelectToDateWidgets() {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previous, state) {
        return (previous.toSelectedDate != state.toSelectedDate ||
            previous.selectedReimbursementCategory != state.selectedReimbursementCategory);
      },
      builder: (context, toDateSelectedState) {
        if (toDateSelectedState.selectedReimbursementCategory?.reimbursementSubType == 'telecom') {
          return buildSelectDateWidgets(context, 'to_date'.tr, () {
                onDateTap(context, 'to');
              }, toDateSelectedState.toSelectedDate);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildSelectApplyingToWidgets(
      BuildContext context, String name, bool isCompulsory, String hintText) {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      builder: (context, selectedApplyingState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormLabelWidget(labelText: name, requiredText: isCompulsory ? '*' : ''),
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
              padding: const EdgeInsets.fromLTRB(Dimens.padding_12, 0, Dimens.padding_12, 0),
              child: DropdownButton<Manager>(
                isExpanded: true,
                value: selectedApplyingState.manager,
                hint: FormLabelWidget(labelText: hintText,
                    textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                icon: SvgPicture.asset(
                  'assets/images/ic_drop_down_blue.svg',
                ),
                // elevation: 16,
                underline: const SizedBox(),
                onChanged: (Manager? manager) {
                  context.read<ReimbursementFormCubit>().selectManager(
                        manager!,
                      );
                },
                items: selectedApplyingState.managerResponse?.manager!
                    .map<DropdownMenuItem<Manager>>((Manager value) {
                  return DropdownMenuItem<Manager>(
                    value: value,
                    child: Text(value.name!, style: Get.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600)),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildSelectDateWidgets(BuildContext context, String labelText,
      Function onTap, DateTime? selectedDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Dimens.padding_16),
        FormLabelWidget(labelText: labelText, requiredText: '*'),
        const SizedBox(height: Dimens.padding_8),
        MyInkWell(
          onTap: onTap,
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
                (selectedDate == null)
                    ? FormLabelWidget(labelText: 'select_date'.tr,
                    textColor: Theme.of(context).getCustomColor(context).backgroundgrey700)
                    : Text(StringUtils.parseDateTimeToDate(selectedDate,
                    dateFormat: StringUtils.dateFormatDDMMMMYYYYWithoutComma),
                        style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                SvgPicture.asset(
                  'assets/images/ic_calendar.svg',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFilePicker(BuildContext context) {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previous, state) {
        return (previous.fileName != state.fileName);
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormLabelWidget(labelText: 'supporting_images_or_documents'.tr),
            FormLabelWidget(labelText: 'maximum_mb_each'.tr),
            const SizedBox(height: Dimens.padding_8),
             MyInkWell(
                  onTap: () {
                    FlavorCubit flavorCubit = context.read<FlavorCubit>();
                    context.read<ReimbursementFormCubit>().onSelectPDFTap(flavorCubit);
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
                    child: Row(
                      children: [
                        const SizedBox(width: Dimens.padding_8),
                        Expanded(child: Text(state.fileName ?? "", maxLines: 1,
                          overflow: TextOverflow.ellipsis,)),
                        Container(
                          decoration: BoxDecoration(
                            color: Get.theme.getCustomColor(context).primarymainContainer,
                            borderRadius: const BorderRadius.all(Radius.circular(Dimens.radius_8)),
                          ),
                          padding: const EdgeInsets.fromLTRB(Dimens.padding_12, Dimens.padding_12,
                              Dimens.padding_12, Dimens.padding_12),
                          child: Text('choose_files'.tr,
                            style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,
                                color: Get.theme.getCustomColor(context).secondary1300),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            buildFileUploadingWidgets(context),
          ],
        );
      },
    );
  }

  Widget buildFileUploadingWidgets(BuildContext context) {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (prevState, curState) {
        return (prevState.fileName != curState.fileName
        || prevState.uploadPercentValue != curState.uploadPercentValue
        || prevState.uploadProgressValue != curState.uploadProgressValue);
      },
      builder: (context, state) {
        return Visibility(
          visible: state.fileName != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.padding_8),
              AppLinearProgressIndicator(
                  value: state.uploadProgressValue ?? 0,
                  minHeight: Dimens.linearCircularIndicatorHeight_4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${state.uploadPercentValue}%', style: Get.textTheme.bodySmall
                        ?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey700),
                  ),
                  buildFileSizeText(context, state),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildFileSizeText(BuildContext context, ReimbursementFormState state) {
    var (String uploadedSizeInBytes, String totalSizeInBytes) = FileUtils.getFileUploadedSizeAndTotalSize(
        state.filePath ?? '', state.totalFileSize ?? 0, state.uploadPercentValue ?? 0);
    return Text(
      '$uploadedSizeInBytes/$totalSizeInBytes',
      style: Get.textTheme.bodySmall?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey700),
    );
  }

  Widget buildReceiptTextField(
      String name, bool isCompulsory, int maxLines, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: name, requiredText: isCompulsory ? '*' : ''),
        const SizedBox(height: Dimens.padding_8),
        BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
          buildWhen: (previousState, state) {
            if ((previousState.amountError == null && state.amountError != null)
                || (previousState.amountError != null && state.amountError == null)) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            return FormTextField(
              onChanged: context.read<ReimbursementFormCubit>().updateReceipt,
              keyboardType: TextInputType.text,
              maxLines: maxLines,
              textInputAction: TextInputAction.done,
              hintText: hintText,
              errorText: state.receiptNoError,
            );
          },
        )
      ],
    );
  }

  Widget buildAmountTextField(
      String name, bool isCompulsory, int maxLines, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: name, requiredText: isCompulsory ? '*' : ''),
        const SizedBox(height: Dimens.padding_8),
        BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
          buildWhen: (previousState, state) {
            if ((previousState.amountError == null && state.amountError != null)
                || (previousState.amountError != null && state.amountError == null)) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            return FormTextField(
              onChanged: context.read<ReimbursementFormCubit>().updateAmount,
              keyboardType: TextInputType.number,
              maxLines: maxLines,
              textInputAction: TextInputAction.done,
              hintText: hintText,
              errorText: state.amountError,
            );
          },
        )
      ],
    );
  }

  Widget buildRemarksTextField(
      String name, bool isCompulsory, int maxLines, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: name, requiredText: isCompulsory ? '*' : ''),
        const SizedBox(height: Dimens.padding_8),
        BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
          buildWhen: (previousState, state) {
            if ((previousState.remarkError == null && state.remarkError != null)
                || (previousState.remarkError != null && state.remarkError == null)) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            return FormTextField(
              onChanged: context.read<ReimbursementFormCubit>().updateRemark,
              keyboardType: TextInputType.text,
              maxLines: maxLines,
              textInputAction: TextInputAction.done,
              hintText: hintText,
              errorText: state.remarkError,
            );
          },
        )
      ],
    );
  }

  Widget buildReimbursementButtonWidgets(BuildContext context) {
    return BlocBuilder<ReimbursementFormCubit, ReimbursementFormState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0,
              Dimens.padding_24, 0, Dimens.padding_24),
          child: RaisedRectButton(
            backgroundColor: Get.theme.getCustomColor(context).secondary1300!,
            text: 'apply'.tr,
            buttonState: state.buttonState,
            fontSize: Dimens.padding_16,
            onPressed: () {
              context.read<ReimbursementFormCubit>().onApplyTap();
            },
          ),
        );
      },
    );
  }

  Future<void> onDateTap(BuildContext context, String label) async {
    DateTime? selectedDateTime = await DateTimeHelper.showDatePickerDialog(
        context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023, 5),
        lastDate: DateTime.now());
    if (selectedDateTime != null) {
      context.read<ReimbursementFormCubit>().selectDate(selectedDateTime, label);
    }
  }

  void getManager(BuildContext context) {
    String? id = UserPreferences.getInstance().getCurrentUser()?.tenant?.userId ?? '';
    context.read<ReimbursementFormCubit>().getManager(id ?? "");
  }
}

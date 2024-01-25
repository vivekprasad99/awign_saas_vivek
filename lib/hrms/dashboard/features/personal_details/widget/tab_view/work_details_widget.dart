import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/data/local/database/user_preferences/user_preferences.dart';
import '../../../../../../core/widget/common/form_error_widget.dart';
import '../../../../../../core/widget/common/form_label_widget.dart';
import '../../../../../../core/widget/common/form_text_field.dart';
import '../../../../../../core/widget/theme/theme_manager.dart';
import '../../../../../auth/data/model/employee_details.dart';

class WorkDetailsWidget extends StatelessWidget {
  final EmployeeDetails? employeeDetails;
  const WorkDetailsWidget(this.employeeDetails,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildFormContainer(context);
  }

  Widget buildFormContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16, vertical: Dimens.padding_24),
      child: DottedBorder(
        color: Get.theme.getCustomColor(context).secondary1200!,
        strokeWidth: Dimens.border_1,
        radius: const Radius.circular(Dimens.radius_8),
        dashPattern: const [8, 8],
        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16, vertical: Dimens.padding_24),
        child: Column(
          children: [
            buildTypeOfEmployee(),
            const SizedBox(height: Dimens.padding_16),
            buildTeamWidget(),
            const SizedBox(height: Dimens.padding_16),
            buildEmailIDTextFieldWidget(),
            const SizedBox(height: Dimens.padding_16),
            buildRegionalManager(),
            const SizedBox(height: Dimens.padding_16),
            buildShiftWidgets(),
            const SizedBox(height: Dimens.padding_16),
            buildDOBTextFieldWidget(),
          ],
        ),
      ),
    );
  }

  Widget buildTypeOfEmployee() {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = UserPreferences.getInstance().getCurrentUser()?.userType ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'type_of_employee'.tr),
        const SizedBox(height: Dimens.padding_8),
        FormTextField(
          textEditingController: textEditingController,
          enabled: false,
          onChanged: (v) {},
          keyboardType: TextInputType.text,
          maxLines: 1,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: Dimens.padding_8),
        const FormErrorWidget(errorText: null),
      ],
    );
  }

  Widget buildTeamWidget() {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = UserPreferences.getInstance().getCurrentUser()?.tenant?.name ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'team'.tr),
        const SizedBox(height: Dimens.padding_8),
        FormTextField(
          textEditingController: textEditingController,
          enabled: false,
          onChanged: (v) {},
          keyboardType: TextInputType.text,
          maxLines: 1,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: Dimens.padding_8),
        const FormErrorWidget(errorText: null),
      ],
    );
  }

  Widget buildEmailIDTextFieldWidget() {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = UserPreferences.getInstance().getCurrentUser()?.email ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'email_id'.tr),
        const SizedBox(height: Dimens.padding_8),
        FormTextField(
          textEditingController: textEditingController,
          enabled: false,
          onChanged: (v) {},
          keyboardType: TextInputType.text,
          maxLines: 1,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: Dimens.padding_8),
        const FormErrorWidget(errorText: null),
      ],
    );
  }

  Widget buildRegionalManager() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'reporting_manager'.tr),
        const SizedBox(height: Dimens.padding_8),
        FormTextField(
          enabled: false,
          onChanged: (v) {},
          keyboardType: TextInputType.text,
          maxLines: 1,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: Dimens.padding_8),
        const FormErrorWidget(errorText: null),
      ],
    );
  }

  Widget buildShiftWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'shift'.tr),
        const SizedBox(height: Dimens.padding_8),
        FormTextField(
          enabled: false,
          onChanged: (v) {},
          keyboardType: TextInputType.text,
          maxLines: 1,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: Dimens.padding_8),
        const FormErrorWidget(errorText: null),
      ],
    );
  }

  Widget buildDOBTextFieldWidget() {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = employeeDetails?.dateOfJoining ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'doj'.tr),
        const SizedBox(height: Dimens.padding_8),
        FormTextField(
          enabled: false,
          textEditingController: textEditingController,
          onChanged: (v) {},
          keyboardType: TextInputType.text,
          maxLines: 1,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: Dimens.padding_8),
        const FormErrorWidget(errorText: null),
      ],
    );
  }
}
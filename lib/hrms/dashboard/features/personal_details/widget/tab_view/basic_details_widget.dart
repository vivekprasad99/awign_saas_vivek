import 'package:awign_saas/hrms/auth/data/model/employee_details.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/data/local/database/user_preferences/user_preferences.dart';
import '../../../../../../core/widget/common/form_error_widget.dart';
import '../../../../../../core/widget/common/form_label_widget.dart';
import '../../../../../../core/widget/common/form_text_field.dart';
import '../../../../../../core/widget/theme/theme_manager.dart';

class BasicDetailsWidget extends StatelessWidget {
  final EmployeeDetails? employeeDetails;
  const BasicDetailsWidget(this.employeeDetails,{Key? key}) : super(key: key);

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
            buildEmployeeNameTextFieldWidget(),
            const SizedBox(height: Dimens.padding_16),
            buildEmployeeIDTextFieldWidget(),
            const SizedBox(height: Dimens.padding_16),
            buildEmailIDTextFieldWidget(),
            const SizedBox(height: Dimens.padding_16),
            buildGenderTextFieldWidget(),
            const SizedBox(height: Dimens.padding_16),
            buildContactNumberTextFieldWidget(),
            const SizedBox(height: Dimens.padding_16),
            buildDOBTextFieldWidget(),
          ],
        ),
      ),
    );
  }

  Widget buildEmployeeNameTextFieldWidget() {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = UserPreferences.getInstance().getCurrentUser()?.name ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'employee_name'.tr),
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

  Widget buildEmployeeIDTextFieldWidget() {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = employeeDetails?.employeeId ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'employee_id'.tr),
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

  Widget buildGenderTextFieldWidget() {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = employeeDetails?.gender ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'gender'.tr),
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

  Widget buildContactNumberTextFieldWidget() {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = employeeDetails?.mobile ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'contact_number'.tr),
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

  Widget buildDOBTextFieldWidget() {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = employeeDetails?.dateOfJoining ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: 'dob'.tr),
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

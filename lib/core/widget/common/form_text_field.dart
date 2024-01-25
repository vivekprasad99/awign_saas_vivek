import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final Function? onChanged;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final String? hintText;
  final String? errorText;
  final bool? enabled;
  final bool? readOnly;

  const FormTextField({this.textEditingController,
    this.focusNode,
    this.onChanged,
    this.keyboardType,
    this.maxLines,
    this.textInputAction,
    this.prefixIcon,
    this.hintText,
    this.errorText,
    this.enabled,
    this.readOnly = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: textEditingController,
      focusNode: focusNode,
      readOnly: readOnly!,
      onChanged: (v) {
        if (onChanged != null) {
          onChanged!(v);
        }
      },
      keyboardType: keyboardType,
      maxLines: maxLines,
      textInputAction: textInputAction,
      style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Get.theme.colorScheme.background,
        contentPadding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_12, Dimens.padding_16, Dimens.padding_12),
        hintText: hintText,
        hintStyle: Get.textTheme.labelLarge?.copyWith(
            color: Theme.of(context).getCustomColor(context).backgroundgrey700,
            fontWeight: FontWeight.w500),
        errorText: errorText,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              const BorderRadius.all(Radius.circular(Dimens.radius_8)),
          borderSide: BorderSide(
              color: Theme.of(context).getCustomColor(context).secondary1200!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              const BorderRadius.all(Radius.circular(Dimens.radius_8)),
          borderSide: BorderSide(color: Get.theme.colorScheme.primary),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius:
          const BorderRadius.all(Radius.circular(Dimens.radius_8)),
          borderSide: BorderSide(
              color: Theme.of(context).getCustomColor(context).secondary1200!),
        ),
      ),
    );
  }
}

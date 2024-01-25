import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/color_schemes.g.dart';

class FormLabelWidget extends StatelessWidget {
  final String labelText;
  final String requiredText;
  late Color? textColor;
  FormLabelWidget({required this.labelText, this.requiredText = '', this.textColor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textColor ??= Theme.of(context).getCustomColor(context).backgroundblack;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Get.textTheme.labelLarge?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w500),
        children: <TextSpan>[
          TextSpan(
            text: labelText,
          ),
          TextSpan(
            text: ' $requiredText',
            style: Get.textTheme.labelLarge?.copyWith(
                color: Get.theme.colorScheme.error,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

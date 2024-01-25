import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/color_schemes.g.dart';

class FormErrorWidget extends StatelessWidget {
  final String? errorText;
  const FormErrorWidget({required this.errorText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(errorText != null) {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Get.textTheme.labelMedium?.copyWith(
              color: Get.theme.colorScheme.error),
          children: <TextSpan>[
            TextSpan(
              text: errorText,
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

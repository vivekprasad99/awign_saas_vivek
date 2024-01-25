import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme_manager.dart';

class HDivider extends StatelessWidget {
  Color? dividerColor;
  double? dividerThickness;
  double? horizontalPadding;
  double? verticalPadding;

  HDivider({Key? key, this.dividerColor, this.dividerThickness, this.horizontalPadding, this.verticalPadding})
      : super(key: key) {
    dividerColor ??= Get.theme.dividerColor;
    dividerThickness ??= Dimens.dividerHeight_1;
    horizontalPadding ??= 0;
    verticalPadding ??= 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding!, vertical: verticalPadding!),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: dividerColor,
              thickness: dividerThickness,
              height: dividerThickness,
            ),
          ),
        ],
      ),
    );
  }
}

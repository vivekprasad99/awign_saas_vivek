import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../core/widget/theme/dimens.dart';

class IndicatorWidget extends StatelessWidget {
  final bool isActive;

  const IndicatorWidget(this.isActive, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: Dimens.margin_4),
          height: Dimens.indicatorSize_10,
          width: Dimens.indicatorSize_10,
          decoration: BoxDecoration(
              border: Border.all(
                width: Dimens.border_1,
                color: isActive
                    ? Get.theme.colorScheme.primary
                    : Get.theme.colorScheme.primaryContainer,
                style: BorderStyle.solid,
              ),
              borderRadius:
                  const BorderRadius.all(Radius.circular(Dimens.radius_12))),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: Dimens.margin_4),
          height: Dimens.indicatorSize_4,
          width: Dimens.indicatorSize_4,
          decoration: BoxDecoration(
              border: Border.all(
                width: Dimens.border_1,
                color: isActive
                    ? Get.theme.colorScheme.primary
                    : Get.theme.colorScheme.primaryContainer,
                style: BorderStyle.solid,
              ),
              color: isActive
                  ? Get.theme.colorScheme.primary
                  : Get.theme.colorScheme.primaryContainer,
              borderRadius:
                  const BorderRadius.all(Radius.circular(Dimens.radius_12))),
        ),
      ],
    );
  }
}

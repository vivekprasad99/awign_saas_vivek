import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/filter_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainFilterOptionTile extends StatelessWidget {
  final int index;
  final FilterOption filterOption;
  final Function(BuildContext, int, FilterOption) onFilterOptionTap;
  const MainFilterOptionTile({required this.index, required this.filterOption, required this.onFilterOptionTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyInkWell(
      onTap: () {
        onFilterOptionTap(context, index, filterOption);
      },
      child: Container(
        color: (filterOption.isSelected ?? false) ? Get.theme.getCustomColor(context).backgroundwhite : Get.theme.colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildLabel(context),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(BuildContext context) {
    String label = filterOption.label ?? '';
    return Padding(
      padding: const EdgeInsets.all(Dimens.padding_16),
      child: Text(label,
          style: Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
    );
  }
}

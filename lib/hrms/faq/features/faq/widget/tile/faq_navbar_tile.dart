import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/widget/buttons/my_ink_well.dart';
import '../../../../data/model/faq_navbar_data.dart';

class FaqNavbarTile extends StatelessWidget {
  final int index;
  final NavBarData navBarData;
  final Function(int index, NavBarData navBarData,BuildContext context) onNavBarTapped;
  const FaqNavbarTile({Key? key,required this.navBarData,required this.index,required this.onNavBarTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyInkWell(
      onTap: () {
        onNavBarTapped(index, navBarData,context);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          Dimens.padding_16,
          Dimens.padding_8,
          Dimens.padding_16,
          Dimens.padding_8,
        ),
        margin: const EdgeInsets.symmetric(horizontal: Dimens.padding_4),
        decoration: BoxDecoration(
            color: navBarData.isSelected ? Get.theme.getCustomColor(context).secondary1300! : Get.theme.getCustomColor(context).sourceBackgroundwhite!,
            borderRadius: BorderRadius.circular(Dimens.radius_32),
            border: Border.all(
              color: Get.theme.getCustomColor(context).secondary1300!,
              width: 2,
            )),
        child: Center(
          child: Text(
            navBarData.navBarItem ?? "",
            style: Get.context?.textTheme.titleMedium?.copyWith(
                color:navBarData.isSelected ? Get.theme.getCustomColor(context).sourceBackgroundwhite! : Get.theme.getCustomColor(context).secondary1300!,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

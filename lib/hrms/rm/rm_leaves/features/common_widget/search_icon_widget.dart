import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/widget/theme/theme_manager.dart';

class SearchIconWidget extends StatelessWidget {
  final Function onTap;
  const SearchIconWidget({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimens.margin_8),
      child: MyInkWell(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.padding_8),
              border: Border.all(
                color: Get.theme.getCustomColor(context).secondary1200!,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Dimens.padding_12),
              child: SvgPicture.asset('assets/images/ic_search.svg'),
            )),
      ),
    );
  }
}

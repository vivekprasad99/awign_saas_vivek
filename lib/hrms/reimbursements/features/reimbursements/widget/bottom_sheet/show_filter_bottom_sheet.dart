import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/buttons/raised_rect_button.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../../core/router/router.dart';
import '../../../../../../core/widget/theme/dimens.dart';

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimens.radius_16),
        topRight: Radius.circular(Dimens.radius_16),
      ),
    ),
    builder: (_) {
      return const FilterBottomSheet();
    },
  );
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.padding_16),
        color: Get.theme.getCustomColor(context).secondary1200!,
      ),
      padding: const EdgeInsets.fromLTRB(
        Dimens.padding_16,
        Dimens.padding_32,
        Dimens.padding_16,
        Dimens.padding_48,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyInkWell(
            onTap: (){
              MRouter.pop(null);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(
                'assets/images/ic_close.svg',
              ),
            ),
          ),
          const SizedBox(height: Dimens.padding_8),
          buildFilterTextFieldWidget('types_of_claim'.tr,'assets/images/ic_arrow_down.svg',true,'select_claim_type'.tr),
          const SizedBox(height: Dimens.padding_8),
          buildFilterTextFieldWidget('from_date'.tr,'assets/images/ic_calendar.svg',false,'select_date'.tr),
          const SizedBox(height: Dimens.padding_8),
          buildFilterTextFieldWidget('to_date'.tr,'assets/images/ic_calendar.svg',false,'select_date'.tr),
          const SizedBox(height: Dimens.padding_16),
          buildFilterButtonWidgets()
        ],
      ),
    );
  }

  Widget buildFilterTextFieldWidget(String name,String img,bool isCompulsory,String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(name, style: Get.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,color: Get.theme.getCustomColor(Get.context!).sourceBackgroundblack
            )),
            Visibility(
              visible: isCompulsory,
              child: Text(' *', style: Get.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,color: Get.theme.colorScheme.error
              )),
            ),
          ],
        ),
        Card(
          elevation: 0.2,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Get.theme.getCustomColor(context).secondary1200!,
            ),
            borderRadius: BorderRadius.circular(Dimens.padding_8),
          ),
          color: Get.theme.colorScheme.onPrimary,
          surfaceTintColor: Get.theme.colorScheme.onPrimary,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.padding_16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(hintText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Get.theme.getCustomColor(Get.context!).backgroundgrey700
                    )),
                SvgPicture.asset(
                  img,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFilterButtonWidgets()
  {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          Dimens.padding_12, 0, Dimens.padding_12, 0),
      child: RaisedRectButton(
        backgroundColor: Get.theme.getCustomColor(context).secondary1300!,
        text: 'request_reimbursement'.tr,
        fontSize: Dimens.padding_16,
        onPressed: () {},
      ),
    );
  }
}

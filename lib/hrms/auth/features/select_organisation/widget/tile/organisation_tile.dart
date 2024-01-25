import 'package:awign_saas/core/data/local/database/model/current_user/tenant.dart';
import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../../core/widget/image_loader/network_image_loader.dart';

class OrganisationTile extends StatelessWidget {
  final int index;
  final Tenant tenant;
  final Function(BuildContext, int, Tenant) onTenantTap;
  const OrganisationTile({required this.index, required this.tenant, required this.onTenantTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyInkWell(
      onTap: () {
        onTenantTap(context, index, tenant);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.padding_8),
          color: (tenant.isSelected ?? false) ? Get.theme.getCustomColor(context).secondary1200 : Get.theme.getCustomColor(context).backgroundwhite,
          border: Border.all(
            color: (tenant.isSelected ?? false) ? Get.theme.getCustomColor(context).secondary1200! : Get.theme.getCustomColor(context).backgroundgrey400!,
          ),
        ),
        padding: const EdgeInsets.all(Dimens.padding_16),
        child: Row(
          children: [
            buildOrganisationLogo(),
            const SizedBox(width: Dimens.padding_16),
            buildTenantName(),
          ],
        ),
      ),
    );
  }

  Widget buildOrganisationLogo() {
    if(tenant.logoUrl != null) {
      return NetworkImageLoader(
        url: tenant.logoUrl!,
        width: Dimens.iconSize_40,
        height: Dimens.iconSize_40,
        filterQuality: FilterQuality.high,
        fit: BoxFit.cover,
      );
    } else {
      return SvgPicture.asset(
        'assets/images/ic_circular_profile_place_holder.svg',
        width: Dimens.iconSize_40,
        height: Dimens.iconSize_40,
      );
    }
  }

  Widget buildTenantName() {
    return Text(tenant.name ?? '', style: Get.textTheme.titleMedium);
  }

}

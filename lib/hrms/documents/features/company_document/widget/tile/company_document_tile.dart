import 'package:awign_saas/core/utils/date_time_helper/date_time_helper.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:awign_saas/hrms/documents/data/model/document_search_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PoliciesTile extends StatelessWidget {
  final Documents documents;
  const PoliciesTile({Key? key,required this.documents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.padding_8),
        color: Get.theme.colorScheme.onPrimary,
        border: Border.all(
          color: Get.theme.getCustomColor(context).backgroundgrey400!,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal:Dimens.padding_16),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: Dimens.padding_4),
        leading: SvgPicture.asset(
          'assets/images/pdf_logo.svg',
        ),
        title: Text("${documents.name}",
          style: Get.textTheme.bodyMedium?.copyWith(
              color: Get.theme.getCustomColor(context).backgroundgrey900!,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

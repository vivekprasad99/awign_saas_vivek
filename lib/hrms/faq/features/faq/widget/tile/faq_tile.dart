import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/hrms/faq/data/model/faq_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class FaqTile extends StatelessWidget {
  final Faqs faqs;
  const FaqTile({Key? key,required this.faqs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: AppColors.transparent),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.symmetric(horizontal: 0),
        tilePadding: const EdgeInsets.symmetric(horizontal: 0),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        maintainState: true,
        title: Text(faqs.title ?? "",
        ),
        children: <Widget>[
          Html(data: faqs.description,),
        ],
      ),
    );
  }
}

import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/utils/helper.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/data/local/database/user_preferences/user_preferences.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildDrawerHeader(),
          buildHomeWidget(context),
          buildReimbursementsWidget(context),
          buildLogoutWidget(context),
        ],
      ),
    );
  }

  Widget buildDrawerHeader() {
    return Container(
      height: Dimens.navDrawerHeight_150,
      color: Get.theme.colorScheme.primary,
      padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_72, Dimens.padding_16, Dimens.padding_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(UserPreferences.getInstance().getCurrentUser()?.name ?? '', style: Get.textTheme.bodyLarge?.copyWith(color: Get.theme.colorScheme.onPrimary)),
          Text(UserPreferences.getInstance().getCurrentUser()?.email ?? '', style: Get.textTheme.bodyMedium?.copyWith(color: Get.theme.colorScheme.onPrimary)),
        ],
      ),
    );
  }

  Widget buildHomeWidget(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.home,
      ),
      title: Text('home'.tr),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget buildReimbursementsWidget(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.home,
      ),
      title: Text('reimbursements'.tr),
      onTap: () {
        Navigator.pushNamed(context,MRouter.reimbursementsWidget);
      },
    );
  }

  Widget buildLogoutWidget(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.logout,
      ),
      title: Text('logout'.tr),
      onTap: () {
        Helper.doLogout();
      },
    );
  }
}

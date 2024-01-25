import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/app_bar/tenant_app_bar.dart';
import '../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../core/widget/safe_area/responsive_safe_area.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return AppScaffold(
      topPadding: 0,
      body: const Column(
        children: [
          TenantAppBar(
              isTenantLogoVisible: true, isTenantNameVisible: true),
          Expanded(
            child: InternetSensitive(
              child: Center(child: Text('Coming soon...')),
            ),
          ),
        ],
      ),
    );
  }
}

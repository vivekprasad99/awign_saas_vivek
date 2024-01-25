import 'package:flutter/material.dart';

import '../scaffold/app_scaffold.dart';
import '../theme/theme_manager.dart';

class MobileOnDesktopWidget extends StatelessWidget {
  final Widget mobileWidget;
  const MobileOnDesktopWidget(this.mobileWidget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: SizedBox(
          width: Dimens.mobileWidth,
          height: Dimens.mobileHeight,
          child: mobileWidget,
        ),
      ),
    );
  }
}

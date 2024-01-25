import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme_manager.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return buildUI(context);
  }

  Widget buildUI(BuildContext context) {
    Color valueColor = Get.theme.colorScheme.primary;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(valueColor),
            backgroundColor: Theme.of(context).getCustomColor(context).secondary1200,
          ),
          const SizedBox(height: Dimens.margin_8),
          //Text('Loading...', style: Styles.body1TextStyle)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme_manager.dart';

class AppLinearProgressIndicator extends StatelessWidget {
  final double value;
  final Color? backgroundColor;
  final Color? valueColor;
  final double minHeight;
  const AppLinearProgressIndicator({this.value = 0, this.backgroundColor, this.valueColor,
    this.minHeight = Dimens.linearCircularIndicatorHeight_8, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildUI(context);
  }

  Widget buildUI(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(valueColor ?? Get.theme.getCustomColor(context).success400!),
            backgroundColor: backgroundColor ?? Get.theme.getCustomColor(context).backgroundgrey500!,
            value: value,
            minHeight: minHeight,
          ),
          const SizedBox(height: Dimens.margin_8),
          //Text('Loading...', style: Styles.body1TextStyle)
        ],
      ),
    );
  }
}

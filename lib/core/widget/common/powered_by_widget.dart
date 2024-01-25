import 'package:flutter/material.dart';

import '../theme/dimens.dart';

class PoweredByWidget extends StatelessWidget {
  final Color? color;
  const PoweredByWidget({this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.padding_16),
        child: Image.asset(
          'assets/images/powered_by_randstad.png',
          color: color,
          width: Dimens.imageWidth_150,
          height: Dimens.imageHeight_20,
        ),
      ),
    );
  }
}

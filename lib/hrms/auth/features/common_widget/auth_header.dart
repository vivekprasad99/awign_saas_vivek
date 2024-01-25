import 'package:flutter/material.dart';
import '../../../../core/widget/theme/theme_manager.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_24, Dimens.padding_14, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/auth_header_logo_r_talent.png', width: Dimens.imageWidth_200, height: Dimens.imageHeight_40),
        ],
      ),
    );
  }
}

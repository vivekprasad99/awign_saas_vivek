import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/router/router.dart';
import '../../../../../../core/widget/buttons/raised_rect_button.dart';
import '../../../../../../core/widget/theme/theme_manager.dart';

void showAttendanceSuccessBottomSheet(BuildContext context, {Function? whenComplete}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimens.radius_16),
        topRight: Radius.circular(Dimens.radius_16),
      ),
    ),
    builder: (_) {
      return const AttendanceSuccessWidget();
    },
  ).whenComplete(() {
    if(whenComplete != null) {
      whenComplete();
    }
  });
}

class AttendanceSuccessWidget extends StatefulWidget {
  const AttendanceSuccessWidget({Key? key}) : super(key: key);

  @override
  State<AttendanceSuccessWidget> createState() =>
      AttendanceSuccessWidgetState();
}

class AttendanceSuccessWidgetState
    extends State<AttendanceSuccessWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.radius_16),
          topRight: Radius.circular(Dimens.radius_16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                Dimens.padding_16, Dimens.padding_24, Dimens.padding_16, 0),
            child: SvgPicture.asset('assets/images/ic_verify.svg'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                Dimens.padding_16, Dimens.padding_16, Dimens.padding_16, 0),
            child: Text(
              'attendance_captured_successfully'.tr,
              textAlign: TextAlign.center,
              style: Get.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          buildOKButton(),
        ],
      ),
    );
  }

  Widget buildOKButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          Dimens.padding_32, Dimens.padding_24, Dimens.padding_32, Dimens.padding_32),
      child: RaisedRectButton(
        text: 'ok'.tr,
        onPressed: () {
          MRouter.pop(null);
        },
      ),
    );
  }
}

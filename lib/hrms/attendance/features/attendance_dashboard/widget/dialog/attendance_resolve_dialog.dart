import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../../core/router/router.dart';
import '../../../../../../core/widget/buttons/my_ink_well.dart';
import '../../../../../../core/widget/buttons/raised_rect_button.dart';
import '../../../../../../core/widget/dialog/custom_dialog.dart';
import '../../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../../core/widget/theme/theme_manager.dart';

void showResolveAttendanceDialog(
    BuildContext context, {required Function onRegulariseTap, required Function onMarkAsLeaveTap}) {
  showDialog<bool>(
    context: context,
    builder: (_) => CustomDialog(
      child: AttendanceResolveDialog(onRegulariseTap, onMarkAsLeaveTap),
    ),
  );
}

class AttendanceResolveDialog extends StatelessWidget {
  final Function onRegulariseTap;
  final Function onMarkAsLeaveTap;

  const AttendanceResolveDialog(this.onRegulariseTap, this.onMarkAsLeaveTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternetSensitive(
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.padding_8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildCloseIcon(),
          buildRegulariseButton(),
          buildMarkAsLeaveButton(),
        ],
      ),
    );
  }

  Widget buildCloseIcon() {
    return Align(
      alignment: Alignment.topRight,
      child: MyInkWell(
        onTap: () {
          MRouter.pop(null);
        },
        child: Padding(
          padding: const EdgeInsets.all(Dimens.padding_16),
          child: SvgPicture.asset('assets/images/ic_close_dialog.svg'),
        ),
      ),
    );
  }

  Widget buildRegulariseButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_24, Dimens.padding_16, Dimens.padding_24, 0),
      child: RaisedRectButton(
        text: 'regularise'.tr,
        onPressed: () async {
          MRouter.pop(null);
          onRegulariseTap();
        },
      ),
    );
  }

  Widget buildMarkAsLeaveButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_24, Dimens.padding_16, Dimens.padding_24, Dimens.padding_48),
      child: RaisedRectButton(
        backgroundColor: AppColors.transparent,
        borderColor: Get.theme.colorScheme.primary,
        textColor: Get.theme.colorScheme.primary,
        text: 'mark_as_leave'.tr,
        onPressed: () async {
          MRouter.pop(null);
          onMarkAsLeaveTap();
        },
      ),
    );
  }
}

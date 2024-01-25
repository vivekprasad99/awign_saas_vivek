import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../widget/dialog/alert_dialog/success_alert_dialog.dart';
import '../widget/dialog/confirm_dialog/confirm_alert_dialog.dart';
import '../widget/dialog/loading/app_progress_dialog.dart';
import '../widget/theme/theme_manager.dart';

enum ConfirmAction { CANCEL, OK }

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

class Helper {
  static AppProgressDialog? pr;

  static double getToolbarStatusBarHeightWithMarginTop(BuildContext context) {
    return Dimens.toolbarHeight;
  }

  static double getToolbarStatusBarHeight(BuildContext context) {
    return Dimens.toolbarHeight + 1;
  }

  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static showLoadingDialog(BuildContext context, String message) {
    if (pr != null && pr!.isShowing()) {
    } else {
      pr = AppProgressDialog(context, ProgressDialogType.Normal);
      pr!.showLoadingDialog(message);
    }
  }

  static hideLoadingDialog() {
    if (pr != null && pr!.isShowing()) {
      pr!.hide();
    }
  }

  static void showAlertDialog(BuildContext c, String heading,
      {String? body, String textOKBtn = 'OK'}) {
    if (body == null) {
      showDialog(
        context: c,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              heading,
              style: c.textTheme.bodyText1,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text(textOKBtn),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: c,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(heading, style: c.textTheme.bodyText1),
            content: Text(body, style: c.textTheme.bodyText1),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.transparent,
                ),
                onPressed: () => {
                  Navigator.of(context).pop(),
                },
                child: Text(
                  textOKBtn,
                  style: context.textTheme.bodyText1?.copyWith(
                      color: context.theme.iconColorHighlighted,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  static void showSuccessAlertDialogWithOnTap(
      BuildContext context, String message, VoidCallback onTap) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => SuccessAlertDialog(message, onTap),
    );
  }

  static void showConfirmAlertDialog(
      BuildContext context, {String? title, String? message, bool isYesPrimaryButton = false, VoidCallback? onYesTap, VoidCallback? onNoTap}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => ConfirmAlertDialog(title: title, message: message, isYesPrimaryButton: isYesPrimaryButton, onYesTap: onYesTap, onNoTap: onNoTap),
    );
  }

  static Future<ConfirmAction?> asyncConfirmDialog(
      BuildContext context, String body,
      {String heading = 'Alert',
      String textOKBtn = 'Ok',
      String textCancelBtn = 'CANCEL'}) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(heading, style: context.textTheme.bodyText1),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.transparent,
              ),
              onPressed: () => {
                Navigator.of(context).pop(ConfirmAction.CANCEL),
              },
              child: Text(
                textCancelBtn,
                style: context.textTheme.bodyText1?.copyWith(
                    color: context.theme.iconColorHighlighted,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.transparent,
              ),
              onPressed: () => {
                Navigator.of(context).pop(ConfirmAction.OK),
              },
              child: Text(
                textOKBtn,
                style: context.textTheme.bodyText1?.copyWith(
                    color: context.theme.iconColorHighlighted,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showSnackBar(String message) {
    /*_scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
    ));*/
    Get.snackbar('', message);
  }

  static void showSnackBarWithAction(
    String message,
    String actionLabel,
    VoidCallback onTap, {
    int duration = 3,
  }) {
    Get.showSnackbar(GetSnackBar(
      messageText: Text(message),
      duration: Duration(seconds: duration),
      // action: SnackBarAction(label: actionLabel, onPressed: onTap),
    ));
  }

  static void showInfoToast(String message, {Color? color}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:
            color.isBlank! ? Get.theme.toastBackgroundColor : color,
        textColor: Get.theme.toastTextColor,
        fontSize: Dimens.font_16);
  }

  static void showErrorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.error400,
        textColor: AppColors.backgroundWhite,
        fontSize: Dimens.font_16);
  }

  static hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now().toLocal();
    final difference = date2.difference(date);

    if (difference.inSeconds < 5) {
      return 'Just now';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes <= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours <= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inHours < 60) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays <= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inDays < 6) {
      return '${difference.inDays} days ago';
    } else if ((difference.inDays / 7).ceil() <= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if ((difference.inDays / 7).ceil() < 4) {
      return '${(difference.inDays / 7).ceil()} weeks ago';
    } else if ((difference.inDays / 30).ceil() <= 1) {
      return (numericDates) ? '1 month ago' : 'Last month';
    } else if ((difference.inDays / 30).ceil() < 30) {
      return '${(difference.inDays / 30).ceil()} months ago';
    } else if ((difference.inDays / 365).ceil() <= 1) {
      return (numericDates) ? '1 year ago' : 'Last year';
    }
    return '${(difference.inDays / 365).floor()} years ago';
  }

  static String addCountryCodeInContactNumber(String number) {
    if (number != null && number.startsWith('+44')) {
      return number;
    } else if (number != null && number.startsWith('0')) {
      var result = number.replaceFirst('0', '+44');
      return result;
    } else if (number != null) {
      return '+44$number';
    } else {
      return '';
    }
  }

  static doLogout() async {
      UserPreferences.getInstance().clearUserPreferences();
      MRouter.pushNamedAndRemoveUntil(MRouter.loginViaMobileWidget);
  }

  static clearUserData() async {

  }
}

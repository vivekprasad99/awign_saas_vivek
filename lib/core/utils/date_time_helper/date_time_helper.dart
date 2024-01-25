import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  static const String dateTimeFormatDMYHMSA = "dd-MM-yyyy hh:mm:ss a";
  static const String dateTimeFormatYMDHM = "yyyy-MM-dd HH:mm";
  static const String dateTimeFormatYMDHMS = "yyyy-MM-dd HH:mm:ss";
  static const String dateTimeFormatYMDHMSA = "yyyy-MM-dd hh:mm:ss a";
  static const String dateTimeFormatDMYHMA = "dd-MM-yyyy hh:mm a";
  static const String dateTimeFormatYMDTHMSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";
  static const String dateTimeFormatYMDTHMSX = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX";
  static const String dateTimeFormatYMDTHMSS = "yyyy-MM-dd'T'HH:mm:ss.sss";
  static const String dateTimeFormatYMDHMSZ = "yyyy-MM-dd HH:mm:ss Z";
  static const String dateTimeFormatEDMY = "EEEE, dd MMM, yyyy";
  static const String dateTimeFormatDMHMA = "dd MMMM, hh:mm a";
  static const String dateTimeFormatYMDhMS = "yyyy-MM-dd hh:mm:ss";

  static const String dateFormatD = "dd";
  static const String dateFormatE = "EEE";
  static const String dateFormatEEEE = "EEEE";
  static const String dateFormatMMM = "MMM";
  static const String dateFormatYMD = "yyyy-MM-dd";
  static const String dateFormatDMY = "dd-MM-yyyy";
  static const String dateFormatDMYS = "dd/MM/yyyy";
  static const String dateFormatMY = "MMM yyyy";
  static const String dateFormatDDMMMYYYY = "dd MMM yyyy";
  static const String dateFormatDDMMMMYYYY = "dd MMMM, yyyy";

  static const String timeFormatHMS = "HH:mm:ss";
  static const String timeFormatHM = "HH:mm";
  static const String timeFormatMS = "mm:ss";
  static const String timeFormatHMA = "hh:mm a";

  static const String prettyDateTimeFormatE = "EEEE";

  static String getFormattedDateTime(String outputFormat,
      {DateTime? inputDateTime}) {
    inputDateTime ??= DateTime.now();
    var outputDateFormat = DateFormat(outputFormat);
    return outputDateFormat.format(inputDateTime);
  }

  static Future<DateTime?> showDatePickerDialog(BuildContext context,
      {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    DateTime currentDate = DateTime.now();
    initialDate ??= currentDate;
    firstDate ??= currentDate;
    lastDate ??= DateTime(currentDate.year + 1, currentDate.month,
        currentDate.day, currentDate.hour, currentDate.minute);
    DateTime? pickedDate = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    return pickedDate;
  }

  static Future<TimeOfDay?> showTimePickerDialog(BuildContext context,
      {TimeOfDay? initialTime}) async {
    initialTime ??= TimeOfDay.now();
    TimeOfDay? timeOfDay =
        await showTimePicker(context: context, initialTime: initialTime);
    return timeOfDay;
  }

  static String? getNextWeekDay(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  static (String hour, String minute, String second) convertSecondsToHMS(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();

    String minuteLeft =
    m.toString().length < 2 ? "0$m" : m.toString();

    String secondsLeft =
    s.toString().length < 2 ? "0$s" : s.toString();

    String result = "$hourLeft:$minuteLeft:$secondsLeft";

    return (hourLeft, minuteLeft, secondsLeft);
  }
}

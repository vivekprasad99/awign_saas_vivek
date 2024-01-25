import 'package:intl/intl.dart';

import 'app_log.dart';

class StringUtils {
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

  static const String dateFormatYMD = "yyyy-MM-dd";
  static const String dateFormatDMY = "dd-MM-yyyy";
  static const String dateFormatDMYS = "dd/MM/yyyy";
  static const String dateFormatMY = "MMM yyyy";
  static const String dateFormatDDMMMYYYY = "dd MMM, yyyy";
  static const String dateFormatDDMMMMYYYY = "dd MMMM, yyyy";
  static const String dateFormatDDMMMMYYYYWithoutComma = "dd MMMM yyyy";

  static const String timeFormatHMS = "HH:mm:ss";
  static const String timeFormatHM = "HH:mm";
  static const String timeFormatMS = "mm:ss";
  static const String timeFormatHMA = "hh:mm a";

  static const String prettyDateTimeFormatE = "EEEE";

  static String getIndianFormatNumber(number) {
    final formatter = NumberFormat.decimalPattern();
    return formatter.format(number);
  }

  static String convertDigitsToString(int n) => n.toString().padLeft(2, '0');

  static String maskString(String? input, int fromStart, int fromEnd) {
    String result = "";
    if (input != null) {
      int length = input.length;
      if (fromStart > length) {
        fromStart = length;
      }
      String openStart = input.substring(0, fromStart);

      int endStartIndex = length - fromEnd;
      if (endStartIndex < fromStart) {
        endStartIndex = fromStart;
      }
      String openEnd = input.substring(endStartIndex, length);

      int rem = length - (openStart.length + openEnd.length);
      result += openStart;
      for (int i = 0; i < rem; i++) {
        result += "x";
      }
      result += openEnd;
    }
    return result;
  }

  static String getFormattedDateTime(String outputFormat,
      {DateTime? inputDateTime}) {
    inputDateTime ??= DateTime.now();
    var outputDateFormat = DateFormat(outputFormat);
    return outputDateFormat.format(inputDateTime);
  }

  static String parseDateTimeToDate(DateTime dateTime,{String? dateFormat})
  {
    final DateFormat outputDateFormat = DateFormat(dateFormat);
    final String formattedDate = outputDateFormat.format(dateTime);
    return formattedDate;
  }

  static String parseSlashDateToDate(String date)
  {
    DateFormat inputFormat = DateFormat('yyyy/MM/dd');
    DateTime slashDate = inputFormat.parse(date);

    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    String normalDate = outputFormat.format(slashDate);
    return normalDate;
  }
}

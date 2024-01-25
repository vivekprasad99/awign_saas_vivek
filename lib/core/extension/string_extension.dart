import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../data/model/advance_search/operator.dart';
import '../utils/app_log.dart';
import '../utils/string_utils.dart';

extension StringExtension on String {
  static final RegExp invalidRegExp = RegExp('([^a-zA-Z0-9-_\\/.])');

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String reverse([String pattern = ""]) =>
      split(pattern).reversed.join(pattern) ?? "";

  String dashAfter3() {
    String temp1 = this;
    String op = '';
    for (int i = 0; i < temp1.length; i++) {
      if (i % 3 == 0 && i != 0 && i + 3 <= temp1.length) {
        op += '-${temp1[i]}';
      } else {
        op += temp1[i];
      }
    }
    return op;
  }

  String getDateWithMonthName() {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(this);
    var outputFormat = DateFormat('dd MMMM, yyyy');
    return outputFormat.format(inputDate);
  }

  String getDateWithDDMMMYYYYFormat() {
    var inputDate = DateTime.parse(this);
    var outputFormat = DateFormat(StringUtils.dateFormatYMD);
    return outputFormat.format(inputDate);
  }

  String getPrettyWeekDay() {
    try {
      var dateTime = DateTime.parse(this);
      var today = DateTime.now();
      var tomorrow = DateTime(today.year, today.month, today.day + 1);
      if (dateTime.day == today.day) {
        return 'today'.tr;
      } else if (dateTime == tomorrow) {
        return 'tomorrow'.tr;
      } else {
        return DateFormat(StringUtils.prettyDateTimeFormatE).format(dateTime);
      }
    } catch (e, st) {
      AppLog.e('getPrettyWeekDay : ${e.toString()} \n${st.toString()}');
    }
    return '';
  }

  Operator? getOperatorByName() {
    Operator? operator;
    switch (this) {
      case 'eq':
        operator = Operator.equal;
        break;
      case 'not':
        operator = Operator.notEqual;
        break;
      case 'gt':
        operator = Operator.greaterThan;
        break;
      case 'gte':
        operator = Operator.greaterThanEqual;
        break;
      case 'lt':
        operator = Operator.lessThen;
        break;
      case 'lte':
        operator = Operator.lessThenEqual;
        break;
      case 'between':
        operator = Operator.between;
        break;
      case 'contains':
        operator = Operator.contains;
        break;
      case 'not_contains':
        operator = Operator.notContains;
        break;
      case 'starts_with':
        operator = Operator.startsWith;
        break;
      case 'ends_with':
        operator = Operator.endsWith;
        break;
      case 'empty':
        operator = Operator.isEmpty;
        break;
      case 'not_empty':
        operator = Operator.notEmpty;
        break;
      case 'in':
        operator = Operator.IN;
        break;
      case 'not_in':
        operator = Operator.notIn;
        break;
      default:
        operator = null;
    }
    return operator;
  }

  String cleanForUrl() {
    return replaceAll(invalidRegExp, "-");
  }
}

extension IsNullOrEmpty on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}

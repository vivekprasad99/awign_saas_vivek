import 'dart:io';

import 'package:flutter/material.dart';

extension FileExtention on FileSystemEntity {
  String? get name {
    return this.path.split("/").last;
  }
}

extension IsNullOrEmpty on List? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;
    return 0;
  }
}
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';

enum AttendanceActivity {
  present('P', AppColors.success300),
  absent('A', AppColors.error300),
  holiday('H', AppColors.secondary),
  remaining('R', AppColors.backgroundGrey500);

  const AttendanceActivity(this.activity, this.color);

  final String activity;
  final Color color;
}
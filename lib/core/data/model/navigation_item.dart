import 'package:flutter/material.dart';

class NavigationItem {
  final IconData? iconData;
  final String? iconUrl;
  final String? activeIconUrl;
  final String? text;
  final String? navigateTo;
  final double? padding;

  NavigationItem({
    this.iconData,
    this.iconUrl,
    this.activeIconUrl,
    this.padding = 0,
    this.text,
    this.navigateTo,
  });
}

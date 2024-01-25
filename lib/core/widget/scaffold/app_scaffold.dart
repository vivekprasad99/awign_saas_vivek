import 'dart:io';

import 'package:awign_saas/core/widget/app_bar/default_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme_manager.dart';

typedef MyBuilder = void Function(BuildContext context, void Function() openNavDrawer);

class AppScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final MyBuilder? builder;
  final Widget body;
  final Widget? navigationDrawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  Color? backgroundColor;
  final double? leftPadding;
  final double? topPadding;
  final double? rightPadding;
  final double? bottomPadding;
  final Function? openDrawer;

  AppScaffold({
    Key? key,
    required this.body,
    this.navigationDrawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.leftPadding,
    this.topPadding,
    this.rightPadding,
    this.bottomPadding,
    this.openDrawer,
    this.builder
  }) : super(key: key) {
    backgroundColor ??= Get.theme.colorScheme.background;
  }

  @override
  Widget build(BuildContext context) {
    builder?.call(context, openNavDrawer);
    return Scaffold(
      key: _key,
      backgroundColor: backgroundColor,
      drawer: navigationDrawer,
      body: InkWell(
        focusColor: AppColors.transparent,
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: body,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget buildBodyWithSafeArea() {
    return SafeArea(child: body);
  }

  openNavDrawer() {
    _key.currentState?.openDrawer();
  }
}

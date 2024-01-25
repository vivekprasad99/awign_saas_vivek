import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteWidget extends StatelessWidget {
  final Widget child;
  final bool bottomNavigation;
  final bool forDriver;
  final bool errorSnackBar;

  const RouteWidget({
    required this.child,
    this.bottomNavigation = false,
    this.forDriver = false,
    this.errorSnackBar = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget routeWidget = Container(
      color: context.theme.scaffoldBackgroundColor,
      child: child,
    );

    if (bottomNavigation) {
      // routeWidget = WithBottomNavigation(child: routeWidget);
    }

    return routeWidget;
  }
}

import 'package:flutter/material.dart';
import '../../di/app_injection_container.dart';
import '../../router/router.dart';
import 'left_nav_menu/left_navigation.dart';

class LayoutTemplateWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // return ScreenTypeLayout(
    //   mobile: LayoutTemplateMobile(),
    //   desktop: LayoutTemplateDesktop(),
    // );
    return LayoutTemplateMobile();
  }
}

class LayoutTemplateMobile extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      drawer: LeftNavigation(),
      body: Column(
        children: [
          //NavigationBar(),
          Expanded(
            child: Navigator(
              onGenerateRoute: sl<MRouter>().onGenerateRoute,
              key: MRouter.localNavigatorKey,
            ),
          )
        ],
      ),
    );
  }
}

class LayoutTemplateDesktop extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: Row(
        children: [
          LeftNavigation(),
          Expanded(
            child: Column(
              children: [
                // TopNavBar('admin'),
                Expanded(
                  child: Navigator(
                    onGenerateRoute: sl<MRouter>().onGenerateRoute,
                    //initialRoute: MRouter.superAdminDashboardRoute,
                    key: MRouter.localNavigatorKey,
                    // observers: [MyRouteObserver()],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

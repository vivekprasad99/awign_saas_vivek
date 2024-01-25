import 'dart:async';
import 'package:awign_saas/hrms/attendance/data/model/attendance_response.dart';
import 'package:awign_saas/hrms/auth/data/model/user_response.dart';
import 'package:awign_saas/hrms/auth/features/select_organisation/cubit/select_organisation_cubit.dart';
import 'package:awign_saas/hrms/comp_off/feature/apply_comp_off/cubit/apply_comp_off_cubit.dart';
import 'package:awign_saas/hrms/comp_off/feature/comp_off_details/cubit/comp_off_details_cubit.dart';
import 'package:awign_saas/hrms/comp_off/feature/comp_off_listing/cubit/comp_off_listing_cubit.dart';
import 'package:awign_saas/hrms/dashboard/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:awign_saas/hrms/dashboard/features/home/cubit/home_cubit.dart';
import 'package:awign_saas/hrms/dashboard/features/home/widget/home_widget.dart';
import 'package:awign_saas/hrms/dashboard/features/notifications/cubit/notifications_cubit.dart';
import 'package:awign_saas/hrms/dashboard/features/notifications/widget/notifications_widget.dart';
import 'package:awign_saas/hrms/dashboard/features/personal_details/cubit/personal_details_cubit.dart';
import 'package:awign_saas/hrms/dashboard/features/profile/cubit/profile_cubit.dart';
import 'package:awign_saas/hrms/dashboard/features/profile/widget/profile_widget.dart';
import 'package:awign_saas/hrms/dashboard/features/settings/widget/settings_widget.dart';
import 'package:awign_saas/hrms/faq/features/faq/cubit/faq_cubit.dart';
import 'package:awign_saas/hrms/faq/features/faq/widget/faq_widget.dart';
import 'package:awign_saas/hrms/holidays/features/apply_holiday/cubit/apply_holiday_cubit.dart';
import 'package:awign_saas/hrms/holidays/features/holidays_listing/cubit/holiday_listing_cubit.dart';
import 'package:awign_saas/hrms/holidays/features/holidays_listing/widget/holidays_listing_widget.dart';
import 'package:awign_saas/hrms/leaves/data/model/leaves_arguments.dart';
import 'package:awign_saas/hrms/documents/features/documents_tab/widget/documents_tab_widget.dart';
import 'package:awign_saas/hrms/documents/features/company_document/cubit/company_document_cubit.dart';
import 'package:awign_saas/hrms/leaves/features/apply_leave/cubit/apply_leave_cubit.dart';
import 'package:awign_saas/hrms/leaves/features/leave_details/cubit/leave_details_cubit.dart';
import 'package:awign_saas/hrms/leaves/features/leaves_listing/cubit/leaves_listing_cubit.dart';
import 'package:awign_saas/hrms/regularisation/data/model/regularisation_status_response.dart';
import 'package:awign_saas/hrms/regularisation/features/regularisation_dashboard/cubit/regularisation_dashboard_cubit.dart';
import 'package:awign_saas/hrms/regularisation/features/regularisation_details/cubit/regularisation_details_cubit.dart';
import 'package:awign_saas/hrms/regularisation/features/request_regularise/cubit/request_regularise_cubit.dart';
import 'package:awign_saas/hrms/regularisation/features/request_regularise/widget/request_regularise_widget.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements/cubit/reimbursement_cubit.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements/widget/reimbursements_widget.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements_detail/cubit/reimbursement_detail_cubit.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements_detail/widget/reimbursements_detail_widget.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements_form/cubit/reimbursement_form_cubit.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements_form/widget/reimbursement_form_widget.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/employee_attendance.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/features/rm_attendance_dashboard/cubit/rm_attendance_dashboard_cubit.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/features/rm_attendance_detail/cubit/rm_attendance_details_cubit.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/feature/rm_comp_off_details/cubit/rm_comp_off_details_cubit.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/feature/rm_comp_off_listing/cubit/rm_comp_off_listing_cubit.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/feature/rm_comp_off_listing/widget/rm_comp_off_listing_widget.dart';
import 'package:awign_saas/hrms/rm/rm_leaves/features/rm_leave_details/cubit/rm_leave_details_cubit.dart';
import 'package:awign_saas/hrms/rm/rm_leaves/features/rm_leave_listing/cubit/rm_leave_listing_cubit.dart';
import 'package:awign_saas/hrms/rm/rm_leaves/features/rm_leave_listing/widget/rm_leave_listing_widget.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/features/rm_reimbursement_dashboard/cubit/rm_reimbursement_dashboard_cubit.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/features/rm_reimbursement_dashboard/widget/rm_reimbursements_widget.dart';
import 'package:awign_saas/hrms/rm/rm_regularisation/data/model/rm_regularise_detail_model.dart';
import 'package:awign_saas/hrms/rm/rm_regularisation/features/rm_regularisation_dashboard/cubit/rm_regularisation_dashboard_cubit.dart';
import 'package:awign_saas/hrms/rm/rm_regularisation/features/rm_regularisation_detail/widget/rm_regularisation_detail_widget.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/features/rm_reimbursements_detail/cubit/rm_reimbursement_detail_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import '../../hrms/attendance/features/attendance_dashboard/cubit/attendance_dashboard_cubit.dart';
import '../../hrms/attendance/features/attendance_dashboard/widget/attendance_dashboard_widget.dart';
import '../../hrms/attendance/features/selfie_camera/cubit/selfie_camera_cubit.dart';
import '../../hrms/attendance/features/selfie_camera/data/model/selfie_camera_widget_argument.dart';
import '../../hrms/attendance/features/selfie_camera/widget/selfie_camera_widget.dart';
import '../../hrms/auth/features/login_via_number/cubit/login_via_number_cubit.dart';
import '../../hrms/auth/features/login_via_number/widget/login_via_number_widget.dart';
import '../../hrms/auth/features/otp_verification_widget/cubit/otp_verification_cubit.dart';
import '../../hrms/auth/features/otp_verification_widget/data/otp_verification_argument.dart';
import '../../hrms/auth/features/otp_verification_widget/widget/otp_verification_widget.dart';
import '../../hrms/auth/features/select_organisation/widget/select_organisation_widget.dart';
import '../../hrms/auth/features/splash/cubit/splash_cubit.dart';
import '../../hrms/auth/features/splash/widget/splash_widget.dart';
import '../../hrms/comp_off/feature/apply_comp_off/widget/apply_comp_off_widget.dart';
import '../../hrms/comp_off/feature/comp_off_details/widget/comp_off_details_widget.dart';
import '../../hrms/comp_off/feature/comp_off_listing/widget/comp_off_listing_widget.dart';
import '../../hrms/dashboard/features/dashboard/widget/dashboard_widget.dart';
import '../../hrms/dashboard/features/personal_details/widget/personal_details_widget.dart';
import '../../hrms/documents/features/company_document/widget/company_document_widget.dart';
import '../../hrms/holidays/data/model/holiday_search_response.dart';
import '../../hrms/holidays/features/apply_holiday/widget/apply_holiday_widget.dart';
import '../../hrms/leaves/data/model/leave.dart';
import '../../hrms/leaves/features/apply_leave/widget/apply_leave_widget.dart';
import '../../hrms/leaves/features/leave_details/widget/leave_details_widget.dart';
import '../../hrms/leaves/features/leaves_listing/widget/leaves_listing_widget.dart';
import '../../hrms/regularisation/data/model/request_regularize_widget_argument.dart';
import '../../hrms/regularisation/features/regularisation_dashboard/widget/regularisation_dashboard_widget.dart';
import '../../hrms/regularisation/features/regularisation_details/widget/regularisation_details_widget.dart';
import '../../hrms/rm/rm_attendance/features/rm_attendance_dashboard/widget/rm_attendance_dashboard_widget.dart';
import '../../hrms/rm/rm_attendance/features/rm_attendance_detail/widget/rm_attendance_details_widget.dart';
import '../../hrms/rm/rm_attendance/features/rm_attendance_filters/cubit/rm_attendance_filters_cubit.dart';
import '../../hrms/rm/rm_attendance/features/rm_attendance_filters/widget/rm_attendance_filters_widget.dart';
import '../../hrms/rm/rm_comp_off/feature/rm_comp_off_details/widget/rm_comp_off_details_widget.dart';
import '../../hrms/rm/rm_dashboard/widget/rm_dashboard_widget.dart';
import '../../hrms/rm/rm_leaves/features/rm_leave_details/widget/rm_leave_details_widget.dart';
import '../../hrms/rm/rm_regularisation/data/model/regularize_search_response.dart';
import '../../hrms/rm/rm_regularisation/features/rm_regularisation_dashboard/widget/rm_regularisation_dashboard_widget.dart';
import '../../hrms/rm/rm_regularisation/features/rm_regularisation_detail/cubit/rm_regilarisation_detail_cubit.dart';
import '../../hrms/rm/rm_reimbursements/features/rm_reimbursements_detail/widget/rm_reimbursements_detail_widget.dart';
import '../di/app_injection_container.dart';

class MRouter {
  final _currentRouteSubject = BehaviorSubject<String>();

  StreamSink<String> get _currentRouteSink => _currentRouteSubject.sink;

  Stream<String> get currentRouteStream => _currentRouteSubject.stream;

  String get currentRoute => _currentRouteSubject.value;

  void closeStream() => _currentRouteSubject.close();

  final _currentLocalRouteSubject = BehaviorSubject<String>();

  StreamSink<String> get _currentLocalRouteSink =>
      _currentLocalRouteSubject.sink;

  Stream<String> get currentLocalRouteStream =>
      _currentLocalRouteSubject.stream;

  String get currentLocalRoute => _currentLocalRouteSubject.value;

  void closeLocalStream() => _currentLocalRouteSubject.close();

  static bool get mounted => globalNavigatorKey.currentState != null;

  static bool get mountedLocal => localNavigatorKey.currentState != null;

  static final GlobalKey<NavigatorState> globalNavigatorKey =
      GlobalKey(debugLabel: 'Global Navigator');

  static final GlobalKey<NavigatorState> localNavigatorKey =
      GlobalKey(debugLabel: 'Local Navigator');

  static const String splashRoute = 'SplashWidget';
  static const String loginViaMobileWidget = 'LoginViaMobileNumberWidget';
  static const String otpVerificationWidget = 'OTPVerificationWidget';
  static const String selectOrganisationWidget = 'SelectOrganisationWidget';
  static const String dashboardWidget = 'DashboardWidget';
  static const String homeWidget = 'HomeWidget';
  static const String notificationsWidget = 'NotificationsWidget';
  static const String settingsWidget = 'SettingsWidget';
  static const String profileWidget = 'ProfileWidget';
  static const String personalDetailsWidget = 'PersonalDetailsWidget';
  static const String attendanceDashboardWidget = 'AttendanceDashboardWidget';
  static const String selfieCameraWidget = 'SelfieCameraWidget';
  static const String leavesListingWidget = 'LeavesListingWidget';
  static const String reimbursementsWidget = 'ReimbursementsWidget';
  static const String applyLeaveWidget = 'ApplyLeaveWidget';
  static const String leaveDetailsWidget = 'LeaveDetailsWidget';
  static const String reimbursementsFormWidget = 'ReimbursementsFormWidget';
  static const String reimbursementsDetailWidget = 'ReimbursementsDetailWidget';
  static const String regularisationDashboardWidget = 'RegularisationDashboardWidget';
  static const String requestRegulariseWidget = 'RequestRegulariseWidget';
  static const String regularisationDetailsWidget = 'RegularisationDetailsWidget';
  static const String documentsTabWidget = 'DocumentsTabWidget';
  static const String companyDocumentWidget = 'CompanyDocumentWidget';
  static const String holidaysListingWidget = 'holidaysListingWidget';
  static const String applyHolidayWidget = 'ApplyHolidayWidget';
  static const String faqWidget = 'FaqWidget';
  static const String compOffListingWidget = 'CompOffListingWidget';
  static const String applyCompOffWidget = 'ApplyCompOffWidget';
  static const String compOffDetailsWidget = 'CompOffDetailsWidget';

  /// RM routes
  static const String rmDashboardWidget = 'RMDashboardWidget';
  static const String rmReimbursementsWidget = 'RmReimbursementsWidget';
  static const String rmReimbursementsDetailWidget = 'rmReimbursementsDetailWidget';
  static const String rmLeaveListingWidget = 'RMLeaveListingWidget';
  static const String rmAttendanceDashboardWidget = 'RMAttendanceDashboardWidget';
  static const String rmAttendanceDetailWidget = 'RMAttendanceDetailWidget';
  static const String rmAttendanceFiltersWidget = 'RMAttendanceFiltersWidget';
  static const String rmLeaveDetailsWidget = 'RMLeaveDetailsWidget';
  static const String rmRegularisationDashboardWidget = 'RMRegularisationDashboardWidget';
  static const String rmRegulariseDetailsWidget = 'RMRegulariseDetailsWidget';
  static const String rmCompOffListingWidget = 'RMCompOffListingWidget';
  static const String rmCompOffDetailsWidget = 'RMCompOffDetailsWidget';

  void updateRoute(String? routeName) => _currentRouteSink.add(routeName ?? "");

  void updateLocalRoute(String? routeName) =>
      _currentLocalRouteSink.add(routeName ?? "");

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                create: (context) => SplashCubit(sl()),
                child: const SplashWidget()),
            settings: settings);
      case loginViaMobileWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                create: (context) => LoginViaNumberCubit(sl()),
                child: const LoginViaNumberWidget()),
            settings: settings);
      case otpVerificationWidget:
        OTPVerificationArgument otpVerificationArgument = settings.arguments as OTPVerificationArgument;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                  create: (context) => OtpVerificationCubit(sl()),
                  child: OTPVerificationWidget(otpVerificationArgument),
                ),
            settings: settings);
      case selectOrganisationWidget:
        UserResponse userResponse = settings.arguments as UserResponse;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => SelectOrganisationCubit(sl()),
              child: SelectOrganisationWidget(userResponse),
            ),
            settings: settings);
      case dashboardWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => DashboardCubit(),
              child: const DashboardWidget(),
            ),
            settings: settings);
      case homeWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => HomeCubit(sl()),
              child: HomeWidget(),
            ),
            settings: settings);
      case notificationsWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                  create: (context) => NotificationsCubit(sl()),
                  child: const NotificationsWidget(),
                ),
            settings: settings);
      case settingsWidget:
        return CupertinoPageRoute(
            builder: (ctx) => const SettingsWidget(),
            settings: settings);
      case profileWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => ProfileCubit(),
              child: const ProfileWidget(),
            ),
            settings: settings);
      case personalDetailsWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => PersonalDetailsCubit(sl()),
              child: const PersonalDetailsWidget(),
            ),
            settings: settings);
      case attendanceDashboardWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                  create: (context) => AttendanceDashboardCubit(sl()),
                  child: AttendanceDashboardWidget(),
                ),
            settings: settings);
      case selfieCameraWidget:
        SelfieCameraWidgetArgument argument = settings.arguments as SelfieCameraWidgetArgument;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => SelfieCameraCubit(sl()),
              child: SelfieCameraWidget(argument),
            ),
            settings: settings);
      case reimbursementsWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                create: (context) => ReimbursementCubit(sl()),
                child: const ReimbursementsWidget()),
            settings: settings);
      case leavesListingWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => LeavesListingCubit(sl()),
              child: const LeavesListingWidget(),
            ),
            settings: settings);
      case applyLeaveWidget:
        LeavesArgument leavesArgument = settings.arguments as LeavesArgument;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => ApplyLeaveCubit(sl()),
              child: ApplyLeaveWidget(leavesArgument),
            ),
            settings: settings);
      case leaveDetailsWidget:
        int leaveID = settings.arguments as int;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => LeaveDetailsCubit(sl(), sl()),
              child: LeaveDetailsWidget(leaveID),
            ),
            settings: settings);
      case reimbursementsFormWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                  create: (context) => ReimbursementFormCubit(sl()),
                  child: const ReimbursementFormWidget(),
                ),
            settings: settings);
      case reimbursementsDetailWidget:
        String uuid = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                  create: (context) => ReimbursementDetailCubit(sl()),
                  child: ReimbursementsDetailWidget(uuid),
                ),
            settings: settings);
      case holidaysListingWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                create: (context) => HolidayListingCubit(sl()),
                child: const HolidaysListingWidget()),
            settings: settings);
      case applyHolidayWidget:
        Holiday holiday = settings.arguments as Holiday;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                create: (context) => ApplyHolidayCubit(sl(), sl()),
                child: ApplyHolidayWidget(holiday)),
            settings: settings);
      case regularisationDashboardWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => RegularisationDashboardCubit(sl()),
              child: const RegularisationDashboardWidget(),
            ),
            settings: settings);
      case requestRegulariseWidget:
        RequestRegularizeWidgetArgument requestRegularizeWidgetArgument = settings.arguments as RequestRegularizeWidgetArgument;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => RequestRegulariseCubit(sl(), sl()),
              child: RequestRegulariseWidget(requestRegularizeWidgetArgument),
            ),
            settings: settings);
      case regularisationDetailsWidget:
        Regularisation regularisation = settings.arguments as Regularisation;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => RegularisationDetailsCubit(sl()),
              child: RegularisationDetailsWidget(regularisation),
            ),
            settings: settings);
      case rmDashboardWidget:
        return CupertinoPageRoute(
            builder: (ctx) => const RMDashboardWidget(),
            settings: settings);
      case rmReimbursementsWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                create: (context) => RmReimbursementDashboardCubit(sl()),
                child: const RMReimbursementsWidget()),
            settings: settings);
      case rmReimbursementsDetailWidget:
        String uuid = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => RMReimbursementDetailCubit(sl()),
              child: RMReimbursementsDetailWidget(uuid),
            ),
            settings: settings);
      case rmLeaveListingWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => RMLeaveListingCubit(sl()),
              child: const RMLeaveListingWidget(),
            ),
            settings: settings);
      case rmAttendanceDashboardWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => RMAttendanceDashboardCubit(sl()),
              child: const RMAttendanceDashboardWidget(),
            ),
            settings: settings);
      case rmAttendanceDetailWidget:
        EmployeeAttendance employeeAttendance = settings.arguments as EmployeeAttendance;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => RMAttendanceDetailsCubit(),
              child: RMAttendanceDetailWidget(employeeAttendance),
            ),
            settings: settings);
      case rmAttendanceFiltersWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => RMAttendanceFiltersCubit(),
              child: const RMAttendanceFiltersWidget(),
            ),
            settings: settings);
      case rmLeaveDetailsWidget:
        Leave leave = settings.arguments as Leave;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => RMLeaveDetailsCubit(),
              child: RMLeaveDetailsWidget(leave),
            ),
            settings: settings);
      case rmRegularisationDashboardWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                  create: (context) => RMRegularisationDashboardCubit(sl()),
                  child: const RMRegularisationDashboardWidget(),
                ),
            settings: settings);
      case documentsTabWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                create: (context) => CompanyDocumentCubit(sl()),
                child: const DocumentsTabWidget()), settings: settings);
      case companyDocumentWidget:
        String type = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                create: (context) => CompanyDocumentCubit(sl()),
                child:   CompanyDocumentWidget(type)), settings: settings);
      case faqWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                create: (context) => FaqCubit(sl()), child: const FaqWidget()),
            settings: settings);
      case compOffListingWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                create: (context) => CompOffListingCubit(sl(), sl()), child: const CompOffListingWidget()),
            settings: settings);
      case applyCompOffWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                create: (context) => ApplyCompOffCubit(sl()), child: const ApplyCompOffWidget()),
            settings: settings);
      case compOffDetailsWidget:
        int compOffID = settings.arguments as int;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                create: (context) => CompOffDetailsCubit(sl()), child: CompOffDetailsWidget(compOffID)),
            settings: settings);
      case rmRegulariseDetailsWidget:
        Regularization regularization =
            settings.arguments as Regularization;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
                  create: (context) => RmRegilarisationDetailCubit(sl()),
                  child: RmRegularisationDetailWidget(regularization),
                ),
            settings: settings);
      case rmCompOffListingWidget:
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => RMCompOffListingCubit(sl()),
              child: const RMCompOffListingWidget(),
            ),
            settings: settings);
      case rmCompOffDetailsWidget:
        int compOffID = settings.arguments as int;
        return CupertinoPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) => RMCompOffDetailsCubit(sl()),
              child: RMCompOffDetailsWidget(compOffID),
            ),
            settings: settings);
    }
  }

  static Future<dynamic> pushNamed(String route,
      {Object? arguments, bool isLocal = false}) {
    if (isLocal) {
      return localNavigatorKey.currentState!
          .pushNamed(route, arguments: arguments);
    } else {
      return globalNavigatorKey.currentState!
          .pushNamed(route, arguments: arguments);
    }
  }

  static Future<dynamic> pushReplacementNamed(String route,
      {Object? arguments, bool isLocal = false}) {
    if (isLocal) {
      return localNavigatorKey.currentState!
          .pushReplacementNamed(route, arguments: arguments);
    } else {
      return globalNavigatorKey.currentState!
          .pushReplacementNamed(route, arguments: arguments);
    }
  }

  static Future<dynamic> pushNamedAndRemoveUntil(String route,
      {Object? arguments, bool isLocal = false}) {
    if (isLocal) {
      return localNavigatorKey.currentState!.pushNamedAndRemoveUntil(
          route, (Route<dynamic> route) => false,
          arguments: arguments);
    } else {
      return globalNavigatorKey.currentState!.pushNamedAndRemoveUntil(
          route, (Route<dynamic> route) => false,
          arguments: arguments);
    }
  }

  static Future<Map?> pushNamedWithResult(
      BuildContext context, Widget widget, String? routeName,
      {bool isLocal = false}) async {
    var localSettings = RouteSettings(name: routeName, arguments: {});
    if (isLocal) {
      Object? value = await localNavigatorKey.currentState!.push(
          CupertinoPageRoute(
              builder: (ctx) => widget, settings: localSettings));
    } else {
      Object? value = await globalNavigatorKey.currentState!.push(
          CupertinoPageRoute(
              builder: (ctx) => widget, settings: localSettings));
    }
    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    return arguments;
  }

  static Future<bool?> popNamedWithResult(
      String? routeName, String key, dynamic value) async {
    globalNavigatorKey.currentState?.popUntil((route) {
      if (route.settings.name == routeName) {
        (route.settings.arguments as Map)[key] = value;
        return true;
      } else {
        return false;
      }
    });
  }

  static pop(Object? result, {bool isLocal = false}) {
    if (isLocal) {
      return localNavigatorKey.currentState!.pop(result);
    } else {
      return globalNavigatorKey.currentState!.pop(result);
    }
  }

  static void popUntil(String untilRoute, {bool isLocal = false}) {
    if (isLocal) {
      return localNavigatorKey.currentState!
          .popUntil(ModalRoute.withName(untilRoute));
    } else {
      return globalNavigatorKey.currentState!
          .popUntil(ModalRoute.withName(untilRoute));
    }
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../di/app_injection_container.dart';
import '../../../../router/router.dart';
import '../left_navigation.dart';

class LeftNavigationCubit extends Cubit<String> {
  StreamSubscription<String>? _routeNameSubscription;

  final _isLeftNavigationVisible = BehaviorSubject<bool>.seeded(true);
  Stream<bool> get isLeftNavigationVisible => _isLeftNavigationVisible.stream;
  Function(bool) get changeLeftNavigationVisible =>
      _isLeftNavigationVisible.sink.add;

  void toggleLeftNavigation() {
    if (_isLeftNavigationVisible.value) {
      changeLeftNavigationVisible(false);
    } else {
      changeLeftNavigationVisible(true);
    }
  }

  LeftNavigationCubit() : super("") {
    _routeNameSubscription = sl<MRouter>().currentRouteStream.listen((route) {
      if (LeftNavigation.possibleRoutes.contains(route)) {
        emit(route);
      }
    });
  }

  @override
  Future<void> close() {
    _routeNameSubscription?.cancel();
    _isLeftNavigationVisible.close();
    return super.close();
  }
}

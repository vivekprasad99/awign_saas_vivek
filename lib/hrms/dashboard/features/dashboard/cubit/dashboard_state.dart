import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/model/navigation_item.dart';

part 'dashboard_state.g.dart';

@CopyWith()
class DashboardState extends Equatable {
  final List<NavigationItem>? navigationItemList;
  final int? currentTabIndex;

  const DashboardState({this.navigationItemList, this.currentTabIndex});

  @override
  List<Object?> get props => [navigationItemList, currentTabIndex];
}

import 'package:awign_saas/hrms/auth/data/model/employee_details.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/data/model/ui_state.dart';

part 'personal_details_state.g.dart';

@CopyWith()
class PersonalDetailsState extends Equatable {
  final UIState? uiState;
  final int? currentTabIndex;
  final bool? isLoading;
  final EmployeeDetails? employeeDetails;
  const PersonalDetailsState({this.uiState, this.currentTabIndex,this.isLoading,this.employeeDetails});

  @override
  List<Object?> get props => [uiState, currentTabIndex,isLoading,employeeDetails];
}

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/data/model/ui_state.dart';

part 'profile_state.g.dart';

@CopyWith()
class ProfileState extends Equatable {
  final UIState? uiState;

  const ProfileState({this.uiState});

  @override
  List<Object?> get props => [uiState];
}

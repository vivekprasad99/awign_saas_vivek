import 'package:equatable/equatable.dart';

class ButtonState extends Equatable {
  final bool isEnable;
  final bool isLoading;
  final bool isSuccess;
  final String? message;
  final int? percentValue;
  final double? progressValue;

  const ButtonState(
      {this.isEnable = false, this.isLoading = false, this.isSuccess = false, this.message, this.percentValue, this.progressValue});

  @override
  List<Object?> get props => [isEnable, isLoading, isSuccess, message, percentValue, progressValue];
}

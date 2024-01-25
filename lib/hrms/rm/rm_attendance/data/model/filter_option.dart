import 'package:equatable/equatable.dart';

class FilterOption extends Equatable {
  final String? label;
  final bool? isSelected;

  const FilterOption(this.label, this.isSelected);

  @override
  List<Object?> get props => [label, isSelected];
}
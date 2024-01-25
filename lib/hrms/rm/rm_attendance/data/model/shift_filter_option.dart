import 'package:copy_with_extension/copy_with_extension.dart';

import 'filter_option.dart';

part 'shift_filter_option.g.dart';

@CopyWith()
class ShiftFilterOption extends FilterOption {
  @override
  final String? label;
  @override
  final bool? isSelected;

  const ShiftFilterOption(this.label, this.isSelected) : super(label, false);

  @override
  List<Object?> get props => [label, isSelected];
}
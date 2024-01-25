import 'package:copy_with_extension/copy_with_extension.dart';

import 'filter_option.dart';

part 'work_location_filter_option.g.dart';

@CopyWith()
class WorkLocationFilterOption extends FilterOption {
  @override
  final String? label;
  @override
  final bool? isSelected;

  const WorkLocationFilterOption(this.label, this.isSelected) : super(label, false);

  @override
  List<Object?> get props => [label, isSelected];
}
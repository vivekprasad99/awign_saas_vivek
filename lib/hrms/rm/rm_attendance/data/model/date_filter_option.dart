import 'package:copy_with_extension/copy_with_extension.dart';

import 'filter_option.dart';

part 'date_filter_option.g.dart';

@CopyWith()
class DateFilterOption extends FilterOption {
  @override
  final String? label;
  @override
  final bool? isSelected;
  final int? groupValue;
  final DateTime? customDateTime;

  const DateFilterOption(this.label, this.isSelected, this.groupValue, this.customDateTime) : super(label, isSelected);

  @override
  List<Object?> get props => [label, isSelected, groupValue, customDateTime];
}
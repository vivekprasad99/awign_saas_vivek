import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/billing_cycle/cubit/billing_cycle_cubit.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/billing_cycle/cubit/billing_cycle_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../core/widget/common/form_label_widget.dart';
import '../../../../../../../core/widget/theme/theme_manager.dart';

class BillingCycleWidget extends StatelessWidget {
  final String? label;
  final bool isEnable;
  final bool isShowNextBillingCycle;
  final Function(BillingCycle? billingCycle)? onChanged;
  const BillingCycleWidget({this.label, this.isEnable = true, this.isShowNextBillingCycle = false,
    this.onChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<BillingCycleCubit>().loadBillingCycle(isShowNextBillingCycle, onChanged);
    return buildSelectBillingCycleWidgets(context);
  }

  Widget buildSelectBillingCycleWidgets(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelWidget(labelText: label ?? '', requiredText: '*'),
        const SizedBox(height: Dimens.padding_8),
        BlocConsumer<BillingCycleCubit, BillingCycleState>(
          listenWhen: (previous, current) {
            return previous.billingCycleList != current.billingCycleList;
          },
          listener: (context, state) {
            context
                .read<BillingCycleCubit>()
                .updateSelectedBillingCycle(state.billingCycleList?.first);
            if(onChanged != null) {
              onChanged!(state.billingCycleList?.first);
            }
          },
          buildWhen: (prevState, curState) {
            return (prevState.billingCycleList !=
                curState.billingCycleList || prevState.selectedBillingCycle != curState.selectedBillingCycle);
          },
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.radius_8),
                border: Border.all(
                  width: Dimens.border_1,
                  color: Get.theme.getCustomColor(context).secondary1200!,
                  style: BorderStyle.solid,
                ),
                color: Get.theme.colorScheme.background,
              ),
              padding: const EdgeInsets.fromLTRB(
                  Dimens.padding_12, 0, Dimens.padding_12, 0),
              child: DropdownButton<BillingCycle>(
                isExpanded: true,
                value: state.selectedBillingCycle,
                hint: FormLabelWidget(
                    labelText: label ?? '',
                    textColor: Theme.of(context)
                        .getCustomColor(context)
                        .backgroundgrey700),
                icon: SvgPicture.asset(
                  'assets/images/ic_drop_down_blue.svg',
                ),
                underline: const SizedBox(),
                onChanged: isEnable ? (BillingCycle? selectedValue) {
                  context
                      .read<BillingCycleCubit>()
                      .updateSelectedBillingCycle(selectedValue);
                  if(onChanged != null) {
                    onChanged!(selectedValue);
                  }
                } : null,
                items: state.billingCycleList?.map<DropdownMenuItem<BillingCycle>>(
                        (BillingCycle entity) {
                      return DropdownMenuItem<BillingCycle>(
                        value: entity,
                        child: Text( '${entity.strStartDate} - ${entity.strEndDate}',
                            style: Get.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                      );
                    }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}

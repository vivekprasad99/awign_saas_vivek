import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/hrms/attendance/features/regularisation_alert/cubit/regularisation_alert_cubit.dart';
import 'package:awign_saas/hrms/attendance/features/regularisation_alert/cubit/regularisation_alert_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/widget/buttons/my_ink_well.dart';
import '../../../../../core/widget/theme/theme_manager.dart';

class RegularisationAlertWidget extends StatelessWidget {
  const RegularisationAlertWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RegularisationAlertCubit>().getAttendanceStatusByDateRange();
    return BlocBuilder<RegularisationAlertCubit, RegularisationAlertState>(
      buildWhen: (prev, cur) {
        return (prev.pendingRegularisationCount != cur.pendingRegularisationCount || prev.isLoading != cur.isLoading);
      },
      builder: (context, state) {
        if(state.isLoading ?? false) {
          return const SizedBox();
        } else if(state.pendingRegularisationCount != null && state.pendingRegularisationCount! > 0) {
          return buildRegularisationContainer(context, state.pendingRegularisationCount!);
        } else {
          return const SizedBox();
        }

      },
    );
  }

  Widget buildRegularisationContainer(BuildContext context, int count) {
    return Container(
      margin: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_16, Dimens.padding_16, 0),
      decoration:  BoxDecoration (
          borderRadius:  BorderRadius.circular(Dimens.radius_8),
          color: Theme.of(context).extension<CustomColors>()!.sourceWarning200
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.padding_16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/ic_warning.svg',
            ),
            const SizedBox(width: Dimens.padding_8),
            Text(
              '$count ${'days_pending_for_regularisation'.tr}',
              style:  Get.textTheme.labelMedium?.copyWith(color: Theme.of(context).extension<CustomColors>()!.backgroundblack),
            ),
            const Spacer(),
            MyInkWell(
              onTap: () {
                MRouter.pushNamed(MRouter.attendanceDashboardWidget);
              },
              child: Text(
                'click_here'.tr,
                style:  Get.textTheme.labelMedium?.copyWith(color: Theme.of(context).extension<CustomColors>()!.backgroundblack,
                    decoration:  TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

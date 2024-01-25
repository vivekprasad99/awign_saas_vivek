import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../dialog/loading/app_circular_progress_indicator.dart';
import '../theme/theme_manager.dart';
import 'cubit/internet_cubit.dart';

class InternetSensitive extends StatelessWidget {
  final Widget? child;

  const InternetSensitive({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (internetCubitBuilderContext, state) {
        if (kIsWeb) {
          return child ?? const SizedBox();
        } else if (state is InternetConnected) {
          return child ?? const SizedBox();
        } else if (state is InternetDisconnected) {
          return buildNoInternetUI(context);
        }
        return child ?? const SizedBox();
      },
    );
  }

  Widget buildNoInternetUI(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('No Internet Connection!', style: context.textTheme.subtitle2),
          const SizedBox(height: Dimens.margin_4),
          Text('Please try to connect with internet.',
              style: context.textTheme.bodyText1)
        ],
      ),
    );
  }
}

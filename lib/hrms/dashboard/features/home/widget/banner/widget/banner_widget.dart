import 'package:awign_saas/hrms/dashboard/features/home/widget/banner/cubit/banner_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/widget/dialog/loading/app_circular_progress_indicator.dart';
import '../../../../../../../core/widget/theme/dimens.dart';
import '../cubit/banner_state.dart';
import 'indicator_widget.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int itemIndex,
              int pageViewIndex) =>
              Image.network(
                  'https://picsum.photos/seed/picsum/200/300',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return AppCircularProgressIndicator();
                  }
              ), options: CarouselOptions(
          height: Dimens.imageHeight_172,
          viewportFraction: 1,
          autoPlay: true,
          onPageChanged: (index, reason) {
            context.read<BannerCubit>().updateCurrentPageIndex(index);
          },
          autoPlayInterval: const Duration(seconds: 2),),
        ),
        const SizedBox(height: Dimens.padding_8),
        BlocBuilder<BannerCubit, BannerState>(
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  if (i == state.currentPageIndex)
                    const IndicatorWidget(true)
                  else
                    const IndicatorWidget(false)
              ],
            );
          },
        )
      ],
    );
  }
}

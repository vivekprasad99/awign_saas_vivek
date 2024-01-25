import 'dart:async';
import 'dart:io';

import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/attendance/features/selfie_camera/cubit/selfie_camera_cubit.dart';
import 'package:awign_saas/hrms/attendance/features/selfie_camera/cubit/selfie_camera_state.dart';
import 'package:awign_saas/hrms/attendance/features/selfie_camera/data/model/selfie_camera_widget_argument.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../core/config/cubit/flavor_cubit.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/router/router.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../core/widget/buttons/raised_rect_button.dart';
import '../../../../../core/widget/dialog/location_service_enable_alert_dialog/location_service_enable_alert_dialog.dart';
import '../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../data/model/today_attendance_status.dart';
import '../../attendance_dashboard/widget/bottom_sheet/attendance_success_bottom_sheet.dart';

class SelfieCameraWidget extends StatefulWidget {
  final SelfieCameraWidgetArgument argument;
  const SelfieCameraWidget(this.argument, {Key? key}) : super(key: key);

  @override
  State<SelfieCameraWidget> createState() => _SelfieCameraWidgetState();
}

class _SelfieCameraWidgetState extends State<SelfieCameraWidget> with WidgetsBindingObserver {
  List<CameraDescription> cameras = [];
  CameraController? controller;

  // Initial values
  bool _isCameraPermissionGranted = false;
  bool _isCameraInitialized = false;
  bool _isRearCameraSelected = true;


  final resolutionPresets = ResolutionPreset.values;

  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  getPermissionStatus() async {
    await Permission.camera.request();
    var status = await Permission.camera.status;

    if (status.isGranted) {
      setState(() {
        _isCameraPermissionGranted = true;
      });
      // Fetch the available cameras before initializing the app.
      try {
        WidgetsFlutterBinding.ensureInitialized();
        cameras = await availableCameras();
      } on CameraException catch (e) {
        AppLog.e('Error in fetching the cameras: $e');
      }
      // Set and initialize the new camera
      onNewCameraSelected(cameras[1]);
    } else {
      AppLog.e('Camera Permission: DENIED');
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;

    if (cameraController!.value.isTakingPicture) {
      /// A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      AppLog.e('Error occurred while taking picture: $e');
      return null;
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    /// Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
      const size = Size(Dimens.cameraPreviewWidth_300, Dimens.cameraPreviewHeight_300);
      cameraController.value = cameraController.value.copyWith(previewSize: size);
      setState(() {});
    } on CameraException catch (e) {
      AppLog.e('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller!.setExposurePoint(offset);
    controller!.setFocusPoint(offset);
  }

  @override
  void initState() {
    getPermissionStatus();
    super.initState();
    context.read<SelfieCameraCubit>().updateArguments(widget.argument.punchType, widget.argument.attendanceType);
    StreamSubscription<gl.ServiceStatus> serviceStatusStream =
        gl.Geolocator.getServiceStatusStream()
            .listen((gl.ServiceStatus status) {
      if (status == gl.ServiceStatus.enabled) {
        context.read<SelfieCameraCubit>().getLocationAndAddress(widget.argument.workLocation);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    /// App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultAppBar(
                isBackIconVisible: true,
                title: 'taking_selfie'.tr),
            Expanded(
              child: InternetSensitive(
                child: SingleChildScrollView(child: buildBody()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return BlocConsumer<SelfieCameraCubit, SelfieCameraState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {
        if (state.uiState?.event == Event.updated) {
          showAttendanceSuccessBottomSheet(Get.context!, whenComplete: () {
            MRouter.pop(true);
          });
        }
        if (state.uiState?.event == Event.locationSetting) {
          showLocationServiceEnableAlertDialogWithOnTap(context, () async {
            await gl.Geolocator.openLocationSettings();
          });
        }
        if (state.uiState?.failedWithoutAlertMessage.isNotEmpty ?? false) {
          Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
        }
      },
      buildWhen: (prev, cur) {
        return (prev.isShowImagePreview != cur.isShowImagePreview);
      },
      builder: (context, state) {
        if(state.isShowImagePreview ?? false) {
          return buildImagePreviewWidget(state);
        } else {
          return _isCameraPermissionGranted
              ? _isCameraInitialized
              ? buildCameraWidget()
              : buildCameraLoadingWidget()
              : buildPermissionDeniedWidget();
        }
      },
    );
  }

  Widget buildCameraWidget() {
    return Column(
      children: [
        buildTopDescriptionWidget(),
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.padding_48, Dimens.padding_24, Dimens.padding_48, 0),
          child: CameraPreview(
            controller!,
            child: LayoutBuilder(builder:
                (BuildContext context,
                BoxConstraints constraints) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (details) =>
                    onViewFinderTap(details, constraints),
              );
            }),
          ),
        ),
        buildClickPictureButton(),
      ],
    );
  }

  Widget buildTopDescriptionWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_24, Dimens.padding_24, Dimens.padding_24, 0),
      child: Text('selfie_will_be_validated_against_the_picture'.tr, textAlign: TextAlign.center, style: Get.textTheme.bodyMedium),
    );
  }

  Widget buildCameraLoadingWidget() {
    return const Center(
      child: Text(
        'LOADING',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget buildPermissionDeniedWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Permission denied',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            getPermissionStatus();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Give permission',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildClickPictureButton() {
    return BlocBuilder<SelfieCameraCubit, SelfieCameraState>(
      buildWhen: (previousState, state) {
        return previousState.clickPictureBtnState != state.clickPictureBtnState;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.padding_24, Dimens.padding_64, Dimens.padding_24, Dimens.padding_48),
          child: RaisedRectButton(
            buttonState: state.clickPictureBtnState,
            text: 'click_picture'.tr,
            onPressed: () async {
              _captureImage();
            },
          ),
        );
      },
    );
  }

  _captureImage() async {
    context.read<SelfieCameraCubit>().updateClickPictureButtonState(true);
    XFile? rawImage = await takePicture();
    context.read<SelfieCameraCubit>().updateRawImage(rawImage);
  }

  Widget buildImagePreviewWidget(SelfieCameraState state) {
    return Column(
      children: [
        buildTopDescriptionWidget(),
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.padding_48, Dimens.padding_24, Dimens.padding_48, 0),
          child: Image.file(
            File(state.rawImage!.path),
            width: Dimens.cameraPreviewWidth_300,
            height: Dimens.cameraPreviewHeight_300,
            fit: BoxFit.fitWidth,
          ),
        ),
        buildPunchTime(),
        buildPunchDate(),
        const SizedBox(height: Dimens.padding_8),
        buildAddressWidget(),
        buildWorkLocationErrorWidget(),
        buildSubmitButton(),
        buildClickAgainButton(),
      ],
    );
  }

  Widget buildPunchTime() {
    String punchTime = DateTimeHelper.getFormattedDateTime(DateTimeHelper.timeFormatHMA);
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_24, Dimens.padding_8, Dimens.padding_24, 0),
      child: Text(punchTime, textAlign: TextAlign.center, style: Get.textTheme.labelLarge?.copyWith(color: Get.theme.getCustomColor(context).skirretgreen)),
    );
  }

  Widget buildPunchDate() {
    String punchDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatDDMMMYYYY);
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_24, 0, Dimens.padding_24, 0),
      child: Text(punchDate, textAlign: TextAlign.center, style: Get.textTheme.labelLarge?.copyWith(color: Get.theme.getCustomColor(context).skirretgreen)),
    );
  }

  Widget buildAddressWidget() {
    context.read<SelfieCameraCubit>().getLocationAndAddress(widget.argument.workLocation);
    return BlocBuilder<SelfieCameraCubit, SelfieCameraState>(
      buildWhen: (prev, cur) {
        return (prev.isPlaceMarksLoading != cur.isPlaceMarksLoading || prev.placeMarkList != cur.placeMarkList
          || prev.attendanceType != cur.attendanceType);
      },
      builder: (context, state) {
        bool isShowGeoAddress = false;
        if(state.attendanceType != null) {
          switch(state.attendanceType!) {
            case AttendanceType.geo:
            case AttendanceType.selfieAndGeo:
              isShowGeoAddress = true;
              break;
            default:
              isShowGeoAddress = false;
          }
        }
        if(isShowGeoAddress && (state.isPlaceMarksLoading ?? false)) {
          return const AppCircularProgressIndicator();
        } else if(isShowGeoAddress) {
          Placemark placemark = state.placeMarkList![0];
          return Padding(
            padding: const EdgeInsets.fromLTRB(
                Dimens.padding_24, 0, Dimens.padding_24, 0),
            child: Text('${placemark.name}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.country}, ${placemark.postalCode}',
                textAlign: TextAlign.center, style: Get.textTheme.bodyMedium),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildWorkLocationErrorWidget() {
    return BlocBuilder<SelfieCameraCubit, SelfieCameraState>(
      buildWhen: (prev, cur) {
        return (prev.workLocationErrorMessage != cur.workLocationErrorMessage);
      },
      builder: (context, state) {
        if(state.workLocationErrorMessage != null) {
          Placemark placemark = state.placeMarkList![0];
          return Padding(
            padding: const EdgeInsets.fromLTRB(
                Dimens.padding_24, Dimens.padding_8, Dimens.padding_24, 0),
            child: Text(state.workLocationErrorMessage ?? '',
                textAlign: TextAlign.center, style: Get.textTheme.bodyMedium?.copyWith(color: Get.theme.colorScheme.error)),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildSubmitButton() {
    return BlocBuilder<SelfieCameraCubit, SelfieCameraState>(
      buildWhen: (previousState, state) {
        return previousState.submitBtnState != state.submitBtnState;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.padding_24, Dimens.padding_24, Dimens.padding_24, 0),
          child: RaisedRectButton(
            buttonState: state.submitBtnState,
            text: 'submit'.tr,
            onPressed: () async {
              FlavorCubit flavorCubit = context.read<FlavorCubit>();
              context.read<SelfieCameraCubit>().compressUploadImageAndDoPunch(flavorCubit);
            },
          ),
        );
      },
    );
  }

  Widget buildClickAgainButton() {
    return BlocBuilder<SelfieCameraCubit, SelfieCameraState>(
      buildWhen: (previousState, state) {
        return previousState.submitBtnState != state.submitBtnState;
      },
      builder: (context, state) {
        if((state.submitBtnState?.isEnable ?? false) && !(state.submitBtnState?.isLoading ?? false)) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.padding_24, Dimens.padding_24, Dimens.padding_24, Dimens.padding_48),
            child: RaisedRectButton(
              buttonState: state.clickPictureBtnState,
              backgroundColor: AppColors.transparent,
              borderColor: Get.theme.colorScheme.primary,
              textColor: Get.theme.colorScheme.primary,
              text: 'click_again'.tr,
              onPressed: () async {
                context.read<SelfieCameraCubit>().showCamera();
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

}

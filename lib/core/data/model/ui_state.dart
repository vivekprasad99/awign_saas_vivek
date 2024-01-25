enum Event {
  success,
  failed,
  otpSent,
  none,
  verified,
  created,
  updated,
  accepted,
  selected,
  rejected,
  deleted,
  reloadWidget,
  locationSetting,
}

class UIState {
  bool isOnScreenLoading;
  bool isDialogLoading;
  String successWithAlertMessage;
  String loadingMessage;
  String successWithoutAlertMessage;
  String failedWithAlertMessage;
  String failedWithoutAlertMessage;
  Event event;
  dynamic data;

  UIState(
      {this.isOnScreenLoading = false,
      this.isDialogLoading = false,
      this.successWithAlertMessage = '',
      this.loadingMessage = '',
      this.successWithoutAlertMessage = '',
      this.failedWithAlertMessage = '',
      this.failedWithoutAlertMessage = '',
      this.event = Event.none,
      this.data});
}

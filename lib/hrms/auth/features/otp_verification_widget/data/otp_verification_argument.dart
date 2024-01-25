class OTPVerificationArgument {
  String mobileNumber, resendTime;

  OTPVerificationArgument(this.mobileNumber, this.resendTime);
  
  int getTimerSecond() {
    return int.parse(resendTime.split(' ')[0]);
  }
}
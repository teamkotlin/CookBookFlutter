abstract class OtpState{}
class OtpInitialState extends OtpState{}
class OtpLoadingState extends OtpState{}
class OtpSendState extends OtpState{}
class OtpVerifiedState extends OtpState{}
class OtpErrorState extends OtpState{
  final String message;
  OtpErrorState(this.message);
}
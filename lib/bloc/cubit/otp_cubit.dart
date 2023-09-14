import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/bloc/cubit/otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitialState());
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  sendOtp(String phone) {
    emit(OtpLoadingState());
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: signInWithPhone,
        verificationFailed: (e) {
          emit(OtpErrorState("${e.message}"));
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          emit(OtpSendState());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          emit(OtpErrorState("Otp retrieval time out."));
        });
  }

  verifyOtp(String otp) {
    emit(OtpLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId ?? '', smsCode: otp);
    signInWithPhone(credential);
  }

  signInWithPhone(PhoneAuthCredential credential) async {
    try{
      UserCredential userCredential=await _auth.signInWithCredential(credential);
      if(userCredential.user != null){
        emit(OtpVerifiedState());
      }else{
        emit(OtpErrorState("Unable to sign in."));
      }
    }catch(e){
      emit(OtpErrorState("$e"));
    }

  }
}

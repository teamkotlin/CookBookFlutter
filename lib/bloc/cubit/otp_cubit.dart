import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/bloc/cubit/otp_state.dart';

class OtpCubit extends Cubit<OtpState>{
  OtpCubit():super(OtpInitialState());
}
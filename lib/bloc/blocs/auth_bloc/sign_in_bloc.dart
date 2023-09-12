import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/bloc/blocs/auth_bloc/sign_in_event.dart';
import 'package:flutter_projects/bloc/blocs/auth_bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInTextChangedEvent>((event, emit) {
      if (event.email == "") {
        emit(SignInErrorState("Invalid email"));
      } else if (event.password == "") {
        emit(SignInErrorState("Invalid password"));
      } else {
        emit(SignInValidState());
      }
    });
    on<SignInSubmittedEvent>((event, emit) => emit(SignInLoadingState()));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/bloc/blocs/auth_bloc/sign_in_bloc.dart';
import 'package:flutter_projects/bloc/blocs/auth_bloc/sign_in_event.dart';
import 'package:flutter_projects/bloc/blocs/auth_bloc/sign_in_state.dart';
import 'package:flutter_projects/bloc/repositories/post_repository.dart';

import '../../routes/route_names.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SignInBloc, SignInState>(
          builder: (BuildContext context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is SignInErrorState)
                  Text(
                    state.errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                TextField(
                  onChanged: (val) {
                    BlocProvider.of<SignInBloc>(context).add(
                        SignInTextChangedEvent(_email.text, _password.text));
                  },
                  controller: _email,
                  decoration: InputDecoration(hintText: "Enter Email"),
                ),
                TextField(
                    onChanged: (val) {
                      BlocProvider.of<SignInBloc>(context).add(
                          SignInTextChangedEvent(_email.text, _password.text));
                    },
                    controller: _password,
                    decoration: InputDecoration(hintText: "Enter Password")),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: state is SignInValidState
                            ? Colors.teal
                            : Colors.grey),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.connectvity_screen,arguments: {"title":"Connectivity"});
                    },
                    child: Text("Signin"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/bloc/cubit/otp_cubit.dart';
import 'package:flutter_projects/bloc/cubit/otp_state.dart';

import '../../routes/route_names.dart';
import 'otp_verification_screen.dart';

class PhoneAuthScreen extends StatelessWidget {
  PhoneAuthScreen({Key? key}) : super(key: key);

  final _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth'),
      ),
      body: BlocConsumer<OtpCubit, OtpState>(listener: (context, state) {
        if (state is OtpErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${state.message}')));
        }
        if (state is OtpSendState) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context)=>OtpVerificationScreen()));
          // Navigator.pushNamed(context, RouteNames.verify_otp_screen);
        }
      }, builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: 'Enter Phone', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: state is OtpLoadingState
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.teal,
                          ),
                        )
                      : ElevatedButton(
                          child: Text(
                            'Send Otp',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (_phone.text.toString().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Enter your phone number!')));
                              return;
                            }
                            BlocProvider.of<OtpCubit>(context)
                                .sendOtp(_phone.text.toString());
                          }))
            ],
          ),
        );
      }),
    );
  }
}

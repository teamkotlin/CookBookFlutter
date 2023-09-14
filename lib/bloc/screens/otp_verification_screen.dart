import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/bloc/cubit/otp_cubit.dart';
import 'package:flutter_projects/bloc/cubit/otp_state.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({Key? key}) : super(key: key);
  final _otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Phone Auth'),
        ),
        body: BlocConsumer<OtpCubit, OtpState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _otp,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'Enter Otp', border: OutlineInputBorder()),
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
                                'Verify Otp',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if(_otp.text.toString().isEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter Otp')));
                                  return;
                                }
                                BlocProvider.of<OtpCubit>(context).verifyOtp(_otp.text.toString());
                              }))
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state is OtpErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('${state.message}')));
            }if (state is OtpVerifiedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Phone Verified')));
            }
          },
        ));
  }
}

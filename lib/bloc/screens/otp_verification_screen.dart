import 'package:flutter/material.dart';
class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Auth'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: 'Enter Otp',
                  border: OutlineInputBorder()
              ),

            ),
            SizedBox(height: 20,),
            SizedBox(width: double.infinity,child: ElevatedButton(child: Text('Verify Otp',style: TextStyle(color: Colors.white),), onPressed: (){}))
          ],
        ),
      ),
    );
  }
}

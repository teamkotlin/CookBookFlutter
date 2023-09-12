import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_projects/routes/route_names.dart';
class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

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
                hintText: 'Enter Phone',
                border: OutlineInputBorder()
              ),

            ),
            SizedBox(height: 20,),
            SizedBox(width: double.infinity,child: ElevatedButton(child: Text('Send Otp',style: TextStyle(color: Colors.white),), onPressed: (){
              Navigator.pushNamed(context, RouteNames.verify_otp_screen);
            }))
          ],
        ),
      ),
    );
  }
}

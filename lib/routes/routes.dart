import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/bloc/screens/connectivity_screen.dart';
import 'package:flutter_projects/bloc/screens/home_screen.dart';
import 'package:flutter_projects/bloc/screens/otp_verification_screen.dart';
import 'package:flutter_projects/bloc/screens/signin_screen.dart';
import 'package:flutter_projects/routes/route_names.dart';

import '../bloc/screens/phone_auth_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.sign_screen:
        return MaterialPageRoute(builder: (context) => SigninScreen());
      case RouteNames.connectvity_screen:
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => ConnectivityScreen(
                  title: arguments['title'],
                ));
      case RouteNames.home_screen:
        return MaterialPageRoute(builder: (context) => BlocHomeScreen());
      case RouteNames.phone_auth_screen:
        return MaterialPageRoute(builder: (context) => PhoneAuthScreen());
      case RouteNames.verify_otp_screen:
        return CupertinoPageRoute(builder: (context) => OtpVerificationScreen());
    }
  }
}

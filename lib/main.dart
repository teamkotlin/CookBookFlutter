import 'package:flutter/material.dart';

import 'animation/animate_page_route.dart';
import 'design/export_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Raleway',
      ),
      //home: AnimatePageRouteScreen(),
      home: ExportingFonts(),
    );
  }
}



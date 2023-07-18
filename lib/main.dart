import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animation/animate_page_route.dart';
import 'design/export_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.ralewayTextTheme(baseTheme.textTheme),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      //home: AnimatePageRouteScreen(),
      home: ExportingFonts(),
    );
  }
}



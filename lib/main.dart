import 'package:flutter/material.dart';
import 'package:flutter_projects/test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animation/animate_page_route.dart';
import 'design/ui_change_orientation.dart';
import 'effects/downloading_screen.dart';
import 'effects/filter_carousel.dart';

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
      //theme: _buildTheme(Brightness.light),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
        primaryColor: Colors.blue[800],
        appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.amberAccent,
            scrolledUnderElevation: 0.2,
            elevation: 3),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              fontSize: 22,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Raleway'),
        ),
        fontFamily: 'Raleway',
      ),
      //home: AnimatePageRouteScreen(),
      //home: ExportingFonts(),
      //home: UIChangeOrientaion(),
      //home: DownloadingScreen(),
      home: FilterCarousel(),
    );
  }
}

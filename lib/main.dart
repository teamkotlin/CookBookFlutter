import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/bloc/blocs/internet_bloc/internet_bloc.dart';
import 'package:flutter_projects/bloc/cubit/internet_cubit.dart';
import 'package:flutter_projects/plugins/video_player_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/screens/connectivity_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final CameraDescription camera = cameras.first;
  runApp(MyApp(
    camera: camera,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.ralewayTextTheme(baseTheme.textTheme),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {return InternetCubit(); },
      child: MaterialApp(
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
        //home: FilterCarousel(),
        // home: TakePictureScreen(
        //   camera: camera,
        // ),
        //home: VideoPlayerScreen(),
        home: ConnectivityScreen(),
      ),
    );
  }
}

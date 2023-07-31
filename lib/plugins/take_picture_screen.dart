import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,required this.camera
  }) : super(key: key);
final CameraDescription camera;
  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeController;
  XFile? image;

  void initializeCameras() async {
    final cameras = await availableCameras();
    final CameraDescription camera = cameras.first;
    _controller = CameraController(camera, ResolutionPreset.medium);
    _initializeController = _controller.initialize();
  }

  @override
  void initState() {
    super.initState();
    //initializeCameras();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeController = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: image != null
            ? Image.file(File(image!.path))
            : FutureBuilder<void>(
                future: _initializeController,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeController;
            image = await _controller.takePicture();
            if (!mounted) return;
            setState(() {
              
            });
          } catch (e) {
            debugPrint("Failed to take picture=>$e");
          }
        },
        child: const Icon(CupertinoIcons.camera),
      ),
    );
  }
}

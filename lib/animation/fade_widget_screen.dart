import 'package:flutter/material.dart';

class FadeWidgetScreen extends StatefulWidget {
  const FadeWidgetScreen({Key? key}) : super(key: key);

  @override
  State<FadeWidgetScreen> createState() => _FadeWidgetScreenState();
}

class _FadeWidgetScreenState extends State<FadeWidgetScreen> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Fade'),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(

          children: [
            AnimatedOpacity(
              opacity: _visible ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linearToEaseOut,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: !_visible ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linearToEaseOut,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,

                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _visible = !_visible;
          });
        },
        child: Icon(Icons.flip),
      ),
    );
  }
}

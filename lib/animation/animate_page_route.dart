import 'package:flutter/material.dart';
import 'package:flutter_projects/animation/animate_widget_physics.dart';

import 'fade_widget_screen.dart';

class AnimatePageRouteScreen extends StatelessWidget {
  const AnimatePageRouteScreen({Key? key}) : super(key: key);

  _buildRoute(
      {required Offset beginOffset,
      required Curve curve,
      required Widget child}) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          /*final tween = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
              .chain(CurveTween(curve: Curves.easeOutQuint));*/
          final tween = Tween<Offset>(begin: beginOffset, end: Offset(0, 0));
          final offsetAnimation = animation.drive(tween);
          final curveAnimation =
              CurvedAnimation(parent: animation, curve: curve);
          return SlideTransition(
            //position: offsetAnimation,
            position: tween.animate(curveAnimation),
            child: child,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animate Page Route Transition'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  _buildRoute(
                      beginOffset: Offset(1, 0),
                      curve: Curves.easeOutQuint,
                      child: NextScreen()),
                );
              },
              child: Text("Move Next"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  _buildRoute(
                      beginOffset: Offset(0, 1),
                      curve: Curves.easeOutCirc,
                      child: AnimateWidgetPhysics()),
                );
              },
              child: Text("Draggable Widget"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  _buildRoute(
                      beginOffset: Offset(1, 1),
                      curve: Curves.easeOutQuart,
                      child: FadeWidgetScreen()),
                );
              },
              child: Text("Animated Fade Widget"),
            ),
          ],
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Page Route'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Back"),
        ),
      ),
    );
  }
}

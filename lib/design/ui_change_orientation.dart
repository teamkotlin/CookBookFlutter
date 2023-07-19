import 'package:flutter/material.dart';

class UIChangeOrientaion extends StatefulWidget {
  const UIChangeOrientaion({Key? key}) : super(key: key);

  @override
  State<UIChangeOrientaion> createState() => _UIChangeOrientaionState();
}

class _UIChangeOrientaionState extends State<UIChangeOrientaion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UI Change On Orientation'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) => GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              crossAxisSpacing: 8,
              childAspectRatio: 1.5),
          children: [
            ...List.generate(
                100,
                (index) => Center(
                      child: Text(
                        'Item $index',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}

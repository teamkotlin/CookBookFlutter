import 'package:flutter/material.dart';
class ExportingFonts extends StatefulWidget {
  const ExportingFonts({Key? key}) : super(key: key);

  @override
  State<ExportingFonts> createState() => _ExportingFontsState();
}

class _ExportingFontsState extends State<ExportingFonts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exporting Fonts'),),
      body: Center(child: ElevatedButton(child: Text('Show SnackBar'),onPressed: (){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Click Snack")));
      },),),
    );
  }
}

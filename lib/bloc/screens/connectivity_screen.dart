import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/bloc/blocs/internet_bloc/internet_bloc.dart';
import 'package:flutter_projects/bloc/blocs/internet_bloc/internet_state.dart';

class ConnectivityScreen extends StatelessWidget {
  const ConnectivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Connectivity"),),
      body: BlocConsumer<InternetBloc,InternetState>(
        builder: (BuildContext context, state) {
          if (state is InternetGainedState) {
            return Center(child: Text("Connection established."));
          } else if (state is InternetLostState) {
            return Center(child: Text("Connection lost."));
          }
          return Center(child: Text('Loading...'));
        },
        listener: (BuildContext context, Object? state) {
          if (state is InternetLostState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Internet Lost...'),
              backgroundColor: Colors.red,
            ));
          } else if (state is InternetGainedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Internet Gained...'),
              backgroundColor: Colors.green,
            ));
          }
        },
      ),
    );
  }
}

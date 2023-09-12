import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/bloc/cubit/post_cubit.dart';
import 'package:flutter_projects/bloc/cubit/post_state.dart';

class BlocHomeScreen extends StatelessWidget {
  const BlocHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SafeArea(
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state is PostErrorState)
              return Center(
                child: Text(state.error),
              );
            if (state is PostLoadedState)
              return ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                      title: Text(
                        state.posts[index].title ?? "N/A",
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        state.posts[index].body ?? "N/A",
                        style: TextStyle(color: Colors.black),
                      ),
                    isThreeLine:true
                      ));
            return Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/bloc/cubit/post_state.dart';
import 'package:flutter_projects/bloc/repositories/post_repository.dart';

import '../../models/post.dart';

class PostCubit extends Cubit<PostState>{
  PostRepository _postRepository = PostRepository();
  PostCubit():super(PostLoadingState()){
    fetchPosts();
  }
  fetchPosts()async{
    try{
      final List<Post> posts =await _postRepository.fetchPosts();
      emit(PostLoadedState(posts));
    }catch(e){
      emit(PostErrorState("error fetching posts $e"));
    }

  }
}
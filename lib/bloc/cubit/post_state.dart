import '../../models/post.dart';

abstract class PostState{}
class PostLoadingState extends PostState{}
class PostLoadedState extends PostState{
  List<Post> posts;
  PostLoadedState(this.posts);
}
class PostErrorState extends PostState{
  final String error;
  PostErrorState(this.error);
}
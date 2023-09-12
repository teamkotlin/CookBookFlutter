import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_projects/bloc/api/api.dart';
import 'package:flutter_projects/models/post.dart';

class PostRepository {
  Api api = Api();

  Future<List<Post>> fetchPosts() async {
    try {
      Response response = await api.dio.get('/posts');
      debugPrint("pr=>${response.data}");
      List<dynamic> postsData = response.data;
      return postsData.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}

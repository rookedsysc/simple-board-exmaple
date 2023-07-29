import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_board/controller/provider/dio_provider.dart';
import 'package:simple_board/model/post_entity.dart';
import 'package:simple_board/model/post_request_model.dart';

part 'post_repository.g.dart';

@riverpod
PostRepository postRepository(PostRepositoryRef ref) {
  final Dio dio = ref.read(dioProvider);
  return PostRepository(dio);
}

class PostRepository {
  final Dio _dio;
  final String _url = 'http://localhost:8080/api/post';

  PostRepository(this._dio);

  Future<void> create(PostRequestModel model) async {
    try {
      await _dio.post(_url, data: model.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<PostEntity>> getAllPost() async {
    final Response resp = await _dio.get(_url + '/all');
    List<PostEntity> result = [];
    try {
      List<dynamic> data = resp.data as List;
      result = data.map((e) => PostEntity.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }
}

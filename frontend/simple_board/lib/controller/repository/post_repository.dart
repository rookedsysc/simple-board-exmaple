import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_board/common/interface/repository_base.dart';
import 'package:simple_board/common/interface/request_base.dart';
import 'package:simple_board/controller/provider/dio_provider.dart';
import 'package:simple_board/model/post_entity.dart';
import 'package:simple_board/model/post_request_model.dart';
import 'package:simple_board/model/post_view_model.dart';

part 'post_repository.g.dart';

@riverpod
PostRepository postRepository(PostRepositoryRef ref) {
  final Dio dio = ref.read(dioProvider);
  return PostRepository(dio);
}

class PostRepository implements RepositoryBase<PostEntity> {
  final Dio _dio;
  final String _url = 'http://localhost:8080/api/post';

  PostRepository(this._dio);

  @override
  Future<void> create<R extends RequestBase>(R request) async {
    if (request is PostCreateRequest) {
        try {
      await _dio.post(_url, data: request.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
    } else {
      throw Exception("Post Create Request Type Error");
    }
  }

  @override
  Future<void> delete<R extends RequestBase>(R request) async {
    try {
      PostViewModel postViewModel = request as PostViewModel;
      await _dio.post("$_url/delete", data: postViewModel.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PostEntity> get(double id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<PostEntity>> getAll() async {
        final Response resp = await _dio.get('$_url/all');
    List<PostEntity> result = [];
    try {
      debugPrint(resp.data.toString());
      List<dynamic> data = resp.data as List;
      result = data.map((e) => PostEntity.fromJson(e)).toList();
    } catch (e) {
      debugPrint("\n Get All Post Error : $e");
    }
    return result;
  }
}

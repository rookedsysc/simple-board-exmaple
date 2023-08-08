import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_board/common/interface/repository_base.dart';
import 'package:simple_board/common/interface/request_base.dart';
import 'package:simple_board/controller/provider/dio_provider.dart';
import 'package:simple_board/model/board_entity.dart';
import 'package:simple_board/model/board_request_model.dart';

part 'board_repository.g.dart';

@riverpod
BoardRepository boardRepository(BoardRepositoryRef ref) {
  final Dio dio = ref.read(dioProvider);
  return BoardRepository(dio);
}

class BoardRepository implements RepositoryBase<BoardEntity> {
  final Dio _dio;
  final String _url = 'http://localhost:8080/api/board';
  BoardRepository(this._dio);

  @override
  Future<void> create<R extends RequestBase>(R request) async {
    if (R is BoardCreateModel) {
      try {
        BoardCreateModel boardCreateModel = request as BoardCreateModel;
        await _dio.post(_url, data: boardCreateModel.toJson());
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      throw Exception("Board Create Request Type Error");
    }
  }

  @override
  Future<void> delete<R extends RequestBase>(R request) async {
    try {
      BoardDeleteModel boardDeleteModel = request as BoardDeleteModel;
      await _dio.post("$_url/delete/${boardDeleteModel.id}");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<BoardEntity> get(double id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<BoardEntity>> getAll() async {
    final Response resp = await _dio.get('$_url/all');
    List<BoardEntity> result = [];
    try {
      List data = resp.data as List;
      result = data.map((e) => BoardEntity.fromJson(e)).toList();
    } catch (e) {
      debugPrint("\n Get All Board Error : $e");
    }
    return result;
  }
}

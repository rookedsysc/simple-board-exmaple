import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:simple_board/common/interface/repository_base.dart';
import 'package:simple_board/common/interface/request_base.dart';
import 'package:simple_board/model/board_entity.dart';
import 'package:simple_board/model/board_request_model.dart';

class BoardRepository implements RepositoryBase<BoardCreateModel, RequestBase, BoardEntity> {
  final Dio _dio;
  final String _url = 'http://localhost:8080/api/board';
  BoardRepository(this._dio);
  
  @override
  Future<void> create(BoardCreateModel request) async {
    try {
      await _dio.post(_url, data: request.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<void> delete(RequestBase request) async {
    // TODO: implement get
    throw UnimplementedError();
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
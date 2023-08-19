import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_board/common/interface/repository_base.dart';
import 'package:simple_board/common/model/pagination_model.dart';
import 'package:simple_board/common/model/pagination_params.dart';
import 'package:simple_board/controller/provider/dio_provider.dart';
import 'package:simple_board/model/board_entity.dart';

part 'board_repository.g.dart';

@riverpod
BoardRepository boardRepository(BoardRepositoryRef ref) {
  final Dio dio = ref.read(dioProvider);
  return BoardRepository(dio, baseUrl: "http://localhost:8080/api/board");
}

@RestApi()
abstract class BoardRepository
    extends RepositoryBase<BoardEntity, CursorPagination<BoardEntity>> {
  factory BoardRepository(Dio dio, {String baseUrl}) = _BoardRepository;

  @override
  @POST("")
  Future<void> create<BoardCreateModel>(@Body()BoardCreateModel request);
  @override
  @GET("/all")
  Future<CursorPagination<BoardEntity>> paginate(@Queries() PaginationParams? params);
  @override
  @GET("/id/{id}")
  Future<BoardEntity> get(@Path() double id);
  @override
  @DELETE("/delete/{id}")
  Future<void> delete<double>(@Path() double request);
}



import 'package:dio/dio.dart' hide Headers;
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_board/common/interface/repository_base.dart';
import 'package:simple_board/common/model/pagination_model.dart';
import 'package:simple_board/common/model/pagination_params.dart';
import 'package:simple_board/controller/provider/dio_provider.dart';
import 'package:simple_board/model/post_entity.dart';
import 'package:simple_board/model/post_request_dto.dart';

part 'post_repository.g.dart';

@riverpod
PostRepository postRepository(PostRepositoryRef ref) {
  final Dio dio = ref.read(dioProvider);

  return PostRepository(dio, baseUrl: "http://localhost:8080/api/post");
}

@RestApi()
abstract class PostRepository
    extends RepositoryBase<PostEntity, CursorPagination<PostEntity>> {
  factory PostRepository(Dio dio, {String baseUrl}) = _PostRepository;

  @override
  @POST("")
  @Headers({"content-type": "application/json"})
  Future<void> create<PostCreateModel>(@Body()PostCreateModel request);

  @override
  @PUT("")
  Future<void> update<PostCreateModel>(@Body()PostCreateModel request);

  @override
  @GET("/all")
  Future<CursorPagination<PostEntity>> paginate(@Queries() PaginationParams? params);

  @override
  @GET("/id/{id}")
  Future<PostEntity> get(@Path() int id);

  @override
  @DELETE("/delete/{id}")
  @Headers({"content-type": "application/json"})
  Future<void> delete(@Path() int id);

  @GET("/board/{id}")
  Future<CursorPagination<PostEntity>> getPostListByBoardId(
    @Path() int id,
    @Queries() PaginationParams? params
  );

  @POST("/password")
  @Headers({"content-type": "application/json"})
  Future<bool> checkPassword(@Body()PostDeleteDTO request);
}
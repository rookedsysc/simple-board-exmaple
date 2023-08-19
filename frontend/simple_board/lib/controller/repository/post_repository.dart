import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_board/common/interface/repository_base.dart';
import 'package:simple_board/common/model/pagination_model.dart';
import 'package:simple_board/common/model/pagination_params.dart';
import 'package:simple_board/controller/provider/dio_provider.dart';
import 'package:simple_board/model/post_entity.dart';

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
  Future<void> create<PostCreateModel>(@Body()PostCreateModel request);
  @override
  @GET("/all")
  Future<CursorPagination<PostEntity>> paginate(@Queries() PaginationParams? params);
  @override
  @GET("/id/{id}")
  Future<PostEntity> get(@Path() double id);
  @override
  @DELETE("/delete/{id}")
  Future<void> delete<double>(@Path() double request);
  @GET("/board/{id}")
  Future<CursorPagination<PostEntity>> getPostListByBoardId(
    @Path() int id,
    @Queries() PaginationParams? params
  );
}
import 'package:retrofit/retrofit.dart';
import 'package:simple_board/common/interface/entity_base.dart';
import 'package:simple_board/common/interface/request_base.dart';
import 'package:simple_board/common/model/pagination_model.dart';
import 'package:simple_board/common/model/pagination_params.dart';


abstract class RepositoryRegacyBase<E extends EntityBase> {
  Future<void> create<R extends RequestBase>(R request);
  Future<List<E>> getAll();
  Future<E> get(int id);
  Future<void> delete<R extends RequestBase>(R request);
}

abstract class RepositoryBase<E extends EntityBase,C extends CursorPagination<E>> {

  @POST("")
  Future<void> create<R>(R request);

  @PUT("")
  Future<void> update<R>(R request);

  @GET("/all")
  Future<CursorPagination<E>> paginate(PaginationParams? params);

  @GET("/id/{id}")
  Future<E> get(int id);

  @DELETE("/delete/{id}")
  Future<void> delete(int id);
}


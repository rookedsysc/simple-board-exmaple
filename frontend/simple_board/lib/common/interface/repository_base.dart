import 'package:simple_board/common/interface/entity_base.dart';
import 'package:simple_board/common/interface/request_base.dart';

abstract class RepositoryBase<E extends EntityBase> {
  Future<void> create<R extends RequestBase>(R request);
  Future<List<E>> getAll();
  Future<E> get(double id);
  Future<void> delete<R extends RequestBase>(R request);
}

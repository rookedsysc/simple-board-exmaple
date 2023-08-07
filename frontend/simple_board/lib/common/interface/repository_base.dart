import 'package:simple_board/common/interface/entity_base.dart';
import 'package:simple_board/common/interface/request_base.dart';

abstract class RepositoryBase<CREATE extends RequestBase,
    DELETE extends RequestBase, ENTITY extends EntityBase> {
  Future<void> create(CREATE request);
  Future<List<ENTITY>> getAll();
  Future<ENTITY> get(double id);
  Future<void> delete(DELETE request);
}

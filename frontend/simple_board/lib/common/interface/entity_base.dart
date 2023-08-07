import 'package:simple_board/common/interface/request_base.dart';

abstract class EntityBase<R extends RequestBase> {
  String status;
  String title;
  String password;
  EntityBase({required this.password,required this.title,required this.status});

  R toDeleteRequest();
}
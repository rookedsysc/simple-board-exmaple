import 'package:simple_board/common/interface/request_base.dart';

abstract class EntityBase {
  String title;
  String password;
  EntityBase({required this.password,required this.title});
}
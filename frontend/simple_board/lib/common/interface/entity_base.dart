import 'package:simple_board/common/interface/request_base.dart';

abstract class EntityBase {
  final int id;
  String title;
  String password;
  EntityBase({required this.id,required this.password,required this.title});
}
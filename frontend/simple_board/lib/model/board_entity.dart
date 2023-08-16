
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_board/common/interface/request_base.dart';
import 'package:simple_board/model/board_request_dto.dart';
import 'package:simple_board/model/post_entity.dart';

import '../common/interface/entity_base.dart';

part 'board_entity.g.dart';

@JsonSerializable()
class BoardEntity implements EntityBase {
  double id;
  String boardName;
  @override
  String status;
  List<PostEntity>? postList;
  BoardEntity({
    required this.id,
    required this.boardName,
    required this.status,
    this.postList,
  });

  factory BoardEntity.fromJson(Map<String, dynamic> json) =>
      _$BoardEntityFromJson(json);
  Map<String, dynamic> toJson() => _$BoardEntityToJson(this);
  
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String password = "";

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String title = "";

  BoardDeleteModel toDeleteRequest() {
    BoardDeleteModel request = BoardDeleteModel(id: id);
    return request;
  }
}

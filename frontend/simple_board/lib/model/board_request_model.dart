import 'package:json_annotation/json_annotation.dart';
import 'package:simple_board/common/interface/request_base.dart';

part 'board_request_model.g.dart';

@JsonSerializable()
class BoardCreateModel implements RequestBase {
  @JsonKey(name: 'board_name')
  String boardName;
  BoardCreateModel({
    required this.boardName,
  });

  factory BoardCreateModel.fromJson(Map<String, dynamic> json) =>
      _$BoardCreateModelFromJson(json);
  Map<String, dynamic> toJson() => _$BoardCreateModelToJson(this);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String password = "";
}

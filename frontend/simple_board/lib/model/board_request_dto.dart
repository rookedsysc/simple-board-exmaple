import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_board/common/interface/request_base.dart';

part 'board_request_dto.g.dart';

final boardConfigProvider = StateProvider<BoardConfigModel>(
    (ref) => BoardConfigModel(id: null, boardName: ""));

@JsonSerializable()
class BoardDeleteModel implements RequestBase {
  final int id;
  BoardDeleteModel({
    required this.id,
  });

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String password = "";

  factory BoardDeleteModel.fromJson(Map<String, dynamic> json) => _$BoardDeleteModelFromJson(json);
  Map<String, dynamic> toJson() => _$BoardDeleteModelToJson(this);
}

@JsonSerializable()
class BoardConfigModel implements RequestBase {
  final int? id;
  @JsonKey(name: "board_name")
  final String boardName;
  BoardConfigModel({
    required this.id,
    required this.boardName,
  });

  copyWith({
    int? id,
    String? boardName,
  }) {
    return BoardConfigModel(
      id: id ?? this.id,
      boardName: boardName ?? this.boardName,
    );
  }

  static BoardConfigModel reset() {
    return BoardConfigModel(id: null, boardName: "");
  }

  factory BoardConfigModel.fromJson(Map<String, dynamic> json) =>
      _$BoardConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$BoardConfigModelToJson(this);

  @override
  String password = "";
}

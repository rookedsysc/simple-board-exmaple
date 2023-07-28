import 'package:json_annotation/json_annotation.dart';

part 'post_entity.g.dart';

@JsonSerializable()
class PostEntity {
  final double id;
  @JsonKey(name: 'board_id')
  final double boardId;
  @JsonKey(name: 'user_name')
  final String userName;
  final String password;
  final String email;
  final String status;
  final String title;
  final String? content;
  @JsonKey(name: 'posted_at')
  final DateTime postedAt;

  PostEntity({
    required this.id,
    required this.boardId,
    required this.userName,
    required this.password,
    required this.email,
    required this.status,
    required this.title,
    required this.content,
    required this.postedAt,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) =>
      _$PostEntityFromJson(json);
  Map<String, dynamic> toJson() => _$PostEntityToJson(this);
}

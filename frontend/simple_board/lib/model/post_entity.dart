import 'package:json_annotation/json_annotation.dart';
import 'package:simple_board/common/interface/entity_base.dart';
import 'package:simple_board/model/post_request_dto.dart';
import 'package:simple_board/model/reply_entity.dart';

part 'post_entity.g.dart';

@JsonSerializable()
class PostEntity implements EntityBase {
  @override
  final int id;
  @JsonKey(name: 'board_id')
  final int boardId;
  @JsonKey(name: 'user_name')
  final String userName;
  @override
  String password;
  final String email;
  @override
  String title;
  final String? content;
  final List<ReplyEntity>? replies;
  @JsonKey(name: 'posted_at')
  final DateTime postedAt;

  PostEntity copyWith({
    int? id,
    int? boardId,
    String? userName,
    String? password,
    String? email,
    String? title,
    String? content,
    DateTime? createdAt,
    List<ReplyEntity>? replies,
    DateTime? postedAt,
  }) {
    return PostEntity(
      id: id ?? this.id,
      boardId: boardId ?? this.boardId,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      email: email ?? this.email,
      title: title ?? this.title,
      content: content ?? this.content,
      replies: replies ?? this.replies,
      postedAt: postedAt ?? this.postedAt,
    );
  }

  PostEntity({
    required this.id,
    required this.boardId,
    required this.userName,
    required this.password,
    required this.email,
    required this.title,
    required this.content,
    required this.postedAt,
    this.replies,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) =>
      _$PostEntityFromJson(json);
  Map<String, dynamic> toJson() => _$PostEntityToJson(this);

  PostDeleteDTO toDeleteRequest() {
    PostDeleteDTO request = PostDeleteDTO(postId: id, password: password);
    return request;
  }
}

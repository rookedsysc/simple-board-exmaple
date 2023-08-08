import 'package:json_annotation/json_annotation.dart';
import 'package:simple_board/common/interface/entity_base.dart';
import 'package:simple_board/model/post_view_model.dart';
import 'package:simple_board/model/reply_entity.dart';

part 'post_entity.g.dart';

@JsonSerializable()
class PostEntity implements EntityBase<PostViewModel> {
  final double id;
  @JsonKey(name: 'board_id')
  final double boardId;
  @JsonKey(name: 'user_name')
  final String userName;
  @override
  String password;
  final String email;
  @override
  String status;
  @override
  String title;
  final String? content;
  @JsonKey(name: 'posted_at')
  final DateTime postedAt;
  final List<ReplyEntity>? replies;
  final int? replyCount;

  PostEntity copyWith({
    double? id,
    double? boardId,
    String? userName,
    String? password,
    String? email,
    String? status,
    String? title,
    String? content,
    DateTime? postedAt,
    List<ReplyEntity>? replies,
    int? replyCount,
  }) {
    return PostEntity(
      id: id ?? this.id,
      boardId: boardId ?? this.boardId,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      email: email ?? this.email,
      status: status ?? this.status,
      title: title ?? this.title,
      content: content ?? this.content,
      postedAt: postedAt ?? this.postedAt,
      replies: replies ?? this.replies,
      replyCount: replyCount ?? this.replyCount,
    );
  }

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
    required this.replies,
    required this.replyCount,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) =>
      _$PostEntityFromJson(json);
  Map<String, dynamic> toJson() => _$PostEntityToJson(this);

  @override
  PostViewModel toDeleteRequest() {
    PostViewModel request = PostViewModel(postId: id, password: password);
    return request;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostEntity _$PostEntityFromJson(Map<String, dynamic> json) => PostEntity(
      id: (json['id'] as num).toDouble(),
      boardId: (json['board_id'] as num).toDouble(),
      userName: json['user_name'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      status: json['status'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      postedAt: DateTime.parse(json['posted_at'] as String),
      replies: (json['replies'] as List<dynamic>?)
          ?.map((e) => ReplyEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      replyCount: json['replyCount'] as int?,
    );

Map<String, dynamic> _$PostEntityToJson(PostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'board_id': instance.boardId,
      'user_name': instance.userName,
      'password': instance.password,
      'email': instance.email,
      'status': instance.status,
      'title': instance.title,
      'content': instance.content,
      'posted_at': instance.postedAt.toIso8601String(),
      'replies': instance.replies,
      'replyCount': instance.replyCount,
    };

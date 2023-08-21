// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostEntity _$PostEntityFromJson(Map<String, dynamic> json) => PostEntity(
      id: json['id'] as int,
      boardId: json['board_id'] as int,
      userName: json['user_name'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      postedAt: DateTime.parse(json['posted_at'] as String),
      replies: (json['replies'] as List<dynamic>?)
          ?.map((e) => ReplyEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostEntityToJson(PostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'board_id': instance.boardId,
      'user_name': instance.userName,
      'password': instance.password,
      'email': instance.email,
      'title': instance.title,
      'content': instance.content,
      'replies': instance.replies,
      'posted_at': instance.postedAt.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyEntity _$ReplyEntityFromJson(Map<String, dynamic> json) => ReplyEntity(
      id: json['id'] as int,
      postId: json['postId'] as int,
      userName: json['userName'] as String,
      password: json['password'] as String,
      status: json['status'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      repliedAt: DateTime.parse(json['repliedAt'] as String),
    );

Map<String, dynamic> _$ReplyEntityToJson(ReplyEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'userName': instance.userName,
      'password': instance.password,
      'status': instance.status,
      'title': instance.title,
      'content': instance.content,
      'repliedAt': instance.repliedAt.toIso8601String(),
    };

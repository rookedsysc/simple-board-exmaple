// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDeleteDTO _$PostDeleteDTOFromJson(Map<String, dynamic> json) =>
    PostDeleteDTO(
      postId: (json['post_id'] as num).toDouble(),
      password: json['password'] as String,
    );

Map<String, dynamic> _$PostDeleteDTOToJson(PostDeleteDTO instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'password': instance.password,
    };

PostCreateDTO _$PostCreateDTOFromJson(Map<String, dynamic> json) =>
    PostCreateDTO(
      boardId: json['board_id'] as int? ?? 1,
      userName: json['user_name'] as String,
      email: json['email'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$PostCreateDTOToJson(PostCreateDTO instance) =>
    <String, dynamic>{
      'board_id': instance.boardId,
      'user_name': instance.userName,
      'email': instance.email,
      'password': instance.password,
      'title': instance.title,
      'content': instance.content,
    };

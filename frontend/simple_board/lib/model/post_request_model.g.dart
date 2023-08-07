// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCreateRequest _$PostCreateRequestFromJson(Map<String, dynamic> json) =>
    PostCreateRequest(
      userName: json['user_name'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$PostCreateRequestToJson(PostCreateRequest instance) =>
    <String, dynamic>{
      'user_name': instance.userName,
      'password': instance.password,
      'email': instance.email,
      'title': instance.title,
      'content': instance.content,
    };

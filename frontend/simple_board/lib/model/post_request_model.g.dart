// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostRequestModel _$PostRequestModelFromJson(Map<String, dynamic> json) =>
    PostRequestModel(
      userName: json['user_name'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$PostRequestModelToJson(PostRequestModel instance) =>
    <String, dynamic>{
      'user_name': instance.userName,
      'password': instance.password,
      'email': instance.email,
      'title': instance.title,
      'content': instance.content,
    };

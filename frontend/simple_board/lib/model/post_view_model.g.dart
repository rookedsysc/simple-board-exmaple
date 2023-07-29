// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostViewModel _$PostViewModelFromJson(Map<String, dynamic> json) =>
    PostViewModel(
      postId: (json['post_id'] as num).toDouble(),
      password: json['password'] as String,
    );

Map<String, dynamic> _$PostViewModelToJson(PostViewModel instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'password': instance.password,
    };

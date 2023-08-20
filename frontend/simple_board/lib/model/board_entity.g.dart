// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardEntity _$BoardEntityFromJson(Map<String, dynamic> json) => BoardEntity(
      id: json['id'] as int,
      boardName: json['board_name'] as String,
      postList: (json['post_list'] as List<dynamic>?)
          ?.map((e) => PostEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BoardEntityToJson(BoardEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'board_name': instance.boardName,
      'post_list': instance.postList,
    };

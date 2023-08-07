// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardEntity _$BoardEntityFromJson(Map<String, dynamic> json) => BoardEntity(
      id: (json['id'] as num).toDouble(),
      boardName: json['boardName'] as String,
      status: json['status'] as String,
      postList: (json['postList'] as List<dynamic>?)
          ?.map((e) => PostEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BoardEntityToJson(BoardEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'boardName': instance.boardName,
      'status': instance.status,
      'postList': instance.postList,
    };

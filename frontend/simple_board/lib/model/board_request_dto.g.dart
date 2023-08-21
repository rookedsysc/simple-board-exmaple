// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardDeleteModel _$BoardDeleteModelFromJson(Map<String, dynamic> json) =>
    BoardDeleteModel(
      id: json['id'] as int,
    );

Map<String, dynamic> _$BoardDeleteModelToJson(BoardDeleteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

BoardConfigModel _$BoardConfigModelFromJson(Map<String, dynamic> json) =>
    BoardConfigModel(
      id: json['id'] as int?,
      boardName: json['board_name'] as String,
    )..password = json['password'] as String;

Map<String, dynamic> _$BoardConfigModelToJson(BoardConfigModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'board_name': instance.boardName,
      'password': instance.password,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CursorPagination<E> _$CursorPaginationFromJson<E extends EntityBase>(
  Map<String, dynamic> json,
  E Function(Object? json) fromJsonE,
) =>
    CursorPagination<E>(
      meta:
          PaginationParams.fromJson(json['pagination'] as Map<String, dynamic>),
      data: (json['body'] as List<dynamic>).map(fromJsonE).toList(),
    );

Map<String, dynamic> _$CursorPaginationToJson<E extends EntityBase>(
  CursorPagination<E> instance,
  Object? Function(E value) toJsonE,
) =>
    <String, dynamic>{
      'pagination': instance.meta,
      'body': instance.data.map(toJsonE).toList(),
    };

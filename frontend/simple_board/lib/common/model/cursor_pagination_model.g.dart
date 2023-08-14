// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cursor_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CursorPagination<T> _$CursorPaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    CursorPagination<T>(
      meta: CursorPagination<dynamic>.fromJson(
          json['meta'] as Map<String, dynamic>, (value) => value),
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$CursorPaginationToJson<T>(
  CursorPagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'meta': instance.meta.toJson(
        (value) => value,
      ),
      'data': instance.data.map(toJsonT).toList(),
    };

CursorPaginationMeta _$CursorPaginationMetaFromJson(
        Map<String, dynamic> json) =>
    CursorPaginationMeta(
      json['current_elements'] as int,
      json['total_pages'] as int,
      (json['total_elements'] as num).toDouble(),
      count: json['count'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$CursorPaginationMetaToJson(
        CursorPaginationMeta instance) =>
    <String, dynamic>{
      'count': instance.count,
      'size': instance.size,
      'current_elements': instance.currentElements,
      'total_pages': instance.totalPages,
      'total_elements': instance.totalElements,
    };

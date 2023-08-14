// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cursor_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CursorPagination<T, C>
    _$CursorPaginationFromJson<T, C extends CursorPaginationMetaBase>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
  C Function(Object? json) fromJsonC,
) =>
        CursorPagination<T, C>(
          meta: fromJsonC(json['meta']),
          data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
        );

Map<String, dynamic>
    _$CursorPaginationToJson<T, C extends CursorPaginationMetaBase>(
  CursorPagination<T, C> instance,
  Object? Function(T value) toJsonT,
  Object? Function(C value) toJsonC,
) =>
        <String, dynamic>{
          'meta': toJsonC(instance.meta),
          'data': instance.data.map(toJsonT).toList(),
        };

CursorPaginationResponseMeta _$CursorPaginationResponseMetaFromJson(
        Map<String, dynamic> json) =>
    CursorPaginationResponseMeta(
      currentElements: json['current_elements'] as int,
      totalPages: json['total_pages'] as int,
      totalElements: (json['total_elements'] as num).toDouble(),
      count: json['count'] as int? ?? 0,
      size: json['size'] as int? ?? 20,
    );

Map<String, dynamic> _$CursorPaginationResponseMetaToJson(
        CursorPaginationResponseMeta instance) =>
    <String, dynamic>{
      'count': instance.count,
      'size': instance.size,
      'current_elements': instance.currentElements,
      'total_pages': instance.totalPages,
      'total_elements': instance.totalElements,
    };

CursorPaginationRequestMeta _$CursorPaginationRequestMetaFromJson(
        Map<String, dynamic> json) =>
    CursorPaginationRequestMeta(
      count: json['count'] as int? ?? 0,
      size: json['size'] as int? ?? 20,
    );

Map<String, dynamic> _$CursorPaginationRequestMetaToJson(
        CursorPaginationRequestMeta instance) =>
    <String, dynamic>{
      'count': instance.count,
      'size': instance.size,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParams _$PaginationParamsFromJson(Map<String, dynamic> json) =>
    PaginationParams(
      page: json['page'] as int,
      size: json['size'] as int? ?? 20,
      currentElements: json['current_elements'] as int?,
      totalElements: (json['total_elements'] as num?)?.toDouble(),
      totalPages: json['total_pages'] as int?,
    );

Map<String, dynamic> _$PaginationParamsToJson(PaginationParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'current_elements': instance.currentElements,
      'total_pages': instance.totalPages,
      'total_elements': instance.totalElements,
    };

import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(
  // 클래스가 Generic Type을 parameter로 받을 경우 해당 타입으로 직렬화함
  genericArgumentFactories: true,
)
// 외부에서 generic을 지정해주기 위해 <T>를 사용
class CursorPagination<T, C extends CursorPaginationMetaBase> {
  final C meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
  // 여기서 의미하는 THIS는 instance를 의미
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$CursorPaginationToJson(this, toJsonT);
}

@JsonSerializable()
class CursorPaginationResponseMeta extends CursorPaginationMetaBase {
  final int count;
  final int size;
  @JsonKey(name: 'current_elements')
  final int currentElements;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_elements')
  final double totalElements;

  CursorPaginationResponseMeta({
    required this.currentElements,
    required this.totalPages,
    required this.totalElements,
    this.count = 0,
    this.size = 20,
  });

  factory CursorPaginationResponseMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationResponseMetaFromJson(json);
  Map<String, dynamic> toJson() => _$CursorPaginationResponseMetaToJson(this);
}

@JsonSerializable()
class CursorPaginationRequestMeta extends CursorPaginationMetaBase {
  final int count;
  final int size;

  CursorPaginationRequestMeta({
    this.count = 0,
    this.size = 20,
  });

  factory CursorPaginationRequestMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationRequestMetaFromJson(json);
  Map<String, dynamic> toJson() => _$CursorPaginationRequestMetaToJson(this);
}

abstract class CursorPaginationMetaBase {}

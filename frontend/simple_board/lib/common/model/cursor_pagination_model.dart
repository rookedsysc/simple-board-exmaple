import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(
  // 클래스가 Generic Type을 parameter로 받을 경우 해당 타입으로 직렬화함
  genericArgumentFactories: true,
)
// 외부에서 generic을 지정해주기 위해 <T>를 사용
class CursorPagination<T> {
  final CursorPagination meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  factory CursorPagination.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$CursorPaginationFromJson(json, fromJsonT);
  // 여기서 의미하는 THIS는 instance를 의미
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$CursorPaginationToJson(this, toJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final int size;
  @JsonKey(name: 'current_elements')
  final int currentElements;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_elements')
  final double totalElements;

  CursorPaginationMeta(this.currentElements, this.totalPages, this.totalElements, {
    required this.count,
    required this.size,
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) => _$CursorPaginationMetaFromJson(json);
  Map<String, dynamic> toJson() => _$CursorPaginationMetaToJson(this);
}

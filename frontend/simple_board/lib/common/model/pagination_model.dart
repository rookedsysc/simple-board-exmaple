import 'package:json_annotation/json_annotation.dart';
import 'package:simple_board/common/interface/entity_base.dart';
import 'package:simple_board/common/model/pagination_params.dart';

part 'pagination_model.g.dart';

@JsonSerializable(
  // 클래스가 Generic Type을 parameter로 받을 경우 해당 타입으로 직렬화함
  genericArgumentFactories: true,
)
// 외부에서 generic을 지정해주기 위해 <E extends EntityBase>를 사용
class CursorPagination<E extends EntityBase> extends CursorPaginationBase {
  @JsonKey(name: 'pagination')
  final PaginationParams meta;
    @JsonKey(name: 'body')
  final List<E> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  copyWith({
    PaginationParams? meta,
    List<E>? data,
  }) {
    return CursorPagination(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, E Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object? Function(E value) toJsonT) =>
      _$CursorPaginationToJson(this, toJsonT);
}

// CursorPaginationRefetching is CursorPaginationBase // true
// 새로 고침할 때
class CursorPaginationRefetching<E extends EntityBase> extends CursorPagination<E> {
  CursorPaginationRefetching({
    required super.meta,
    required super.data,
  });
}

// 리스트의 맨 아래로 내려서 추가 데이터를 요청할 때
class CursorPaginationFetchingMore<E extends EntityBase> extends CursorPagination<E> {
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });

  @override
  copyWith({
    PaginationParams? meta,
    List<E>? data,
  }) {
    return CursorPaginationFetchingMore(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }
}

class CursorPaginationError extends CursorPaginationBase {
  final String message;
  CursorPaginationError({required this.message});

  
}

class CursorPaginationLoading extends CursorPaginationBase {}

abstract class CursorPaginationBase {}


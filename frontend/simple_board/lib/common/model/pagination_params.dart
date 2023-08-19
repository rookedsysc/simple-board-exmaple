import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  final int page; // 몇 번째 페이지를 보여줄지
  final int size; // 한 페이지에 보여줄 elements 수
  @JsonKey(name: "current_elements")
  final int? currentElements; // 현재 return된 elements 수
  @JsonKey(name: "total_pages")
  final int? totalPages; // 최대 페이지
  @JsonKey(name: "total_elements")
  final double? totalElements; // 전체 elements 수
  PaginationParams(
      {
        required this.page,
      this.size = 20,
      this.currentElements,
      this.totalElements,
      this.totalPages});

      factory PaginationParams.fromJson(Map<String, dynamic> json) => _$PaginationParamsFromJson(json);
      Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);


      copyWith({int? page, int? size, int? currentElements, int? totalPages, double? totalElements}) {
        return PaginationParams(
          page: page ?? this.page,
          size: size ?? this.size,
          currentElements: currentElements ?? this.currentElements,
          totalPages: totalPages ?? this.totalPages,
          totalElements: totalElements ?? this.totalElements,
        );
      }


}

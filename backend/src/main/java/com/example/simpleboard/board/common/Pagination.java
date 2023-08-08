package com.example.simpleboard.board.common;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class Pagination {
  private Integer page; // 몇 번째 페이지를 보여줄지
  private Integer size; // 한 페이지에 보여줄 elements 수
  private Integer currentElements; // 현재 return된 elements 수
  private Integer totalPages; // 최대 페이지
  private Long totalElements; // 전체 elements 수
}

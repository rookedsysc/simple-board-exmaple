package com.example.simpleboard.board.service;

import com.example.simpleboard.board.db.BoardEntity;
import com.example.simpleboard.board.db.BoardRepository;
import com.example.simpleboard.board.model.BoardDto;
import com.example.simpleboard.board.model.BoardRequest;
import com.example.simpleboard.common.Api;
import com.example.simpleboard.common.Pagination;
import com.example.simpleboard.crud.CRUDAbstractService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BoardService extends CRUDAbstractService<BoardDto, BoardEntity> {
  private final BoardRepository boardRepository;
  private final BoardConverter boardConverter;

  @Override
  public BoardDto create(BoardDto boardRequest) {
    BoardDto boardDto = BoardDto.builder()
        .boardName(boardRequest.getBoardName())
        .status("REGISTERED")
        .build();

    BoardEntity boardEntity = boardRepository.save(boardConverter.toEntity(boardDto));
    boardRepository.save(boardEntity);

    return boardDto;
  }

  @Override
  public Api<List<BoardDto>> list(Pageable pageable) {
    Page<BoardEntity> list = boardRepository.findAllRegisteredData(pageable);

    Pagination pagination = Pagination.builder()
        .page(list.getNumber())
        .size(list.getSize())
        .currentElements(list.getNumberOfElements())
        .totalElements(list.getTotalElements())
        .totalPages(list.getTotalPages())
        .build();
    List<BoardDto> dtoPage = list.stream()
        .map(entity -> boardConverter.toDto(entity))
        .collect(Collectors.toList());
    return Api.<List<BoardDto>>builder().
        pagination(pagination)
        .body(dtoPage)
        .build();
  }
}




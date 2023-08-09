package com.example.simpleboard.board.service;

import com.example.simpleboard.board.db.BoardEntity;
import com.example.simpleboard.board.db.BoardRepository;
import com.example.simpleboard.board.model.BoardDto;
import com.example.simpleboard.board.model.BoardRequest;
import com.example.simpleboard.crud.CRUDAbstractService;
import lombok.RequiredArgsConstructor;
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
    //private final BoardRepository boardRepository;
    //private final BoardConverter boardConverter;
    //
    //public BoardEntity create(
    //        BoardRequest boardRequest) {
    //    BoardEntity entity = BoardEntity.builder()
    //            .boardName(boardRequest.getBoardName())
    //            .status("REGISTERED")
    //            .build();
    //    return boardRepository.save(entity);
    //}
    //
    //public List<BoardDto> findAll() {
    //    List<BoardEntity> entityList= boardRepository.findAll();
    //    List<BoardDto> dtoList = entityList.stream().map(it -> boardConverter.toDto(it)).collect(Collectors.toList());
    //    return dtoList;
    //}
    //
    //public BoardDto view(Long id) {
    //    BoardEntity entity = boardRepository.findById(id)
    //        .get();
    //    BoardDto boardDto = boardConverter.toDto(entity);
    //
    //    return boardDto;
    //}
    //
    //public void delete(Long id) {
    //    boardRepository.deleteById(id);
    //}
}




package com.example.simpleboard.board.service;

import com.example.simpleboard.board.db.BoardEntity;
import com.example.simpleboard.board.db.BoardRepository;
import com.example.simpleboard.board.model.BoardDto;
import com.example.simpleboard.crud.Converter;
import com.example.simpleboard.post.db.PostEntity;
import com.example.simpleboard.post.db.PostRepository;
import com.example.simpleboard.post.model.PostDto;
import com.example.simpleboard.post.service.PostConverter;
import com.example.simpleboard.reply.db.ReplyEntity;
import com.example.simpleboard.reply.model.ReplyDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BoardConverter implements Converter<BoardDto, BoardEntity> {

  private final PostConverter postConverter;
  private final PostRepository postRepository;
  private final BoardRepository boardRepository;

  public BoardDto toDto(BoardEntity boardEntity) {
    List<PostDto> postList = boardEntity.getPostList()
        .stream()
        .map(postConverter::toDto)
        .collect(Collectors.toList());
    BoardDto boardDto = BoardDto.builder()
        .id(getBoardId(boardEntity))
        .boardName(boardEntity.getBoardName())
        .status(boardEntity.getStatus())
        .postList(postList)
        .build();
    return boardDto;
  }

  @Override
  public BoardEntity toEntity(BoardDto boardDto) {
    List<PostEntity> postList = List.of();
    try {
      postList = postRepository.findById(boardDto.getId())
          .stream()
          .collect(Collectors.toList());
    } catch (Exception ignored) {
    }
    BoardEntity boardEntity = BoardEntity.builder()
        .id(getBoardId(boardDto))
        .boardName(boardDto.getBoardName())
        .status(boardDto.getStatus())
        .postList(postList)
        .build();
    return boardEntity;
  }

  private Long getBoardId(BoardEntity boardEntity) {
    Long id = boardEntity.getId();
    if (id == null) {
      try {
        // 맨 마지막 ID 받아옴
        List<BoardEntity> boardEntityList = boardRepository.findAll()
            .stream()
            .sorted((a, b) -> b.getId()
                .compareTo(a.getId()))
            .collect(Collectors.toList());
        return boardEntityList.get(0)
            .getId();

      } catch (Exception e) {
        return 0L;
      }
    }

    return id;
  }

  private Long getBoardId(BoardDto boadDto) {
    Long id = boadDto.getId();
    if (id == null) {
      try {
        // 맨 마지막 ID 받아옴
        List<BoardEntity> boardEntityList = boardRepository.findAll()
            .stream()
            .sorted((a, b) -> b.getId()
                .compareTo(a.getId()))
            .collect(Collectors.toList());
        return boardEntityList.get(0)
            .getId();

      } catch (Exception e) {
        return 0L;
      }
    }

    return id;
  }
}

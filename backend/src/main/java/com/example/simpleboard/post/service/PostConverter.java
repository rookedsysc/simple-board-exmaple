package com.example.simpleboard.post.service;

import com.example.simpleboard.board.db.BoardEntity;
import com.example.simpleboard.board.db.BoardRepository;
import com.example.simpleboard.board.model.BoardDto;
import com.example.simpleboard.crud.Converter;
import com.example.simpleboard.post.db.PostEntity;
import com.example.simpleboard.post.model.PostDto;
import com.example.simpleboard.reply.db.ReplyEntity;
import com.example.simpleboard.reply.db.ReplyRepository;
import com.example.simpleboard.reply.service.ReplyService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;


@Service
@RequiredArgsConstructor
public class PostConverter implements Converter<PostDto, PostEntity> {
  private final ReplyRepository replyRepository;
  private final BoardRepository boardRepository;
  public PostDto toDto(PostEntity postEntity) {
    List<ReplyEntity> replyList = replyRepository.findAllByPostIdAndStatusOrderByIdDesc(postEntity.getId(), "REGISTERED");

    PostDto postDto = PostDto.builder()
        .boardId(postEntity.getBoard()
            .getId())
        .userName(postEntity.getUserName())
        .email(postEntity.getEmail())
        .password(postEntity.getPassword())
        .title(postEntity.getTitle())
        .content(postEntity.getContent())
        .replyList(replyList).replyCount(replyList.size())
        .build();

    return postDto;
  }

  @Override
  public PostEntity toEntity(PostDto postDto) {
    BoardEntity board = boardRepository.findById(postDto.getBoardId())
        .orElseThrow(() -> new IllegalArgumentException("해당 게시판이 존재하지 않습니다."));
    PostEntity postEntity = PostEntity.builder()
        .board(board)
        .userName(postDto.getUserName())
        .password(postDto.getPassword())
        .email(postDto.getEmail())
        .status("REGISTERED")
        .title(postDto.getTitle())
        .content(postDto.getContent())
        .postedAt(LocalDateTime.now())
        .build();

    return postEntity;
  }

}

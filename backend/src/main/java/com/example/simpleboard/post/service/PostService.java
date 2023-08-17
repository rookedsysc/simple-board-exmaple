package com.example.simpleboard.post.service;

import com.example.simpleboard.board.db.BoardEntity;
import com.example.simpleboard.board.model.BoardDto;
import com.example.simpleboard.common.Api;
import com.example.simpleboard.common.Pagination;
import com.example.simpleboard.board.db.BoardRepository;
import com.example.simpleboard.crud.CRUDAbstractService;
import com.example.simpleboard.post.db.PostEntity;
import com.example.simpleboard.post.db.PostRepository;
import com.example.simpleboard.post.model.PostDto;
import com.example.simpleboard.post.model.PostViewRequest;
import com.example.simpleboard.reply.db.ReplyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PostService extends CRUDAbstractService<PostDto, PostEntity> {
  private final PostRepository postRepository;
  private final PostConverter postConverter;

  public Api<List<PostDto>> findByBoardId(Long boardId, Pageable pageable) {
    Api<List<PostEntity>> postApi = postRepository.findByBoard_Id(boardId, pageable);
    List<PostDto> postDto =     postApi.getBody().stream().map(it -> {
      return postConverter.toDto(it);
    }).collect(Collectors.toList());

    Api<List<PostDto>> postDtoApi = Api.<List<PostDto>>builder()
        .body(postDto).pagination(postApi.getPagination())
        .build();
    return postDtoApi;
  }

}

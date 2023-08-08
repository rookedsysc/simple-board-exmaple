package com.example.simpleboard.post.service;

import com.example.simpleboard.board.common.Api;
import com.example.simpleboard.board.common.Pagination;
import com.example.simpleboard.board.db.BoardRepository;
import com.example.simpleboard.post.db.PostEntity;
import com.example.simpleboard.post.db.PostRepository;
import com.example.simpleboard.post.model.PostDto;
import com.example.simpleboard.post.model.PostRequest;
import com.example.simpleboard.post.model.PostViewRequest;
import com.example.simpleboard.reply.db.ReplyEntity;
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
public class PostService {
  private final PostRepository postRepository;
  private final ReplyRepository replyService;
  private final BoardRepository boardRepository;
  private final PostConverter postConverter;

  public PostDto create(PostRequest postRequest) {
    var boardEntity = boardRepository.findById(postRequest.getBoardId())
        .get();

    PostEntity entity = PostEntity.builder()
        .board(boardEntity)
        .userName(postRequest.getUserName())
        .password(postRequest.getPassword())
        .email(postRequest.getEmail())
        .status("REGISTERED")
        .title(postRequest.getTitle())
        .content(postRequest.getContent())
        .postedAt(LocalDateTime.now())
        .build();

    PostDto dto = postConverter.toDto(postRepository.save(entity));
    return dto;
  }

  /**
   * 1. 게시글이 있는가?
   * 2. 비밀번호가 맞는가?
   */
  public PostDto view(PostViewRequest postViewRequest) {
    PostEntity entity = postRepository.findFirstByIdAndStatusOrderByIdDesc(postViewRequest.getPostId(), "REGISTERED")
        .map(
            it -> {
              if (!it.getPassword()
                  .equals(postViewRequest.getPassword())) {
                var format = "패스워드가 맞지 않습니다. %s vs %s";
                throw new RuntimeException(String.format(format, it.getPassword(), postViewRequest.getPassword()));
              }

              // 게시글을 불러올 때 Reply도 같이 불러온다.
              //List<ReplyEntity> replyList = replyService.findAllByPostIdAndStatusOrderByIdDesc(it.getId(), "REGISTERED");
              //it.setReplyList(replyList);
              return it;
            }
        )
        .orElseThrow(() -> {
          return new RuntimeException("해당 게시글이 존재하지 않습니다. : " + postViewRequest.getPostId());
        });

    return postConverter.toDto(entity);
  }

  public Api<List<PostEntity>> all(Pageable pageable) {
    Page<PostEntity> list = postRepository.findAll(pageable);
    Pagination pagination = Pagination.builder()
        .page(list.getNumber())
        .size(list.getSize())
        .currentElements(list.getNumberOfElements())
        .totalElements(list.getTotalElements())
        .totalPages(list.getTotalPages())
        .build();
    Api<List<PostEntity>> response = Api.<List<PostEntity>> builder().pagination(pagination).body(list.toList()).build();
    return response;
  }

  public void delete(PostViewRequest postViewRequest) {
    postRepository.findById(postViewRequest.getPostId())
        .map(
            it -> {
              if (!it.getPassword()
                  .equals(postViewRequest.getPassword())) {
                var format = "패스워드가 맞지 않습니다. %s vs %s";
                throw new RuntimeException(String.format(format, it.getPassword(), postViewRequest.getPassword()));
              }
              it.setStatus("UNREGISTERED");
              postRepository.save(it);
              return it;
            }
        )
        .orElseThrow(() -> {
          return new RuntimeException("해당 게시글이 존재하지 않습니다. : " + postViewRequest.getPostId());
        });

  }
}

package com.example.simpleboard.post.service;

import com.example.simpleboard.common.Api;
import com.example.simpleboard.common.Pagination;
import com.example.simpleboard.crud.CRUDAbstractService;
import com.example.simpleboard.post.db.PostEntity;
import com.example.simpleboard.post.db.PostRepository;
import com.example.simpleboard.post.model.PostDto;
import com.example.simpleboard.post.model.PostViewRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PostService extends CRUDAbstractService<PostDto, PostEntity> {
  private final PostRepository postRepository;
  private final PostConverter postConverter;

  public Api<List<PostDto>> findByBoardId(Long boardId, Pageable pageable) {
   Page<PostEntity> postPage = postRepository.findByBoard_Id(boardId, pageable);
       Pagination pagination = Pagination.builder()
        .page(postPage.getNumber())
        .size(postPage.getSize())
        .currentElements(postPage.getNumberOfElements())
        .totalElements(postPage.getTotalElements())
        .totalPages(postPage.getTotalPages())
        .build();

    List<PostDto> postDtoList = postPage.stream().map(entity -> {
      return postConverter.toDto(entity);
    }).collect(Collectors.toList());

    return Api.<List<PostDto>>builder().body(postDtoList).pagination(pagination).build();
  }

  public boolean checkPassword(PostViewRequest request) {
    String dbPassword = postRepository.findById(request.getPostId()).get().getPassword();

    if(!Objects.equals(dbPassword, request.getPassword()) || dbPassword == null) {
      return false;
    }

    return true;
  }
}

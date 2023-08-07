package com.example.simpleboard.post.service;

import com.example.simpleboard.post.db.PostEntity;
import com.example.simpleboard.post.model.PostDto;
import org.springframework.stereotype.Service;

@Service
public class PostConverter {
  public PostDto toDto(PostEntity postEntity) {
    PostDto postDto = PostDto.builder()
        .postedAt(postEntity.getPostedAt())
        .boardId(postEntity.getBoard()
            .getId())
        .id(postEntity.getId())
        .userName(postEntity.getUserName())
        .status(postEntity.getStatus())
        .email(postEntity.getEmail())
        .password(postEntity.getPassword())
        .title(postEntity.getTitle())
        .content(postEntity.getContent())
        .build();
    return postDto;
  }
}

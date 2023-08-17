package com.example.simpleboard.post.controller;

import com.example.simpleboard.board.db.BoardEntity;
import com.example.simpleboard.board.model.BoardDto;
import com.example.simpleboard.common.Api;
import com.example.simpleboard.crud.CRUDAbstractApiController;
import com.example.simpleboard.post.db.PostEntity;
import com.example.simpleboard.post.model.PostDto;
import com.example.simpleboard.post.model.PostViewRequest;
import com.example.simpleboard.post.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RequestMapping("/api/post")
@RestController
@RequiredArgsConstructor
public class PostApiController extends CRUDAbstractApiController<PostDto, PostEntity> {

  final private PostService postService;
  @GetMapping("/board/{boardId}")
  public Api<List<PostDto>> findByBoardId(@PathVariable Long boardId, @PageableDefault Pageable pageable) {
    return postService.findByBoardId(boardId, pageable);
  }
}


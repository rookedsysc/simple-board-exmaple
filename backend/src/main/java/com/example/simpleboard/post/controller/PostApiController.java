package com.example.simpleboard.post.controller;

import com.example.simpleboard.common.Api;
import com.example.simpleboard.post.db.PostEntity;
import com.example.simpleboard.post.model.PostDto;
import com.example.simpleboard.post.model.PostViewRequest;
import com.example.simpleboard.post.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RequestMapping("/api/post")
@RestController
@RequiredArgsConstructor
public class PostApiController {
    private final PostService postService;

    @PostMapping("")
    public PostDto create(@Valid @RequestBody PostDto postRequest) {
        return postService.create(postRequest);
    }

    @PostMapping("/view")
    public PostDto view(
            @Valid
            @RequestBody PostViewRequest postViewRequest
    ) {
        var entity = postService.view(postViewRequest);
        //entity.getReplyList().forEach(it -> {
        //    // reply에 대한 처리가 가능하다.
        //});
        return entity;
    }

    @GetMapping("all")
    public Api<List<PostEntity>> list(
        // direction = Sort.Direction.DESC : 역순(최신순) 기본은 ASC임
        @PageableDefault(page = 0, size = 10, sort = "id", direction = Sort.Direction.DESC)
        Pageable pageable
    ) {
        return postService.all(pageable);
    }

    @PostMapping("/delete")
    public void delete(
            @Valid
            @RequestBody PostViewRequest postViewRequest
    ) {
        postService.delete(postViewRequest);
    }
}

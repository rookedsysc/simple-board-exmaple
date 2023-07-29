package com.example.simpleboard.post.service;

import com.example.simpleboard.post.db.PostEntity;
import com.example.simpleboard.post.db.PostRepository;
import com.example.simpleboard.post.model.PostRequest;
import com.example.simpleboard.post.model.PostViewRequest;
import com.example.simpleboard.reply.db.ReplyEntity;
import com.example.simpleboard.reply.db.ReplyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.validation.Valid;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PostService {
    private final PostRepository postRepository;
    private final ReplyRepository replyService;
    public PostEntity create(PostRequest postRequest) {
        PostEntity entity = PostEntity.builder()
                .boardId(1L)
                .userName(postRequest.getUserName())
                .password(postRequest.getPassword())
                .email(postRequest.getEmail())
                .status("REGISTERED")
                .title(postRequest.getTitle())
                .content(postRequest.getContent())
                .postedAt(LocalDateTime.now())
                .build();
        return postRepository.save(entity);
    }

    /**
     * 1. 게시글이 있는가?
     * 2. 비밀번호가 맞는가?
     */
    public PostEntity view(PostViewRequest postViewRequest) {
        return postRepository.findFirstByIdAndStatusOrderByIdDesc(postViewRequest.getPostId(), "REGISTERED")
                .map(
                        it -> {
                            if (!it.getPassword()
                                    .equals(postViewRequest.getPassword())) {
                                var format = "패스워드가 맞지 않습니다. %s vs %s";
                                throw new RuntimeException(String.format(format, it.getPassword(), postViewRequest.getPassword()));
                            }

                            // 게시글을 불러올 때 Reply도 같이 불러온다.
                            List<ReplyEntity> replyList = replyService.findAllByPostIdAndStatusOrderByIdDesc(it.getId(), "REGISTERED");
                            it.setReplyList(replyList);
                            return it;
                        }
                )
                .orElseThrow(() -> {
                    return new RuntimeException("해당 게시글이 존재하지 않습니다. : " + postViewRequest.getPostId());
                });
    }

    public List<PostEntity> all() {
        List<PostEntity> allPost = postRepository.findAll();
        allPost
                .stream()
                .map(it -> {
                    List<ReplyEntity> replyList = replyService.findAllByPostIdAndStatusOrderByIdDesc(it.getId(), "REGISTERED");
                    it.setReplyCount(replyList.size());
                    return it;
                }).collect(Collectors.toList());
        return allPost;
    }

    public void delete(PostViewRequest postViewRequest) {
        postRepository.findById(postViewRequest.getPostId()).map(
                it -> {
                    if(!it.getPassword().equals(postViewRequest.getPassword())) {
                        var format = "패스워드가 맞지 않습니다. %s vs %s";
                        throw new RuntimeException(String.format(format, it.getPassword(), postViewRequest.getPassword()));
                    }
                    it.setStatus("UNREGISTERED");
                    postRepository.save(it);
                    return it;
                }
        ).orElseThrow(() -> {
            return new RuntimeException("해당 게시글이 존재하지 않습니다. : " + postViewRequest.getPostId());
        });

    }
}

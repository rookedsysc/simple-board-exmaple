package com.example.simpleboard.reply.service;

import com.example.simpleboard.crud.CRUDAbstractService;
import com.example.simpleboard.post.db.PostEntity;
import com.example.simpleboard.post.db.PostRepository;
import com.example.simpleboard.reply.db.ReplyEntity;
import com.example.simpleboard.reply.db.ReplyRepository;
import com.example.simpleboard.reply.model.ReplyDto;
import com.example.simpleboard.reply.model.ReplyRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ReplyService extends CRUDAbstractService<ReplyDto,ReplyEntity> {
    //private final ReplyRepository replyRepository;
    //private final PostRepository postRepository;
    //
    //public ReplyEntity create(
    //        ReplyRequest replyRequest
    //) {
    //    Optional<PostEntity> postEntity = postRepository.findById(replyRequest.getPostId());
    //
    //    if(postEntity.isEmpty()) {
    //        throw new RuntimeException("게시글이 존재하지 않습니다.");
    //    }
    //
    //    ReplyEntity entity = ReplyEntity.builder()
    //            .post(postEntity.get())
    //            .userName(replyRequest.getUserName())
    //            .password(replyRequest.getPassword())
    //            .status("REGISTERED")
    //            .title(replyRequest.getTitle())
    //            .content(replyRequest.getContent())
    //            .repliedAt(LocalDateTime.now())
    //            .build();
    //    replyRepository.save(entity);
    //    return entity;
    //}
    //
    //public List<ReplyEntity> findAllByPostId(Long postId) {
    //    return replyRepository.findAllByPostIdAndStatusOrderByIdDesc(postId, "REGISTERED");
    //}
}

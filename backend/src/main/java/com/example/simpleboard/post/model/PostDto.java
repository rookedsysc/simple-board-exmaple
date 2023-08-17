package com.example.simpleboard.post.model;


import com.example.simpleboard.reply.db.ReplyEntity;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import javax.persistence.OneToMany;
import javax.persistence.Transient;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class PostDto {
    private Long id;
    private Long boardId = 1L;
    @NotBlank
    private String userName;
    @NotBlank
    @Size(max = 4, min = 4)
    private String password;
    @NotBlank
    private String email;
    @NotBlank
    private String title;
    @NotBlank
    private String content;
    @OneToMany(mappedBy = "post")
    private List<ReplyEntity> replyList = List.of();
    @Transient
    private Integer replyCount;
    private LocalDateTime postedAt;
}

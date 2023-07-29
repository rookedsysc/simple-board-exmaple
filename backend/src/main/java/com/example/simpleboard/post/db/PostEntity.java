package com.example.simpleboard.post.db;

import com.example.simpleboard.reply.db.ReplyEntity;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import javax.persistence.*;

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
@Entity(name = "post") // 테이블 이름
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class PostEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long boardId;
    private String userName;
    private String password;
    private String email;
    private String status;
    private String title;
    // Database의 sql 유형이 TEXT인 경우
    // 아래의 Annotation을 통해서 데이터 타입을 맞춰줄 수 있음
    @Column(columnDefinition = "TEXT")
    private String content;
    private LocalDateTime postedAt;
    // Entity Annotation이 붙어있으면 기본적으로 이곳에 선언된 변수들은 DB의 Column으로 인식한다.
    // Transient Annotation을 붙여주면 DB의 Column으로 인식하지 않는다.(Container 등록시에 무시함)
    @Transient
    private List<ReplyEntity> replyList = List.of();
    @Transient
    private Integer replyCount;
}

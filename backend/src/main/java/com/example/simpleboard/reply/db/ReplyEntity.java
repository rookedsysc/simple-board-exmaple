package com.example.simpleboard.reply.db;

import com.example.simpleboard.common.EntityBase;
import com.example.simpleboard.post.db.PostEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import javax.persistence.*;

import lombok.*;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity(name = "reply") // 테이블 이름
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class ReplyEntity implements EntityBase {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JsonIgnore
    @ToString.Exclude
    private PostEntity post;
    private String userName;
    private String password;
    private String status;
    private String title;
    // Database의 sql 유형이 TEXT인 경우
    // 아래의 Annotation을 통해서 데이터 타입을 맞춰줄 수 있음
    @Column(columnDefinition = "TEXT")
    private String content;
    private LocalDateTime repliedAt;
}

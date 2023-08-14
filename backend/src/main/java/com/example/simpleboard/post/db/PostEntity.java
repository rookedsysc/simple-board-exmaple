package com.example.simpleboard.post.db;

import com.example.simpleboard.common.EntityBase;
import com.example.simpleboard.board.db.BoardEntity;
import com.example.simpleboard.reply.db.ReplyEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import javax.persistence.*;

import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity(name = "post") // 테이블 이름
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class PostEntity implements EntityBase {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    // 이 Annotation을 붙여주면 해당 변수를 Column으로 인식을 한다.
    // 자동으로 뒤에다가 _id를 붙여주게 된다.
    @ManyToOne
    // Object Mapper가 BoardEntity에서 참조를 하고 BoardEntity에서 또 이곳을 참조하고 ... 하는 식으로
    // 상호 참조가 반복되어서 무한 루프가 돌게되는데 이를 방지하기 위해서 @JsonIgnore를 붙여준다.
    @JsonIgnore
    // toString끼리 상호참조로 인한 무한 루프를 방지하기 위해서 사용한다.
    @ToString.Exclude
    private BoardEntity board;
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
}

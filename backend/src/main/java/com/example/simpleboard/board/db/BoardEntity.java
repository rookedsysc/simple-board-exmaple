package com.example.simpleboard.board.db;

import com.example.simpleboard.post.db.PostEntity;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity(name = "board") // 테이블 이름
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class BoardEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String boardName;
    private String status;

    @OneToMany(
        // Mapping 해줄 변수의 이름
        // 해당 변수를 기준으로 1:N의 관계를 맺는다.
        // 여기서는 board_id와 1:N의 관계를 맺게 되는 것이다.
        mappedBy = "board"
    )
    private List<PostEntity> postList = List.of();
}

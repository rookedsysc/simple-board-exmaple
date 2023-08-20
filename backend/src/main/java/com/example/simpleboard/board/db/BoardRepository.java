package com.example.simpleboard.board.db;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface BoardRepository extends JpaRepository<BoardEntity, Long> {
  @Query(
      // form user u : user는 Entity를 뜻하고 u는 user의 별칭
      // u.score : user entity 안에 있는 score 필드(변수)
      // ?1, ?2 : 들어오는 첫 번째 인자, 두 번째 인자
      // named parameter 매칭 방식 : @Param으로 등록해준 이름으로 :[이름]을 사용해서 매칭한다.
      value = "SELECT * FROM board WHERE Status = 'REGISTERED'",
      nativeQuery = true
  )
  public Page<BoardEntity> findAllRegisteredData(Pageable pageable);
}

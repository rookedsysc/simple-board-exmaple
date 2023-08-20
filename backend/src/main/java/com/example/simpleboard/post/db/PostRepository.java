package com.example.simpleboard.post.db;


import com.example.simpleboard.common.Api;
import com.example.simpleboard.common.Pagination;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface PostRepository extends JpaRepository<PostEntity, Long> {

  // select * from post where id = ? and status = ? order by id desc limit 1
  public Optional<PostEntity> findFirstByIdAndStatusOrderByIdDesc(Long id, String status);

  @Query(
      // form user u : user는 Entity를 뜻하고 u는 user의 별칭
      // u.score : user entity 안에 있는 score 필드(변수)
      // ?1, ?2 : 들어오는 첫 번째 인자, 두 번째 인자
      // named parameter 매칭 방식 : @Param으로 등록해준 이름으로 :[이름]을 사용해서 매칭한다.
      value = "select * from post where board_id = :boardId and status = 'REGISTERED'",
      nativeQuery = true
  )
  Page<PostEntity> findByBoard_Id(Long boardId, Pageable pageable);
}

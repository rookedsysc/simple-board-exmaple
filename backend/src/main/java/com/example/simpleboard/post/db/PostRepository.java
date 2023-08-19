package com.example.simpleboard.post.db;


import com.example.simpleboard.common.Api;
import com.example.simpleboard.common.Pagination;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PostRepository extends JpaRepository<PostEntity,Long> {

    // select * from post where id = ? and status = ? order by id desc limit 1
    public Optional<PostEntity> findFirstByIdAndStatusOrderByIdDesc(Long id, String status);
    Api<List<PostEntity>> findByBoard_Id(Long boardId, Pageable pageable);
}

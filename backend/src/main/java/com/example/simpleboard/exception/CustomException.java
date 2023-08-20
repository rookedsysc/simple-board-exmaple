package com.example.simpleboard.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.data.crossstore.ChangeSetPersister;

import java.io.NotActiveException;

@AllArgsConstructor
@Getter
public class CustomException extends RuntimeException{
  public IllegalArgumentException notFoundBoardId() {
    return new IllegalArgumentException("존재하지 않는 게시판 입니다.");
  }
}

package com.example.simpleboard.exception;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class CustomExceptionHandler {
  @ExceptionHandler(value = {IllegalArgumentException.class})
  protected ResponseEntity handleCustomException(CustomException e) {
    return ResponseEntity.notFound().build();
  }
}

package com.example.simpleboard.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
@Slf4j
public class ConverterException {
  @ExceptionHandler(value = {IllegalArgumentException.class})
  public ResponseEntity handleException(IllegalArgumentException e) {
    log.error("IllegalArgumentException: {}", e.getMessage());
    return ResponseEntity.badRequest()
        .body(e.getMessage());
  }
}

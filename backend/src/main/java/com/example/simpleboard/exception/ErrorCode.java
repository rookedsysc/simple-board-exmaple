package com.example.simpleboard.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@AllArgsConstructor
@Getter
public enum ErrorCode {
    /* 400 BAD_REQUEST : 잘못된 요청 */
    /* 401 UNAUTHORIZED : 인증되지 않은 사용자 */
    INVALID_BOARDID(HttpStatus.NOT_FOUND, "존재하지 않는 게시판 입니다.");

    private final HttpStatus httpStatus;
    private final String message;
}

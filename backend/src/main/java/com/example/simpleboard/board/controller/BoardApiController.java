package com.example.simpleboard.board.controller;

import com.example.simpleboard.board.model.BoardDto;
import com.example.simpleboard.board.model.BoardRequest;
import com.example.simpleboard.board.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/board")
@RequiredArgsConstructor
public class BoardApiController {

    private final BoardService boardService;

    @PostMapping("")
    public void create(
            @Valid
            @RequestBody
            BoardRequest boardRequest
    ) {
        boardService.create(boardRequest);
    }

    @GetMapping("/all")
    public List<BoardDto> findAll() {
        return boardService.findAll();
    }

    @GetMapping("/id/{id}")
    public BoardDto findById(
            @PathVariable Long id
    ) {
        var entity = boardService.view(id);
        // toString을 넣은 후 log로 찍게 되면 toString이 두 Entity 사이에서 계속 상호참조되어서 무한 루프에 빠지게 된다.
        log.info("result : " + entity);
        return entity;
    }
}

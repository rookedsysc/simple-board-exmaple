package com.example.simpleboard.crud;

import com.example.simpleboard.board.common.Api;
import com.example.simpleboard.board.common.EntityBase;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Optional;

public abstract class CRUDAbstractApiController<DTO, ENTITY extends EntityBase> implements CRUDInterface<DTO> {
  @Autowired(required = false)
  private CRUDAbstractService<DTO, ENTITY> service;

  @Override
  @PostMapping("")
  public DTO create(
      @Valid
      @RequestBody
      DTO dto
  ) {
    return service.create(dto);
  }

  @Override
  @GetMapping("/id/{id}")
  public Optional<DTO> read(
      @PathVariable
      Long id
  ) {
    return service.read(id);
  }

  @Override
  @PutMapping("")
  public DTO update(
      @Valid
      @RequestBody
      DTO dto
  ) {
    return service.update(dto);
  }

  @Override
  @DeleteMapping("/delete/{id}")
  public void delete(
      @PathVariable
      Long id
  ) {
    service.delete(id);
  }

  @Override
  @GetMapping("/all")
  public Api<List<DTO>> list(
      @PageableDefault
      Pageable pageable
  ) {
    return service.list(pageable);
  }
}

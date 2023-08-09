package com.example.simpleboard.crud;

import com.example.simpleboard.board.common.Api;
import com.example.simpleboard.board.common.EntityBase;
import com.example.simpleboard.board.common.Pagination;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * dto -> entity -> dto
 */
public abstract class CRUDAbstractService<DTO, ENTITY extends EntityBase> implements CRUDInterface<DTO> {
  // Autowired(required = false) :
  // 해당 Converter를 상속받은 Bean이 있다면 여기를 채워주고 없다면 넘어가게 된다.
  @Autowired(required = false)
  private JpaRepository<ENTITY, Long> repository;
  @Autowired(required = false)
  private Converter<DTO,ENTITY> converter;
  @Override
  public DTO create(DTO dto) {
    // dto -> entity
    var entity = converter.toEntity(dto);

    // entity -> save
    repository.save(entity);

    // save -> dto
    return converter.toDto(entity);
  }

  @Override
  public Optional<DTO> read(Long id) {
    var optionalEntity = repository.findById(id);
    var dto = optionalEntity.map(entity -> converter.toDto(entity)).orElseGet(() -> null);

    return Optional.ofNullable(dto);
  }

  @Override
  public DTO update(DTO dto) {
    var entity = converter.toEntity(dto);
    repository.save(entity);
    var result = converter.toDto(entity);
    return result;
  }

  @Override
  public void delete(Long id) {
    ENTITY entity = repository.findById(id).orElseGet(() -> null);
    if (entity != null) {
      entity.setStatus("UNREGISTERED");
      repository.save(entity);
    }
  }

  @Override
  public Api<List<DTO>> list(Pageable pageable) {
    Page<ENTITY> list = repository.findAll(pageable);

    Pagination pagination = Pagination.builder()
        .page(list.getNumber())
        .size(list.getSize())
        .currentElements(list.getNumberOfElements())
        .totalElements(list.getTotalElements())
        .totalPages(list.getTotalPages())
        .build();
    List<DTO> dtoPage = list.stream()
        .map(entity -> converter.toDto(entity))
        .collect(Collectors.toList());
    return Api.<List<DTO>>builder().
        pagination(pagination)
        .body(dtoPage)
        .build();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_board/common/model/pagination_model.dart';
import 'package:simple_board/controller/repository/board_repository.dart';
import 'package:simple_board/controller/service/pagination.dart';
import 'package:simple_board/model/board_entity.dart';
import 'package:simple_board/model/board_request_dto.dart';

final boardService = StateNotifierProvider.autoDispose<
    Pagination<BoardEntity, BoardRepository>, CursorPaginationBase>(
  (ref) {
    return BoardService(boardRepository: ref.read(boardRepositoryProvider));
  },
);

class BoardService extends Pagination<BoardEntity, BoardRepository>{
  final BoardRepository _boardRepository;
  BoardService({required BoardRepository boardRepository})
      : _boardRepository = boardRepository, super(repository: boardRepository);

  Future<void> create(BoardConfigModel boardCreateModel) async {
    await _boardRepository.create(boardCreateModel);
  }

  Future<void> delete(int id) async {
    return await _boardRepository.delete(id);
  }

  Future<BoardEntity> get(int id) async {
    return await _boardRepository.get(id);
  }
}

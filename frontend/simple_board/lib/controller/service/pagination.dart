import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_board/common/interface/entity_base.dart';
import 'package:simple_board/common/interface/pagination_provider_base.dart';
import 'package:simple_board/common/interface/repository_base.dart';
import 'package:simple_board/common/model/pagination_model.dart';
import 'package:simple_board/common/model/pagination_params.dart';
import 'package:simple_board/controller/repository/post_repository.dart';

abstract class Pagination<E extends EntityBase,
        R extends RepositoryBase<E, CursorPagination<E>>>
    extends StateNotifier<CursorPaginationBase> {

  final RepositoryBase<E, CursorPagination<E>> _repository;
  final int? boardId;
  final Throttle paginationThrottle = Throttle(
    const Duration(seconds: 1),
    initialValue:
        PaginationInfo(size: 20, fetchMore: false, forceRefetch: false),
  );

  Pagination({this.boardId,required RepositoryBase<E, CursorPagination<E>> repository})
      : _repository = repository,
        super(CursorPaginationLoading()) {
    paginate();
    paginationThrottle.values.listen((value) {
      _throttlePaginate(value);
    });
  }

  Future<void> paginate({
    bool fetchMore = false,
    bool forceRefetch = false,
    int size = 20,
  }) async {
    paginationThrottle.setValue(PaginationInfo(
      fetchMore: fetchMore,
      forceRefetch: forceRefetch,
      size: size,
    ));
  } // paginate

  Future<void> _throttlePaginate(PaginationInfo info) async {
    try {
      if (state is CursorPagination && !info.forceRefetch) {
        final pState = state as CursorPagination<E>;

        if (!_hasMore()) {
          return;
        }
      }

      // 데이터가 로딩 중인 상태
      if (info.fetchMore && (_isLoading())) {
        return;
      }

      // Pagination Params 생성
      PaginationParams paginationParams = PaginationParams(page: 0);

      if (info.fetchMore) {
        paginationParams = _fetchMore(paginationParams);
      } else {
        _fetchFirst(info.forceRefetch);
      }

      late final resp;

      if (boardId != null && _repository is PostRepository) {
        final postRepository = _repository as PostRepository;
        try {
          resp = await postRepository.getPostListByBoardId(
              boardId!, paginationParams);
        } on DioException catch (e) {
          throw Exception("Pagination Error ${e.response?.data}");
        } catch (e) {
          throw Exception("Pagination Error ${e.toString}");
        }
      } else {
        try {
          resp = await _repository.paginate(paginationParams);
        } on DioException catch (e) {
          throw Exception("Pagination Error ${e.message}");
        } catch (e) {
          throw Exception("Pagination Error ${e.toString}");
        }
      }

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<E>;
        state = resp.copyWith(
          data: pState.data + resp.data,
        );
      } else {
        state = resp;
      }
    } catch (e, stack) {
      debugPrint(stack.toString());
      state = CursorPaginationError(
          message: e.toString());
    }
  } // _throttlePaginate

  bool _hasMore() {
    if (state is CursorPagination) {
      final pState = state as CursorPagination<E>;
      return pState.meta.page != pState.meta.totalPages;
    }
    return false;
  }

  bool _isLoading() {
    return state is CursorPaginationLoading ||
        state is CursorPaginationRefetching ||
        state is CursorPaginationFetchingMore;
  }

  PaginationParams _fetchMore(PaginationParams paginationParams) {
    // fetchMore를 실행할 수 있는 상황은 이미 데이터를 불러온 상황이므로 CursorPagination이 들고 있는 상태
    // IModelWithId를 상속받은 데이터 타입을 들고 있는 상태
    final pState = state as CursorPagination<E>;

    // 현재 상태를 인자 값을 그대로 유지한 채로
    // CursorPaginationFetchMore로 변경
    state = CursorPaginationFetchingMore(data: pState.data, meta: pState.meta);
    paginationParams = paginationParams.copyWith(
      // after 값에 현재 데이터(상태)의 마지막 데이터의 id를 넣어줌
      page: pState.meta.page + 1,
    );
    return paginationParams;
  }

  void _fetchFirst(bool forceRefetch) {
    // 만약에 데이터가 있는 상황이라면
    // 기존 데이터를 보존한채로  Fetch(API 요청)를 진행
    if (state is CursorPagination && !forceRefetch) {
      final pState = state as CursorPagination<E>;
      // 데이터는 있는데 새로고침을 하고 있음
      state =
          CursorPaginationRefetching<E>(meta: pState.meta, data: pState.data);
    } else {
      state = CursorPaginationLoading();
    }
  }
}

class PaginationInfo {
  final int size;
  final bool fetchMore;
  final bool forceRefetch;
  PaginationInfo(
      {this.size = 20, this.fetchMore = false, this.forceRefetch = false});
}

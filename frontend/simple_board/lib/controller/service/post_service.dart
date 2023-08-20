import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_board/common/model/pagination_model.dart';
import 'package:simple_board/controller/repository/post_repository.dart';
import 'package:simple_board/controller/service/pagination.dart';
import 'package:simple_board/model/post_entity.dart';

final boardIdProvider = StateProvider<int>((ref) => 0);

final postService = StateNotifierProvider.autoDispose<
    Pagination<PostEntity, PostRepository>, CursorPaginationBase>((ref) {
  final PostRepository repository = ref.read(postRepositoryProvider);
  final int boardId = ref.watch(boardIdProvider.notifier).state;

  return PostService(postRepository: repository, boardId: boardId);
});

class PostService extends Pagination<PostEntity, PostRepository> {
  PostService({int? boardId, required PostRepository postRepository})
      : super(boardId: boardId, repository: postRepository);
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_board/common/model/pagination_model.dart';
import 'package:simple_board/controller/repository/post_repository.dart';
import 'package:simple_board/controller/service/pagination.dart';
import 'package:simple_board/model/post_entity.dart';
import 'package:simple_board/model/post_request_dto.dart';


final postService = StateNotifierProvider<Pagination<PostEntity,PostRepository>, CursorPaginationBase>((ref) {
  final PostRepository repository = ref.read(postRepositoryProvider);

  return PostService(postRepository: ref.read(postRepositoryProvider));
});

class PostService extends Pagination<PostEntity, PostRepository>{
  final PostRepository _postRepository;
  PostService({required PostRepository postRepository})
      : _postRepository = postRepository, super(repository: postRepository);

  Future<void> create(PostCreateDTO postCreateModel) async {
    await _postRepository.create(postCreateModel);
  }

  Future<void> delete(PostDeleteDTO 
  request) async {
    return await _postRepository.delete(request);
  }

  Future<PostEntity> get(double id) async {
    return await _postRepository.get(id);
  }
}

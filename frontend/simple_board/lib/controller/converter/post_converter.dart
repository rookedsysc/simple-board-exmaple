import 'package:simple_board/model/post_entity.dart';
import 'package:simple_board/model/post_request_dto.dart';

class PostConverter {
  PostCreateDTO toCreateDto(PostEntity entity) {
    PostCreateDTO result = PostCreateDTO(
        userName: entity.userName,
        email: entity.email,
        title: entity.title,
        content: entity.content,
        password: entity.password);

    return result;
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:simple_board/model/post_entity.dart';

part 'post_view_model.g.dart';

@JsonSerializable()
class PostViewModel {
  @JsonKey(name: 'post_id')
  double postId;
  String password;

  PostViewModel({
    required this.postId,
    required this.password,
  });


  static PostViewModel entityToPostRequestModel(PostEntity entity) {
    return PostViewModel(
      postId: entity.id,
      password: entity.password,
    );
  }

  factory PostViewModel.fromJson(Map<String, dynamic> json) => _$PostViewModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostViewModelToJson(this);
}

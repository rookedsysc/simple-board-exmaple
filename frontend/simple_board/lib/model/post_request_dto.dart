import 'package:json_annotation/json_annotation.dart';
import 'package:simple_board/common/interface/request_base.dart';
import 'package:simple_board/model/post_entity.dart';

part 'post_request_dto.g.dart';

@JsonSerializable()
class PostDeleteDTO implements RequestBase {
  @JsonKey(name: 'post_id')
  double postId;
  @override
  String password;

  PostDeleteDTO({
    required this.postId,
    required this.password,
  });

  static PostDeleteDTO entityToPostRequestModel(PostEntity entity) {
    return PostDeleteDTO(
      postId: entity.id,
      password: entity.password,
    );
  }

  factory PostDeleteDTO.fromJson(Map<String, dynamic> json) => _$PostDeleteDTOFromJson(json);
  Map<String, dynamic> toJson() => _$PostDeleteDTOToJson(this);

}

@JsonSerializable()
class PostCreateDTO implements RequestBase {
  @JsonKey(name: 'user_name')
  String userName;
  String email;
  @override
  String password;
  String title;
  String content;

  PostCreateDTO({
    required this.userName,
    required this.email,
    required this.title,
    required this.content,
    required this.password,
  });

  factory PostCreateDTO.fromJson(Map<String, dynamic> json) => _$PostCreateDTOFromJson(json);
  Map<String, dynamic> toJson() => _$PostCreateDTOToJson(this);

}


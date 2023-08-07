import 'package:json_annotation/json_annotation.dart';
import 'package:simple_board/common/interface/request_base.dart';

part 'post_request_model.g.dart';

@JsonSerializable()
class PostCreateRequest implements RequestBase{
    @JsonKey(name: 'user_name')
    String userName;
    @override
    String password;
    String email;
    String title;
    String content;


  PostCreateRequest({
    required this.userName,
    required this.password,
    required this.email,
    required this.title,
    required this.content,
  });

  factory PostCreateRequest.fromJson(Map<String, dynamic> json) => _$PostCreateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostCreateRequestToJson(this);
}

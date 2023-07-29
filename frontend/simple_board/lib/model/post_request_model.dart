import 'package:json_annotation/json_annotation.dart';

part 'post_request_model.g.dart';

@JsonSerializable()
class PostRequestModel {
    @JsonKey(name: 'user_name')
    String userName;
    String password;
    String email;
    String title;
    String content;


  PostRequestModel({
    required this.userName,
    required this.password,
    required this.email,
    required this.title,
    required this.content,
  });

  factory PostRequestModel.fromJson(Map<String, dynamic> json) => _$PostRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostRequestModelToJson(this);
}
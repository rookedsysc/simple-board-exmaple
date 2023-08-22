import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:simple_board/common/interface/entity_base.dart';
import 'package:simple_board/common/interface/request_base.dart';

part 'reply_entity.g.dart';

@JsonSerializable()
class ReplyEntity implements EntityBase {
    int id;
    int postId;
    String userName;
    @override
    String password;
    @override
    String status;
    @override
    String title;
    String? content;
    DateTime repliedAt;

    ReplyEntity({
        required this.id,
        required this.postId,
        required this.userName,
        required this.password,
        required this.status,
        required this.title,
        required this.content,
        required this.repliedAt,
    });

    factory ReplyEntity.fromJson(Map<String, dynamic> json) => _$ReplyEntityFromJson(json);
    Map<String, dynamic> toJson() => _$ReplyEntityToJson(this);

  @override
  RequestBase toDeleteRequest() {
    // TODO: implement toDeleteRequest
    throw UnimplementedError();
  }
}

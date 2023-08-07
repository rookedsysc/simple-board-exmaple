import 'package:flutter/cupertino.dart';
import 'package:simple_board/common/interface/entity_base.dart';
import 'package:simple_board/common/interface/repository_base.dart';
import 'package:simple_board/common/interface/request_base.dart';
import 'package:simple_board/common/widget/delete_button.dart';

class ListItem<E extends EntityBase, R extends RequestBase>
    extends StatelessWidget {
  final Widget widgetDesign;
  final bool isEditing;
  final RepositoryBase reposiotry;
  final R request;
  const ListItem(
      {required this.widgetDesign,
      required this.reposiotry,
      required this.isEditing,
      required this.request,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widgetDesign
        ,
        isEditing
            ? DeleteButton<R>(
                repository: reposiotry,
                request: request,
              )
            : const SizedBox(),
      ],
    );
  }

}

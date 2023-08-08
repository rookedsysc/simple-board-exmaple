import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:simple_board/common/widget/editable_list_view.dart';
import 'package:simple_board/controller/repository/board_repository.dart';
import 'package:simple_board/model/board_entity.dart';
import 'package:simple_board/model/board_request_model.dart';
import 'package:simple_board/view/page/board_config_page.dart';

class BoardPage extends ConsumerWidget {
    static const String routeName = '/';
  const BoardPage ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditableList<BoardEntity, BoardDeleteModel>(
        itemDesign: _item,
        createPageButton: _createPageButton(context),
        repository: ref.read(boardRepositoryProvider));
  }
  Widget _item(BoardEntity entity, BuildContext context) {
    return Placeholder();
  }

  Widget _createPageButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        CupertinoScaffold.showCupertinoModalBottomSheet(context: context, builder: (context) => const BoardConfigPage());
      },
      child: const Icon(Icons.add),
    );
  }
}
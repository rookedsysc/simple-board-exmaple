import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sheet/route.dart';
import 'package:simple_board/common/interface/editable_item.dart';
import 'package:simple_board/common/widget/component_card.dart';
import 'package:simple_board/common/widget/pagination_list_view.dart';
import 'package:simple_board/controller/repository/board_repository.dart';
import 'package:simple_board/controller/service/board_service.dart';
import 'package:simple_board/controller/service/post_service.dart';
import 'package:simple_board/model/board_entity.dart';
import 'package:simple_board/model/board_request_dto.dart';
import 'package:simple_board/view/page/board_config_page.dart';
import 'package:simple_board/view/page/post_page.dart';
import 'package:simple_board/view/widget/board_item.dart';

class BoardPage extends StatelessWidget {
  static const String routeName = '/';
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      body: Scaffold(
        appBar: _appBar(context),
        floatingActionButton: const _GoToBoardConfigPageButton(),
        body: PaginationListView(
          provider: boardService,
          itemBuilder: <BoardEntity>(context, index, model) =>
              BoardItem(model: model),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Board List',
        style: Theme.of(context).textTheme.bodyLarge!,
      ),
    );
  }
}

class _GoToBoardConfigPageButton extends ConsumerWidget {
  const _GoToBoardConfigPageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        ref.read(boardConfigProvider.notifier).state = BoardConfigModel.reset();
        Navigator.of(context).push(
          CupertinoSheetRoute<void>(
            initialStop: 0.5,
            stops: <double>[0, 0.5, 1],
            // Screen은 이동할 스크린
            builder: (BuildContext context) => const BoardConfigPage(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

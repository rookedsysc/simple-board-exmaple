import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sheet/route.dart';
import 'package:simple_board/common/widget/component_card.dart';
import 'package:simple_board/common/widget/editable_list_view.dart';
import 'package:simple_board/controller/service/board_service.dart';
import 'package:simple_board/controller/service/post_service.dart';
import 'package:simple_board/model/board_entity.dart';
import 'package:simple_board/view/page/board_config_page.dart';
import 'package:simple_board/view/page/post_page.dart';

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
          itemBuilder: <BoardEntity>(context, index, model) => _Item(
            model: model,
          ),
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


class _Item extends ConsumerWidget {
  final BoardEntity model;
  const _Item({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(boardIdProvider.notifier).state = model.id.toInt();
        debugPrint(
            "boardIdProvider: ${ref.read(boardIdProvider.notifier).state}");
        context.push("/${PostPage.routeName}/${model.id}");
      },
      child: ComponentCard(
        height: 100,
        child: Center(
          child: Text(
            model.boardName,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

class _GoToBoardConfigPageButton extends StatelessWidget {
  const _GoToBoardConfigPageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
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

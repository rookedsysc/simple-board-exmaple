import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sheet/route.dart';
import 'package:simple_board/common/interface/editable_item.dart';
import 'package:simple_board/common/widget/component_card.dart';
import 'package:simple_board/controller/repository/board_repository.dart';
import 'package:simple_board/controller/service/post_service.dart';
import 'package:simple_board/model/board_entity.dart';
import 'package:simple_board/model/board_request_dto.dart';
import 'package:simple_board/view/page/board_config_page.dart';
import 'package:simple_board/view/page/post_page.dart';

class BoardItem extends ConsumerWidget {
  final BoardEntity model;
  const BoardItem({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _BoardEditableItem(
      repository: ref.read(boardRepositoryProvider),
      onDeletePress: () {
        ref.read(boardRepositoryProvider).delete(model.id);
        context.pop();
      },
      onEditPress: () async {
        ref.read(boardConfigProvider.notifier).state =
            BoardConfigModel(id: model.id, boardName: model.boardName);
        await Navigator.of(context).push(
          CupertinoSheetRoute<void>(
            initialStop: 0.5,
            stops: <double>[0, 0.5, 1],
            // Screen은 이동할 스크린
            builder: (BuildContext context) => const BoardConfigPage(isEdit: true,),
          ),
        );
        if (context.mounted) {
          context.pop();
        }
      },
      onTap: _onTap(ref, context),
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

  void Function() _onTap(WidgetRef ref, BuildContext context) {
    return () {
      ref.read(boardIdProvider.notifier).state = model.id.toInt();
      debugPrint(
          "boardIdProvider: ${ref.read(boardIdProvider.notifier).state}");
      context.push("/${PostPage.routeName}/${model.id}");
    };
  }
}

class _BoardEditableItem extends EditableItem {
  final BoardRepository repository;
  const _BoardEditableItem({
    required this.repository,
    required super.child,
    super.onDeletePress,
    super.onEditPress,
    super.onTap,
  });
}

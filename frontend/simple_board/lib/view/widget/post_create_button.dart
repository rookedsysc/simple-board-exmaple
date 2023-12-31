import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:simple_board/view/page/post_config_page.dart';

class PostCreateButton extends ConsumerWidget {
  final int boardId;
  const PostCreateButton({
    required this.boardId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        CupertinoScaffold.showCupertinoModalBottomSheet(
          context: context,
          builder: (context) => const PostConfigPage(),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

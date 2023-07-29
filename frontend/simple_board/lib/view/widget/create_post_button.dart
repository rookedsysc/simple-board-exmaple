import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_board/view/page/post_config_page.dart';

class CreatePostButton extends ConsumerWidget {
  const CreatePostButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        context.pushNamed(PostConfigPage.routeName);
      },
      child: const Icon(Icons.add),
    );
  }
}

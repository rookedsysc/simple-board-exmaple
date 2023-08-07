import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_board/common/widget/component_card.dart';
import 'package:simple_board/common/widget/editable_list_view.dart';
import 'package:simple_board/controller/repository/post_repository.dart';
import 'package:simple_board/model/post_entity.dart';
import 'package:simple_board/model/post_view_model.dart';
import 'package:simple_board/view/widget/post_create_button.dart';

class PostPage extends ConsumerWidget {
  static const String routeName = '/';
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditableList<PostEntity, PostViewModel>(
      createPageButton: const PostCreateButton(),
      itemDesign: _item,
      repository: ref.watch(postRepositoryProvider),
    );
  }

  Widget _item(PostEntity entity, BuildContext context) {
    String date = entity.postedAt.toString();
    return ComponentCard(
      height: 100,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              entity.title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(entity.content ?? "",
                style: Theme.of(context).textTheme.bodyMedium),
            const Expanded(child: SizedBox()),
            Text(
              "${entity.userName} $date",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}

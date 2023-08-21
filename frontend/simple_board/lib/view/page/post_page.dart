import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:simple_board/common/widget/pagination_list_view.dart';
import 'package:simple_board/controller/service/post_service.dart';
import 'package:simple_board/model/post_entity.dart';
import 'package:simple_board/view/widget/post_create_button.dart';
import 'package:simple_board/view/widget/post_item.dart';

class PostPage extends ConsumerWidget {
  static const String routeName = 'post_page';
  final int boardId;
  const PostPage({required this.boardId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoScaffold(
      body: Scaffold(
        floatingActionButton: PostCreateButton(
          boardId: boardId,
        ),
        appBar: _appBar(context),
        body: PaginationListView<PostEntity>(
          provider: postService,
          itemBuilder: (<PostEntity>(_, index, model) {
            return PostItem(model: model);
          }),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
        title: Text(
          'Post',
          style: Theme.of(context).textTheme.bodyLarge!,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
          context.pop();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:simple_board/common/widget/component_card.dart';
import 'package:simple_board/controller/repository/post_repository.dart';
import 'package:simple_board/model/post_entity.dart';
import 'package:simple_board/model/post_view_model.dart';
import 'package:simple_board/view/widget/create_post_button.dart';
import 'package:simple_board/view/widget/post_delete_button.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String routeName = '/';
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      body: Scaffold(
        floatingActionButton: const CreatePostButton(),
        appBar: AppBar(
          actions: [
            _editButton(context),
          ],
        ),
        body: FutureBuilder<List<PostEntity>>(
          future: ref.read(postRepositoryProvider).getAllPost(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            List<PostEntity> postList =
                snapshot.data!.where((e) => e.status == "REGISTERED").toList();
    
            return ListView(
              children: postList.map((e) => _item(context, e)).toList(),
            );
          },
        ),
      ),
    );
  }

  TextButton _editButton(BuildContext context) {
    return TextButton(
          onPressed: () {
            _isEditing = !_isEditing;
            setState(() {});
          },
          child: Text(
            _isEditing ? "Done" : "Edit",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.blue),
          ),
        );
  }

  Widget _item(BuildContext context, PostEntity e) {
    String date = DateFormat('yyyy-MM-dd').format(e.postedAt);
    return Stack(
      children: [
        ComponentCard(
          height: 100,
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  e.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(e.content ?? "",
                    style: Theme.of(context).textTheme.bodyMedium),
                const Expanded(child: SizedBox()),
                Text(
                  "${e.userName} $date",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
        _isEditing
            ? PostDeleteButton(
                postViewModel: PostViewModel.entityToPostRequestModel(e),
              )
            : const SizedBox(),
      ],
    );
  }
}


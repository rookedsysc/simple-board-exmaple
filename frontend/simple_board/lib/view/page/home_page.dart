import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_board/common/widget/component_card.dart';
import 'package:simple_board/controller/repository/post_repository.dart';
import 'package:simple_board/model/post_entity.dart';

class HomePage extends ConsumerWidget {
  static const String routeName = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: CreatePostButton(),
      appBar: AppBar(),
      body: FutureBuilder<List<PostEntity>>(
        future: ref.read(postRepositoryProvider).getAllPost(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.map((e) => _item(context, e)).toList(),
          );
        },
      ),
    );
  }

  Widget _item(BuildContext context, PostEntity e) {
    return ComponentCard(
      child: ListTile(
        title: Text(e.title, style: Theme.of(context).textTheme.bodyLarge),
        subtitle: Text(e.content ?? "",
            style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}


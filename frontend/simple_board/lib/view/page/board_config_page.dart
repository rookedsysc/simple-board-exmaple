import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_board/common/widget/component_card.dart';
import 'package:simple_board/common/widget/padding_factory.dart';
import 'package:simple_board/common/widget/plain_text_widget.dart';
import 'package:simple_board/controller/repository/board_repository.dart';
import 'package:simple_board/model/board_request_model.dart';
import 'package:simple_board/view/page/post_config_page.dart';

part 'board_config_page.g.dart';

final GlobalKey<FormState> _boardConfigKey = GlobalKey<FormState>();

class BoardConfigPage extends ConsumerWidget {
  static const String routeName = 'board_config_page';

  const BoardConfigPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoScaffold(
      body: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).primaryColor,),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: Form(
          key: _boardConfigKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ComponentCard(height: 50, child: _boardNameForm(ref)),
              PaddingFactory.createAll(
                child: _saveButton(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _boardNameForm(WidgetRef ref) {
    return PlainTextForm(
      title: 'User Name',
      hintText: ref.watch(postConfigPageProvider).userName,
      onSaved: (value) {
        ref.read(postConfigPageProvider).userName = value!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter user name';
        }
        return null;
      },
    );
  }

    Widget _saveButton(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
        onPressed: () async {
          if (_boardConfigKey.currentState!.validate()) {
            _boardConfigKey.currentState!.save();
            BoardCreateModel request = ref.read(boardConfigPageProvider);
            await ref.read(boardRepositoryProvider).create(request);
            if (context.mounted) {
              context.pop();
            }
          }
        },
        child: Text(
          'Save',
          style: Theme.of(context).textTheme.bodyMedium,
        ));
  }

}

@riverpod
BoardCreateModel boardConfigPage(BoardConfigPageRef ref) {
  return BoardCreateModel(boardName: "");
}

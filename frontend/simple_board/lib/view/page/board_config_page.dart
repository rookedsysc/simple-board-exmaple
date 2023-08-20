import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:simple_board/common/widget/component_card.dart';
import 'package:simple_board/common/widget/padding_factory.dart';
import 'package:simple_board/common/widget/plain_text_widget.dart';
import 'package:simple_board/controller/repository/board_repository.dart';
import 'package:simple_board/model/board_request_dto.dart';
import 'package:simple_board/view/page/post_config_page.dart';

final GlobalKey<FormState> _boardConfigKey = GlobalKey<FormState>();

class BoardConfigPage extends ConsumerWidget {
  final bool isEdit;
  static const String routeName = 'board_config_page';

  const BoardConfigPage({this.isEdit = false,super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoScaffold(
      body: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).primaryColor,
            ),
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

  Widget _boardNameForm(
    WidgetRef ref,
  ) {
    return PlainTextForm(
      title: 'Board Name',
      hintText: ref.watch(boardConfigProvider).boardName,
      onSaved: (value) {
        ref.read(boardConfigProvider.notifier).state =
            ref.read(boardConfigProvider).copyWith(boardName: value!);

        debugPrint("Board Name : ${ref.read(boardConfigProvider.notifier).state.boardName} Board ID : ${ref.read(boardConfigProvider.notifier).state.id}");
      },
      validator: (value) {
        if ((value == null || value.isEmpty) && !isEdit) {
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
          if (isEdit) {
            _boardUpdate(ref, context);
          } else {
            _boardCreate(ref, context);
          }
        }
      },
      child: Text(
        'Save',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Future<void> _boardCreate(WidgetRef ref, BuildContext context) async {
    _boardConfigKey.currentState!.save();
    BoardConfigModel request = ref.read(boardConfigProvider);

    ref.read(boardRepositoryProvider).create(request);
    context.pop();
  }

  Future<void> _boardUpdate(WidgetRef ref, BuildContext context) async {
    _boardConfigKey.currentState!.save();
    BoardConfigModel request = ref.read(boardConfigProvider);

    ref.read(boardRepositoryProvider).update(request);
    context.pop();
  }
}


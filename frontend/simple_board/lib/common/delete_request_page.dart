import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:simple_board/common/interface/entity_base.dart';
import 'package:simple_board/common/interface/repository_base.dart';
import 'package:simple_board/common/utils/error_alert.dart';
import 'package:simple_board/common/widget/component_card.dart';
import 'package:simple_board/common/widget/padding_factory.dart';
import 'package:simple_board/common/widget/plain_text_widget.dart';
import 'package:simple_board/controller/repository/post_repository.dart';
import 'package:simple_board/model/post_request_dto.dart';
import 'package:simple_board/view/widget/post_item.dart';

class DeleteRequestPage extends ConsumerWidget {
  static const String routeName = 'delete_request';
  final GlobalKey<FormState> _postDeleteKey;
  /// PostRepository 나 ReplyRepository를 사용해야 함
  /// checkPassword method를 사용함
  final RepositoryBase repository;
  final EntityBase model;
  const DeleteRequestPage(
      {required this.repository,
      required this.model,
      required GlobalKey<FormState> deleteKey,
      super.key})
      : _postDeleteKey = deleteKey;

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
          key: _postDeleteKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ComponentCard(
                child: PlainTextForm(
                  title: "Input Password",
                  onSaved: (value) {
                    ref.read(passwordConfirmProvider.notifier).state =
                        PostDeleteDTO(postId: model.id, password: value!);
                  },
                ),
              ),
              PaddingFactory.createAll(
                child: _PasswordConfirmButton(
                  repository: repository,
                  postDeletekey: _postDeleteKey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordConfirmButton extends ConsumerWidget {
  final RepositoryBase repository;
  final GlobalKey<FormState> _postDeleteKey;
  const _PasswordConfirmButton(
      {required this.repository,
      required GlobalKey<FormState> postDeletekey,
      super.key})
      : _postDeleteKey = postDeletekey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Theme.of(context).primaryColor),
      ),
      onPressed: () async {
        if (_postDeleteKey.currentState!.validate()) {
          _postDeleteKey.currentState!.save();
          PostDeleteDTO request =
              ref.read(passwordConfirmProvider.notifier).state;
          bool passCheck = false;
          try {
            passCheck =
                await ref.read(postRepositoryProvider).checkPassword(request);
          } catch (e) {
            ErrorAlert(context: context, err: e).dialog();
          }

          if (!passCheck) {
            // ignore: use_build_context_synchronously
            ErrorAlert(context: context, err: "Password is not correct")
                .dialog();
          }

          repository.delete(request.postId);

          if (passCheck && context.mounted) {
            context.pop();
          }
        }
      },
      child: Text(
        'Confirm',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

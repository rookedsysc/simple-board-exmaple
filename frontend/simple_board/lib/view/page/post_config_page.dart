import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_board/common/widget/plain_text_widget.dart';
import 'package:simple_board/common/widget/component_card.dart';
import 'package:simple_board/common/widget/padding_factory.dart';
import 'package:simple_board/controller/repository/post_repository.dart';
import 'package:simple_board/model/post_entity.dart';
import 'package:simple_board/model/post_request_dto.dart';

part 'post_config_page.g.dart';

final GlobalKey<FormState> _postConfigKey = GlobalKey<FormState>();

class PostConfigPage extends ConsumerWidget {
  static const String routeName = 'post_config_page';

  const PostConfigPage({super.key});

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
          key: _postConfigKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ComponentCard(height: 50, child: _userNameForm(ref)),
              ComponentCard(height: 50, child: _passwordForm(ref)),
              ComponentCard(height: 50, child: _emailForm(ref)),
              ComponentCard(height: 50, child: _titleForm(ref)),
              ComponentCard(height: 50, child: _contentForm(ref)),
              PaddingFactory.createAll(
                child: _saveButton(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userNameForm(WidgetRef ref) {
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

  PlainTextForm _passwordForm(WidgetRef ref) {
    return PlainTextForm(
      title: "Password",
      hintText: ref.watch(postConfigPageProvider).password,
      onSaved: (value) {
        ref.read(postConfigPageProvider).password = value!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
    );
  }

  Widget _emailForm(WidgetRef ref) {
    return PlainTextForm(
      title: "Email",
      hintText: ref.watch(postConfigPageProvider).email,
      onSaved: (value) {
        ref.read(postConfigPageProvider).email = value!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter email';
        }
        return null;
      },
    );
  }

  Widget _titleForm(WidgetRef ref) {
    return PlainTextForm(
      title: "Title",
      hintText: ref.watch(postConfigPageProvider).title,
      onSaved: (value) {
        ref.read(postConfigPageProvider).title = value!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter title';
        }
        return null;
      },
    );
  }

  Widget _contentForm(WidgetRef ref) {
    return PlainTextForm(
      title: "Content",
      hintText: ref.watch(postConfigPageProvider).content,
      onSaved: (value) {
        ref.read(postConfigPageProvider).content = value!;
      },
    );
  }

  Widget _saveButton(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
        onPressed: () async {
          if (_postConfigKey.currentState!.validate()) {
            _postConfigKey.currentState!.save();
            PostCreateDTO request = ref.read(postConfigPageProvider);
            await ref.read(postRepositoryProvider).create(request);
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
PostCreateDTO postConfigPage(PostConfigPageRef ref) {
  return PostCreateDTO(
    content: 'Content',
    email: 'Email',
    password: 'Password 4자리 숫자',
    title: 'Title',
    userName: 'User Nmae',
  );
}

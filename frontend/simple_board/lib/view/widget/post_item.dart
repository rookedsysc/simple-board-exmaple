import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sheet/route.dart';
import 'package:simple_board/common/delete_request_page.dart';
import 'package:simple_board/common/interface/editable_item.dart';
import 'package:simple_board/common/utils/error_alert.dart';
import 'package:simple_board/common/widget/component_card.dart';
import 'package:simple_board/common/widget/plain_text_widget.dart';
import 'package:simple_board/controller/converter/post_converter.dart';
import 'package:simple_board/controller/repository/post_repository.dart';
import 'package:simple_board/controller/service/post_service.dart';
import 'package:simple_board/model/post_entity.dart';
import 'package:simple_board/model/post_request_dto.dart';
import 'package:simple_board/view/page/post_config_page.dart';
import 'package:simple_board/view/page/post_page.dart';

final GlobalKey<FormState> _postDeleteKey = GlobalKey<FormState>();

class PostItem extends ConsumerWidget {
  final PostEntity model;
  const PostItem({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _PostEditableItem(
      repository: ref.read(postRepositoryProvider),
      onDeletePress: _onDelete(context, ref),
      onEditPress: () async {
        PostCreateDTO postCreateDTO = PostConverter().toCreateDto(model);

        ref.read(postConfigPageProvider.notifier).state = postCreateDTO;

        CupertinoScaffold.showCupertinoModalBottomSheet(
          context: context,
          builder: (context) => const PostConfigPage(),
        );
      },
      onTap: _onTap(ref, context),
      child: ComponentCard(
        height: 100,
        child: Center(
          child: Text(
            model.title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  void Function() _onDelete(BuildContext context, WidgetRef ref) {
    return () async {
      PostRepository repo = ref.read(postRepositoryProvider);
      Navigator.of(context).push(
        CupertinoSheetRoute<void>(
          initialStop: 0.5,
          stops: <double>[0, 0.5, 1],
          // Screen은 이동할 스크린
          builder: (BuildContext context) => DeleteRequestPage(
              repository: repo, model: model, deleteKey: _postDeleteKey),
        ),
      );
    };
    
  }

  void Function() _onTap(WidgetRef ref, BuildContext context) {
    return () {
      // ref.read(boardIdProvider.notifier).state = model.id.toInt();
      // debugPrint(
      //     "boardIdProvider: ${ref.read(boardIdProvider.notifier).state}");
      // context.push("/${PostPage.routeName}/${model.id}");
    };
  }

  
}

final passwordConfirmProvider = StateProvider<PostDeleteDTO> ((ref) => PostDeleteDTO(postId: 0, password: ""));

class _PostEditableItem extends EditableItem {
  final PostRepository repository;
  const _PostEditableItem({
    required this.repository,
    required super.child,
    super.onDeletePress,
    super.onEditPress,
    super.onTap,
  });
}

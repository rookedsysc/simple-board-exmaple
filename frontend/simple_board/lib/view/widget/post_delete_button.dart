import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_board/common/plain_text_widget.dart';
import 'package:simple_board/controller/repository/post_repository.dart';
import 'package:simple_board/model/post_view_model.dart';

class PostDeleteButton extends ConsumerWidget {
  final PostViewModel postViewModel;
  const PostDeleteButton({
    super.key,
    required this.postViewModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: -5,
      right: -5,
      child: IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Delete"),
                  content: PlainTextForm(
                    title: "Password",
                    hintText: "Enter your password(4 digits)",
                    onChanged: (value) {
                      postViewModel.password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        try {
                          await ref
                              .read(postRepositoryProvider)
                              .delete(postViewModel);
                          if (context.mounted) {
                            context.pop();
                          }
                        } catch (e) {
                          _errorAlert(context, e);
                        }
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              });
        },
        icon: const Icon(
          Icons.delete_outline_outlined,
          color: Colors.redAccent,
        ),
      ),
    );
  }

  Future<dynamic> _errorAlert(BuildContext context, Object e) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }
}

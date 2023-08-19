import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_board/common/interface/repository_base.dart';
import 'package:simple_board/common/interface/request_base.dart';
import 'package:simple_board/common/widget/plain_text_widget.dart';

class DeleteButton<R extends RequestBase> extends ConsumerWidget {
  final R request;
  final RepositoryRegacyBase repository;
  const DeleteButton({
    super.key,
    required this.request,
    required this.repository,
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
                      request.password = value;
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
                          repository.delete(request);
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

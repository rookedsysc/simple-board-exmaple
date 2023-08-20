import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class EditableItem extends ConsumerWidget {
  final Widget child;
  final VoidCallback? onDeletePress;
  final VoidCallback? onEditPress;
  final GestureTapCallback? onTap;

  const EditableItem(
      {required this.child,
      this.onDeletePress,
      this.onEditPress,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: onTap, onLongPress: _onLongPress(context, ref), child: child);
  }

  void Function() _onLongPress(BuildContext context, WidgetRef ref) {
    return () {
      ThemeData appTheme = Theme.of(context);
      double fontSize = 20;
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          List<CupertinoActionSheetAction> actions = [];

          if (onEditPress != null) {
            actions.add(
              CupertinoActionSheetAction(
                onPressed: onEditPress!,
                child: Text(
                  'Edit',
                  style: appTheme.textTheme.bodyMedium?.copyWith(
                      fontSize: fontSize,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            );
          }

          ///# Delete Button
          if (onDeletePress != null) {
            actions.add(
              CupertinoActionSheetAction(
                onPressed: onDeletePress!,
                child: Text(
                  'Delete',
                  style: appTheme.textTheme.bodyMedium
                      ?.copyWith(fontSize: fontSize, color: Colors.red),
                ),
              ),
            );
          }

          return CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[...actions],
          );
        },
      );
    };
  }
}

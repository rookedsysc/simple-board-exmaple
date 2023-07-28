import 'package:flutter/material.dart';
import 'package:simple_board/common/widget/padding_factory.dart';

class ComponentCard extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;
  const ComponentCard(
      {this.height, this.width, super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PaddingFactory.createAll(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.cardColor,
        ),
        child: child,
      ),
    );
  }
}

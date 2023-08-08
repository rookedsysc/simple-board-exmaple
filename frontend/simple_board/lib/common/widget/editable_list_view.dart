import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:simple_board/common/interface/entity_base.dart';
import 'package:simple_board/common/interface/repository_base.dart';
import 'package:simple_board/common/interface/request_base.dart';
import 'package:simple_board/common/widget/list_item.dart';

class EditableList<E extends EntityBase<DR>, DR extends RequestBase>  extends StatefulWidget {
  final Widget createPageButton;
  final Widget Function(E, BuildContext) itemDesign;
  final RepositoryBase<E> repository;

  const EditableList(
      {super.key,
      required this.itemDesign,
      required this.createPageButton,
      required this.repository});

  @override
  State<EditableList<E, DR>> createState() => _EditableListState<E,DR>();
}

class _EditableListState<E extends EntityBase<DR>, DR extends RequestBase> extends State<EditableList<E, DR>> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      body: Scaffold(
        floatingActionButton: widget.createPageButton,
        appBar: AppBar(
          actions: [
            _editButton(context),
          ],
        ),
        body: FutureBuilder<List<E>>(
          future: widget.repository.getAll(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            List<E> entityList =
                snapshot.data!.where((e) => e.status == "REGISTERED").toList();

            return ListView(
              children: entityList
                  .map((e) => ListItem<E, DR>(
                        widgetDesign: _widgetBuild(e, context),
                        isEditing: _isEditing,
                        reposiotry: widget.repository,
                        request: e.toDeleteRequest(),
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _widgetBuild(E entity, BuildContext context) {
    return widget.itemDesign(entity, context);
  }

  TextButton _editButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        _isEditing = !_isEditing;
        setState(() {});
      },
      child: Text(
        _isEditing ? "Done" : "Edit",
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Theme.of(context).primaryColor),
      ),
    );
  }
}

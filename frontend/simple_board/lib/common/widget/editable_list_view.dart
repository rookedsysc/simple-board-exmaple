import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_board/common/interface/entity_base.dart';
import 'package:simple_board/common/model/pagination_model.dart';
import 'package:simple_board/common/utils/pagination_utils.dart';
import 'package:simple_board/controller/service/pagination.dart';

typedef PaginationWidgetBuilder<E extends EntityBase> = Widget Function(
    BuildContext context, int index, E model);

class PaginationListView<E extends EntityBase> extends ConsumerStatefulWidget {
  final AutoDisposeStateNotifierProvider<Pagination, CursorPaginationBase>
      provider;
  final PaginationWidgetBuilder<E> itemBuilder;
  const PaginationListView(
      {required this.provider, required this.itemBuilder, super.key});

  @override
  ConsumerState<PaginationListView> createState() => PaginationListViewState<E>();
}

class PaginationListViewState<E extends EntityBase> extends ConsumerState<PaginationListView> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(listner);
  }

  void listner() {
    PaginationUtils.paginate(controller: controller, provider: ref.read(widget.provider.notifier));
  }

  @override
  void dispose() {
    controller.removeListener(listner);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    if (state is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CursorPaginationError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(state.message),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: () {
            ref.read(widget.provider.notifier).paginate(forceRefetch: true);
          }, child: const Text('Retry'),)
        ],
      );
      }

    final cursorPagination = state as CursorPagination<E>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Scrollbar(
        controller: controller,
        //: 아래로 스왑하면 강제로 새로고침 됨
        child: RefreshIndicator(
          onRefresh: () async {
            ref.read(widget.provider.notifier).paginate(forceRefetch: true);
          },
          child: ListView.separated(
            //: 리스트 뷰는 화면을 초과하지 않으면 스크롤이 안됨
            //: 아래(👇)와 같은 옵션을 사용해주면 항상 스크롤이 가능하게 해줌
            physics: const AlwaysScrollableScrollPhysics(),
            controller: controller,
            itemCount: cursorPagination.data.length + 1, // +1은 로딩을 위해서 
            itemBuilder: (context, index) { 
              if(index == cursorPagination.data.length) {
                // 데이터가 FetchingMore(로딩 중)인 경우에만 ProgressIndicator를 보여줌
                return Center(child: cursorPagination is CursorPaginationFetchingMore ? const CircularProgressIndicator() : const SizedBox());
              }

              final pItem = cursorPagination.data[index];

              return widget.itemBuilder(
                context,
                index,
                pItem,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16.0);
            },
          ),
        ),
      ),
    );;
  }
}
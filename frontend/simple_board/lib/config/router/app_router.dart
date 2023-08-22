import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheet/route.dart';
import 'package:simple_board/view/page/board_config_page.dart';
import 'package:simple_board/view/page/board_page.dart';
import 'package:simple_board/view/page/post_page.dart';
import 'package:simple_board/view/page/post_config_page.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    routes: [
      _boardPage(
        routes: [
          /// /board/board_config_page
          _boardConfigPage(
            routes: [],
          ),
          /// /post/:boardId
          _postPage(
            routes: [
              _postConfigPage(
                routes: [],
              ),
            ],
          )
        ],
      ),
      // _postPage(routes: [
      //   _postConfigPage(routes: []),
      // ]),
    ],
  );
}

GoRoute _boardPage({required List<GoRoute> routes}) {
  return GoRoute(
    path: BoardPage.routeName,
    name: BoardPage.routeName,
    pageBuilder: (context, state) => const MaterialExtendedPage(
      child: BoardPage(),
    ),
    // builder: (context, state) => const BoardPage(),
    routes: routes,
  );
}

GoRoute _boardConfigPage({required List<GoRoute> routes}) {
  return GoRoute(
    path: BoardConfigPage.routeName,
    name: BoardConfigPage.routeName,
    pageBuilder: (context, state) => const MaterialExtendedPage(
      child: BoardConfigPage(),
    ),
    // builder: (context, state) => const BoardConfigPage(),
    routes: routes,
  );
}

GoRoute _postPage({required List<GoRoute> routes}) {
  return GoRoute(
    path: "${PostPage.routeName}/:boardId",
    name: PostPage.routeName,
    builder: (context, state) {
      int boardId;
      boardId = int.parse(state.pathParameters['boardId']!);
      return PostPage(
        boardId: boardId,
      );
    },
    routes: routes,
  );
}

GoRoute _postConfigPage({required List<GoRoute> routes}) {
  return GoRoute(
    path: PostConfigPage.routeName,
    name: PostConfigPage.routeName,
    builder: (context, state) => const PostConfigPage(),
    routes: routes,
  );
}

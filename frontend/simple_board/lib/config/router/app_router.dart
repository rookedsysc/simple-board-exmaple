import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_board/view/page/board_page.dart';
import 'package:simple_board/view/page/post_page.dart';
import 'package:simple_board/view/page/post_config_page.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    routes: [
        _postPage(routes: [
          _postConfigPage(routes: []),
        ]),
    ],
  );
}

GoRoute _boardPage({required List<GoRoute> routes}) {
  return GoRoute(
    path: BoardPage.routeName,
    name: BoardPage.routeName,
    builder: (context, state) => const BoardPage(),
    routes: routes,
  );
}

GoRoute _postPage({required List<GoRoute> routes}) {
  return GoRoute(
    path: PostPage.routeName,
    name: PostPage.routeName,
    builder: (context, state) => const PostPage(),
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

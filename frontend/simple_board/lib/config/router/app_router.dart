import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_board/view/page/home_page.dart';
import 'package:simple_board/view/page/post_config_page.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    routes: [
      _homePage(routes: [
        _postConfigPage(routes: []),
      ]),
    ],
  );
}

GoRoute _homePage({required List<GoRoute> routes}) {
  return GoRoute(
    path: HomePage.routeName,
    name: HomePage.routeName,
    builder: (context, state) => const HomePage(),
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

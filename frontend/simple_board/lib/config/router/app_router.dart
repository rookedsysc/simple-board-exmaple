import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_board/view/page/home_page.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    routes: [
      _homePage(routes:[]),
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

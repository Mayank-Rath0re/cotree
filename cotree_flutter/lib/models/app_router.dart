import 'package:cotree_flutter/models/route_constants.dart';
import 'package:cotree_flutter/pages/feed_page.dart';
import 'package:cotree_flutter/pages/home_page.dart';
import 'package:cotree_flutter/pages/login_page.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      name: RouteConstants.home,
      path: '/',
      builder: (context, state) => HomePage()),
  GoRoute(
      name: RouteConstants.login,
      path: '/login',
      builder: (context, state) => const LoginPage()),
  GoRoute(
      name: 'feed',
      path: '/feed',
      builder: (context, state) {
        return const FeedPage();
      }),
]);

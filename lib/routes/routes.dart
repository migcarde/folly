import 'package:folly/features/home/home_page.dart';
import 'package:folly/features/register/register_page.dart';
import 'package:folly/routes/paths.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static List<GoRoute> get list => [
    GoRoute(
      path: Paths.home.route,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: Paths.login.route,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: Paths.register.route,
      builder: (context, state) => const RegisterPage(),
    ),
  ];
}

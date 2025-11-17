import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/routes/routes.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authNotifierProvider);
  ref.read(authNotifierProvider.notifier).listen();

  return GoRouter(
    routes: Routes.list,
    initialLocation: Paths.login.route,
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final isConnected = authNotifier.user != null;

      if (!isConnected && state.fullPath != Paths.register.route) {
        return Paths.login.route;
      } else if (isConnected &&
          (state.fullPath == Paths.register.route ||
              state.fullPath == Paths.login.route)) {
        return Paths.home.route;
      } else {
        return null;
      }
    },
  );
});

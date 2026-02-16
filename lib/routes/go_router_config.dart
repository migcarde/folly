import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/routes/routes.dart';
import 'package:go_router/go_router.dart';

final globalNavigationKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final allowedPaths = [
    Paths.register.route,
    Paths.resetPasswordRequest.route,
    Paths.changePassword.route,
  ];
  final authStateListenable = ValueNotifier<bool>(false);

  ref.listen(authNotifierProvider, (previous, next) {
    final isLoggedIn = next.user != null;

    if (isLoggedIn != authStateListenable.value) {
      authStateListenable.value = isLoggedIn;
    }
  });

  return GoRouter(
    navigatorKey: globalNavigationKey,
    routes: Routes.list,
    initialLocation: Paths.initial.route,
    refreshListenable: authStateListenable,
    redirect: (context, state) {
      final authState = ref.watch(authNotifierProvider);
      final isConnected = ref.read(authNotifierProvider.notifier).user != null;
      final isLoading = ref.watch(authNotifierProvider).isLoading;

      if (authState.status.isPasswordRecovery) {
        FlutterNativeSplash.remove();
        return Paths.changePassword.route;
      } else if (!isLoading &&
          !isConnected &&
          !allowedPaths.contains(state.fullPath)) {
        FlutterNativeSplash.remove();
        return Paths.login.route;
      } else if (!isLoading &&
          isConnected &&
          (state.fullPath == Paths.register.route ||
              state.fullPath == Paths.login.route ||
              state.fullPath == Paths.initial.route)) {
        FlutterNativeSplash.remove();
        return Paths.home.route;
      } else {
        return null;
      }
    },
  );
});

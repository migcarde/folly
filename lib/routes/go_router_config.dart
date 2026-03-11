import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/extensions/string_extensions.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/routes/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:logging_service/logging_service.dart';

final globalNavigationKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final allowedPaths = [
    Paths.register.name,
    Paths.resetPasswordRequest.name,
    Paths.changePassword.name,
    Paths.initial.name,
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
    onException: (context, state, router) {
      final log = LoggingService.getLogger('go_router');
      log.severe('GoRouter exception: ${state.uri}');
    },
    redirect: (context, state) {
      final authState = ref.watch(authNotifierProvider);
      final isConnected = ref.read(authNotifierProvider.notifier).user != null;
      final isLoading = ref.read(authNotifierProvider).isLoading;
      final isAllowed = allowedPaths.contains(state.fullPath?.lastUrlSegment);

      if (isLoading && !authState.status.isPasswordRecovery) {
        return null;
      } else {
        FlutterNativeSplash.remove();

        if (authState.status.isPasswordRecovery) {
          return Paths.changePassword.route;
        } else if (!isConnected && !isAllowed) {
          return Paths.login.route;
        } else if (isConnected && (isAllowed || state.fullPath == '/')) {
          return Paths.home.route;
        } else {
          return null;
        }
      }
    },
  );
});

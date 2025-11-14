import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/l10n/app_localizations.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/routes/routes.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await DomainInitializer.init(
    anonKey: dotenv.env['ANON_KEY']!,
    url: dotenv.env['SUPABASE_URL']!,
  );

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotfier = ref.watch(authNotifierProvider);
    ref.read(authNotifierProvider.notifier).listen();

    return MaterialApp.router(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      routerConfig: GoRouter(
        routes: Routes.list,
        initialLocation: Paths.login.route,
        refreshListenable: authNotfier,
        redirect: (context, state) {
          final isConnected = authNotfier.user != null;

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
      ),
    );
  }
}

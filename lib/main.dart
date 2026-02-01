import 'package:domain/domain.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/firebase_options.dart';
import 'package:folly/l10n/app_localizations.dart';
import 'package:folly/l10n/localization_notifier.dart';
import 'package:folly/routes/go_router_config.dart';
import 'package:folly/services/messaging/messaging_notifier.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DomainInitializer.init(
    anonKey: dotenv.env['ANON_KEY']!,
    url: dotenv.env['SUPABASE_URL']!,
  );

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(authNotifierProvider.notifier).listen();
    });
  }

  @override
  Widget build(BuildContext context) {
    final goRouterNotifier = ref.watch(goRouterProvider);
    final locale = ref.watch(localizationProvider);
    ref.watch(messagingNotifierProvider);

    return MaterialApp.router(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      routerConfig: goRouterNotifier,
    );
  }
}

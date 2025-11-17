import 'package:folly/features/home/home_page.dart';
import 'package:folly/features/login/login_page.dart';
import 'package:folly/features/register/register_page.dart';
import 'package:folly/features/upload_story/upload_story_page.dart';
import 'package:folly/routes/paths.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class Routes {
  static List<GoRoute> get list => [
    GoRoute(
      path: Paths.home.route,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: Paths.login.route,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: Paths.register.route,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: Paths.uploadStory.route,
      builder: (context, state) => UploadStoryPage(file: state.extra as XFile),
    ),
  ];
}

import 'package:domain/users/models/user_entity.dart';
import 'package:folly/features/change_language/change_language_page.dart';
import 'package:folly/features/edit_profile/edit_profile_page.dart';
import 'package:folly/features/friends/friends_page.dart';
import 'package:folly/features/friends/models/friends_view_model.dart';
import 'package:folly/features/home/home_page.dart';
import 'package:folly/features/login/login_page.dart';
import 'package:folly/features/profile/profile_page.dart';
import 'package:folly/features/register/register_page.dart';
import 'package:folly/features/settings/settings_page.dart';
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
    GoRoute(
      path: Paths.settings.route,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: Paths.editProfile.route,
      builder: (context, state) => const EditProfilePage(),
    ),
    GoRoute(
      path: Paths.changeLanguage.route,
      builder: (context, state) => const ChangeLanguagePage(),
    ),
    GoRoute(
      path: Paths.userProfile.route,
      builder: (context, state) {
        final user = state.extra! as UserEntity;

        return ProfilePage(user: user);
      },
    ),
    GoRoute(
      path: Paths.friends.route,
      builder: (context, state) {
        final viewModel = state.extra! as FriendsViewModel;

        return FriendsPage(viewModel: viewModel);
      },
    ),
  ];
}

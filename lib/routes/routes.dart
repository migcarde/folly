import 'package:flutter/material.dart';
import 'package:folly/features/change_language/change_language_page.dart';
import 'package:folly/features/edit_profile/edit_profile_page.dart';
import 'package:folly/features/friends/friends_page.dart';
import 'package:folly/features/friends/models/friends_view_model.dart';
import 'package:folly/features/home/home_page.dart';
import 'package:folly/features/home/reset_password_request/reset_password_request_page.dart';
import 'package:folly/features/login/login_page.dart';
import 'package:folly/features/profile/models/profile_params.dart';
import 'package:folly/features/profile/profile_page.dart';
import 'package:folly/features/register/register_page.dart';
import 'package:folly/features/reset_password/reset_password_page.dart';
import 'package:folly/features/settings/settings_page.dart';
import 'package:folly/features/stories/story_page.dart';
import 'package:folly/features/upload_story/upload_story_page.dart';
import 'package:folly/routes/paths.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class Routes {
  static List<GoRoute> get list => [
    GoRoute(path: Paths.initial.route, builder: (context, state) => Scaffold()),
    GoRoute(
      path: Paths.home.route,
      name: Paths.home.name,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: Paths.userProfile.route,
          name: Paths.userProfile.name,
          builder: (context, state) {
            final profileParams = state.extra as ProfileParams?;

            late ProfileParams params;

            if (profileParams == null) {
              params = ProfileParams(uid: state.uri.queryParameters['id']);
            } else {
              params = profileParams;
            }

            return ProfilePage(params: params);
          },
          routes: [
            GoRoute(
              path: Paths.friends.route,
              name: Paths.friends.name,
              builder: (context, state) {
                final viewModel = state.extra! as FriendsViewModel;

                return FriendsPage(viewModel: viewModel);
              },
            ),
          ],
        ),
        GoRoute(
          path: Paths.uploadStory.route,
          name: Paths.uploadStory.name,
          builder: (context, state) =>
              UploadStoryPage(file: state.extra as XFile),
        ),
        GoRoute(
          path: Paths.settings.route,
          name: Paths.settings.name,
          builder: (context, state) => const SettingsPage(),
          routes: [
            GoRoute(
              path: Paths.editProfile.route,
              name: Paths.editProfile.name,
              builder: (context, state) => const EditProfilePage(),
            ),
            GoRoute(
              path: Paths.changeLanguage.route,
              name: Paths.changeLanguage.name,
              builder: (context, state) => const ChangeLanguagePage(),
            ),
          ],
        ),
        GoRoute(
          path: Paths.story.route,
          name: Paths.story.name,
          builder: (context, state) {
            final storyId = state.extra as String;

            return StoryPage(storyId: storyId);
          },
        ),
      ],
    ),
    GoRoute(
      path: Paths.login.route,
      name: Paths.login.name,
      builder: (context, state) => const LoginPage(),
      routes: [
        GoRoute(
          path: Paths.register.route,
          name: Paths.register.name,
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: Paths.resetPasswordRequest.route,
          name: Paths.resetPasswordRequest.name,
          builder: (context, state) => const ResetPasswordRequestPage(),
        ),
      ],
    ),
    GoRoute(
      path: Paths.changePassword.route,
      name: Paths.changePassword.name,
      builder: (context, state) => const ResetPasswordPage(),
    ),
  ];
}

enum Paths {
  initial(route: '/'),
  home(route: '/home'),
  login(route: '/login'),
  register(route: '/register'),
  resetPasswordRequest(route: '/reset-password-request'),
  changePassword(route: '/change-password'),
  uploadStory(route: '/upload-story'),
  settings(route: '/settings'),
  editProfile(route: '/edit-profile'),
  changeLanguage(route: '/change-language'),
  userProfile(route: '/user-profile'),
  friends(route: '/friends');

  final String route;

  const Paths({required this.route});
}

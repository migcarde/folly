enum Paths {
  initial(route: '/'),
  home(route: '/home'),
  login(route: '/login'),
  register(route: '/register'),
  resetPasswordRequest(route: '/resetPasswordRequest'),
  changePassword(route: '/changePassword'),
  uploadStory(route: '/uploadStory'),
  settings(route: '/settings'),
  editProfile(route: '/editProfile'),
  changeLanguage(route: '/changeLanguage'),
  userProfile(route: '/userProfile/:id'),
  friends(route: '/friends'),
  story(route: '/story');

  final String route;

  const Paths({required this.route});
}

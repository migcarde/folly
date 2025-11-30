enum Paths {
  home(route: '/home'),
  login(route: '/login'),
  register(route: '/register'),
  uploadStory(route: '/upload-story'),
  settings(route: '/settings'),
  editProfile(route: '/edit-profile'),
  changeLanguage(route: '/change-language'),
  userProfile(route: '/user-profile');

  final String route;

  const Paths({required this.route});
}

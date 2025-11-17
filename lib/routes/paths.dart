enum Paths {
  home(route: '/home'),
  login(route: '/login'),
  register(route: '/register'),
  uploadStory(route: '/upload-story');

  final String route;

  const Paths({required this.route});
}

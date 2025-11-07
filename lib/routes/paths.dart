enum Paths {
  home(route: '/home'),
  login(route: '/login'),
  register(route: '/register');

  final String route;

  const Paths({required this.route});
}

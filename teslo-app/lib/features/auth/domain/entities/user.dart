class User {
  final String id;
  final String email;
  final String fullaName;
  final List<String> roles;
  final String token;

  User(
      {required this.id,
      required this.email,
      required this.fullaName,
      required this.roles,
      required this.token});

  bool get isAdmin => roles.contains('admin');
}
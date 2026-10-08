enum UserRole {
  superAdmin,
  admin,
}

class AuthUser {
  final String id;
  final String name;
  final String email;
  final String password;
  final UserRole role;
  final String? division;

  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.division,
  });
}
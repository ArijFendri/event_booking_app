class User {
  final String email;
  final String password;
  final String token;
  final String lastName;
  final String firstName;

  User({
    required this.email,
    required this.password,
    required this.token,
    required this.lastName,
    required this.firstName,
  });

  // Méthode pour créer un User à partir d'un JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      token: json['token'],
      lastName: json['lastName'],
      firstName: json['firstName'],
    );
  }

  // Méthode pour convertir un User en JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'token': token,
    };
  }
}

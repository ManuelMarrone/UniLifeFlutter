class Utente{
  String username;
  String email;
  String password;

  Utente({
    required this.username,
    required this.email,
    required this.password
});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  static Utente fromMap(Map<String, dynamic> map) {
    return Utente(
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }
}

class Utente{
  String? id_gruppo;
  String username;
  String email;
  String password;

  Utente({
    this.id_gruppo,
    required this.username,
    required this.email,
    required this.password
});

  Map<String, dynamic> toMap() {
    return {
      'id_gruppo':id_gruppo,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  static Utente fromMap(Map<String, dynamic> map) {
    return Utente(
      id_gruppo: map['id_gruppo'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }
}

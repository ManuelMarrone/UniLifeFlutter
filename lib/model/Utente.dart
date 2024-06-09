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

}

import 'package:flutter/cupertino.dart';

import '../repository/UtenteRepository.dart';
import '../utils/InputValidator.dart';


class RegistrazioneViewModel with ChangeNotifier{
  final UtenteRepository _utenteRepo = UtenteRepository();
  late Future<bool> _result;
  Future<bool> get result => _result;

  Future<void> registra(String email, String password, String username) async
  {
    _result = _utenteRepo.createUserWithEmailAndPassword(email: email, password: password, username: username);
    notifyListeners();
  }

  String? validateUsername(String? username) {
    return InputValidator.validateUsername(username);
  }

  String? validateEmail(String? email) {
    return InputValidator.validateEmail(email);
  }

  String? validatePassword(String? password) {
    return InputValidator.validatePassword(password);
  }

  Future<bool> isEmailUnique(String email) async {
    return _utenteRepo.isEmailUnique(email);
  }

  Future<bool> isUsernameUnique(String username) async {
    return _utenteRepo.isUsernameUnique(username);
  }

}
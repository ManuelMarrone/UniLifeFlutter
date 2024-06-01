import 'package:flutter/cupertino.dart';

import '../repository/auth.dart';

class Accessoviewmodel with ChangeNotifier{
  final Auth _repo = Auth();
  late Future<bool> _result;
  Future<bool> get result => _result;

  Future<void> accedi(String email, String password) async
  {
    _result = _repo.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }



}
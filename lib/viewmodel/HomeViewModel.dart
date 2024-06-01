import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../repository/auth.dart';

class Homeviewmodel with ChangeNotifier{
  final Auth _repo = Auth();

  Future<void> disconetti() async
  {
    await _repo.signOut();
    notifyListeners();
  }

  Stream<User?> get authStateChanges => _repo.authStateChanges;

}
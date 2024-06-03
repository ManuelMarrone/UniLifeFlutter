import 'package:flutter/material.dart';

class GruppoListener with ChangeNotifier  //changeNotifier per notificare a chi è in ascolto quando cambia lo stato
{
  bool _hasGruppo = false;

  bool get hasGruppo => _hasGruppo;

  void setHasGruppo(bool value) {
    _hasGruppo = value;
    notifyListeners();
  }
}
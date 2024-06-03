import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../repository/GruppoRepository.dart';
import '../repository/UtenteRepository.dart';
import '../repository/auth.dart';

class HomeViewModel with ChangeNotifier{
  final Auth _repo = Auth();
  final UtenteRepository _utenteRepo = UtenteRepository();
  final GruppoRepository _gruppoRepo = GruppoRepository();

  Future<void> disconetti() async
  {
    await _repo.signOut();
    notifyListeners();
  }

  Future<bool> controllaIdGruppo() async {
    var idGruppo =  await _utenteRepo.getUserGroupId();
    if(idGruppo != null)
      {
        return true;
      }
    else
      {
        return false;
      }
  }

  Future<bool> accettaInvito(String codice) async
  {
    try
        {
          var gruppo = await _gruppoRepo.getGruppo(codice);
          print("gruppo ${codice}");
          if(gruppo.exists)
            {
              print("gruppo esiste");
              String? username = await _utenteRepo.getCurrentUsername();
              if(username != null)
                {
                  await _utenteRepo.setIdGruppo(codice);
                  await _gruppoRepo.aggiungiPartecipante(username, codice);
                  return true;
                }
              else
                {
                  return false;
                }
            }
          else
            {
              return false;
            }
        }
        catch(e)
    {
      return false;
    }
  }

  Stream<User?> get authStateChanges => _repo.authStateChanges;

}
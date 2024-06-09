import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../repository/GruppoRepository.dart';
import '../repository/UtenteRepository.dart';
import '../repository/auth.dart';

class HomeViewModel with ChangeNotifier{
  final Auth _repo = Auth();
  final UtenteRepository _utenteRepo = UtenteRepository();
  final GruppoRepository _gruppoRepo = GruppoRepository();
  String? _idGruppo;
  final StreamController<List<String>> _listaSpesaController = StreamController<List<String>>();

  Stream<List<String>> get listaSpesa => _listaSpesaController.stream;

  HomeViewModel()
  {
    controllaIdGruppo();
  }


  void fetchListaSpesa() async {
    final listaSpesaStream = await _gruppoRepo.getListaSpesa(_idGruppo!);
    listaSpesaStream.listen((elementi) {
      _listaSpesaController.add(elementi);
    });
  }

  void eliminaElementoLista(String elemento) async {
    try {
      await _gruppoRepo.eliminaElementoLista(_idGruppo!, elemento);
      //aggiorna la lista
      fetchListaSpesa();
    } catch (e) {
      // Gestisci eventuali errori
      throw Exception('Errore durante l\'eliminazione dell\'elemento in lista: $e');
    }
  }

  void aggiungiElementoLista(String elemento) async {
    try {
      await _gruppoRepo.aggiungiElementoLista(elemento, _idGruppo!);
      //aggiorna la lista
      fetchListaSpesa();
    } catch (e) {
      // Gestisci eventuali errori
      throw Exception('Errore durante l\'aggiunta dell\'elemento in lista: $e');
    }
  }

  Future<void> disconetti() async
  {
    await _repo.signOut();
    notifyListeners();
  }

  Future<bool> controllaIdGruppo() async {
    _idGruppo =  await _utenteRepo.getUserGroupId();
    if(_idGruppo != null)
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
          if(gruppo.exists)
            {
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

  void dispose()
  {
    super.dispose();
    _listaSpesaController.close();
  }

}
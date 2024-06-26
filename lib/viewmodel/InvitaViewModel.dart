import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:unilife_flutter/repository/UtenteRepository.dart';


import '../model/Gruppo.dart';
import '../repository/GruppoRepository.dart';
import '../utils/InputValidator.dart';

class InvitaViewModel extends ChangeNotifier {
  final UtenteRepository _utenteRepo = UtenteRepository();
  final GruppoRepository _gruppoRepo = GruppoRepository();
  String? _idGruppo;

  final StreamController<List<String>> _partecipantiController = StreamController<List<String>>();

  Stream<List<String>> get partecipanti => _partecipantiController.stream;

  InvitaViewModel()
  {
    caricaIdGruppo();
  }

  Future<bool> checkUsername(String username)
  async {
    String? currentUser = await _utenteRepo.getCurrentUsername();
    if (currentUser == username)
      {
        return true;
      }
    else
      {
        return false;
      }
  }

  void fetchPartecipanti() async {
    final partecipantiStream = await _gruppoRepo.getPartecipanti(_idGruppo!);
    partecipantiStream.listen((utenti) {
      _partecipantiController.add(utenti);
    });
  }

  Future<void> invita(String email)
  async {
    final Email emailObject = Email(
      body: 'Sei stato invitato al gruppo di coinquilini, registrati all\'app se non l\'hai '
          'ancora fatto e inserisci il codice: $_idGruppo',
      subject: 'Invito al gruppo di coinquilini',
      recipients: [email],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(emailObject);
    } catch (error) {
      throw Exception('Errore durante l\'invio dell\'email: $error');
    }
  }

  String? validateEmail(String? email) {
    return InputValidator.validateEmail(email);
  }


  void eliminaPartecipante(String username) async {
    try {
      await _utenteRepo.eliminaIdGruppo(username);
      await _gruppoRepo.eliminaPartecipante(_idGruppo!, username);
      //aggiorna lo stream dei partecipanti
      fetchPartecipanti();
    } catch (e) {
      //gestisci errori
      throw Exception('Errore durante l\'eliminazione del partecipante: $e');
      }
  }

  Future<void> caricaIdGruppo() async {
    _idGruppo = await _utenteRepo.getUserGroupId();
    if (_idGruppo != null)
      {
        fetchPartecipanti();
      }
  }


  Future<void> creaGruppo() async {
    String? username = await _utenteRepo.getCurrentUsername();
    try {
      if(username != null) {
        Gruppo nuovoGruppo = Gruppo(
          partecipanti: [username],
          listaSpesa: [],
          contatti: {},
        );
        _idGruppo = await _gruppoRepo.creaGruppo(nuovoGruppo);
        if (_idGruppo != null) {
          await _utenteRepo.setIdGruppo(_idGruppo!);
          fetchPartecipanti();
        } else {
          throw Exception('Errore nella creazione del gruppo: ID gruppo nullo');
        }
      }
        }
    catch(e)
    {
      throw Exception('Errore durante la creazione del grupponel viewModel: $e');
    }
  }

  void dispose()
  {
    super.dispose();
    _partecipantiController.close();
  }
}
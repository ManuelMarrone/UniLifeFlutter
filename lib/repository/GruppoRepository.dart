import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/Gruppo.dart';


class GruppoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> creaGruppo(Gruppo gruppo) async {
    try {
      DocumentReference docRef = await _firestore.collection('gruppi').add(gruppo.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Errore durante la creazione del gruppo: $e');
    }
  }

  Future<DocumentSnapshot> getGruppo(String idGruppo) async {
    try {
      DocumentReference docRef = _firestore.collection('gruppi').doc(idGruppo);
      DocumentSnapshot docSnapshot = await docRef.get();
      return docSnapshot;
    } catch (e) {
      throw Exception('Errore durante il recupero del gruppo: $e');
    }
  }


  Future<void> eliminaPartecipante(String idGruppo, String username) async {
    DocumentReference gruppoDocRef = _firestore.collection("gruppi").doc(idGruppo);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot gruppoSnapshot = await transaction.get(gruppoDocRef);

      if (gruppoSnapshot.exists) {
        List<String> partecipanti = List.from(gruppoSnapshot["partecipanti"]);
        partecipanti.remove(username);
        transaction.update(gruppoDocRef, {"partecipanti": partecipanti});

        if(partecipanti.isEmpty)
          {
            eliminaGruppo(idGruppo);
          }

      } else {
        throw Exception("Il gruppo con ID $idGruppo non esiste.");
      }
    });
  }

  Future<void> aggiungiPartecipante(String username, String idGruppo) async {
    try {
      DocumentReference docRef = _firestore.collection('gruppi').doc(idGruppo);
      await docRef.update({
        "partecipanti": FieldValue.arrayUnion([username])
      });
    } catch (e) {
      throw Exception('Errore durante l\'aggiunta del partecipante: $e');
    }
  }

  Future<void> aggiungiElementoLista(String elemento, String idGruppo) async {
    try {
      print(idGruppo);
      DocumentReference docRef = _firestore.collection('gruppi').doc(idGruppo);
      await docRef.update({
        "listaSpesa": FieldValue.arrayUnion([elemento])
      });
    } catch (e) {
      throw Exception('Errore durante l\'aggiunta dell\'elemento in lista: $e');
    }
  }

  Future<void> eliminaElementoLista(String idGruppo, String elemento) async {
    DocumentReference gruppoDocRef = _firestore.collection("gruppi").doc(idGruppo);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot gruppoSnapshot = await transaction.get(gruppoDocRef);

      if (gruppoSnapshot.exists) {
        List<String> lista = List.from(gruppoSnapshot["listaSpesa"]);
        lista.remove(elemento);
        transaction.update(gruppoDocRef, {"listaSpesa": lista});

      } else {
        throw Exception("Il gruppo con ID $idGruppo non esiste.");
      }
    });
  }


  Future<void> eliminaGruppo(String idGruppo) async {
    try {
      await _firestore.collection('gruppi').doc(idGruppo).delete();
    } catch (e) {
      throw Exception('Errore durante l\'eliminazione del gruppo: $e');
    }
  }


  Future<void> getIdGruppo(Gruppo gruppo) async {
    try {
      await _firestore.collection('gruppi').add(gruppo.toMap());
    } catch (e) {
      throw Exception('Errore durante la creazione del gruppo: $e');
    }
  }

  Future<Stream<List<String>>> getPartecipanti(String gruppoId) async {
    final partecipantiStreamController = StreamController<List<String>>();
    final DocumentReference gruppoDocRef = FirebaseFirestore.instance.collection('gruppi').doc(gruppoId);

    try {
      final DocumentSnapshot gruppoDocSnapshot = await gruppoDocRef.get();
      if (gruppoDocSnapshot.exists) {
        final Map<String, dynamic>? data = gruppoDocSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data['partecipanti'] != null) {
          final List<String> partecipanti = List<String>.from(data['partecipanti'] as List<dynamic>);
          partecipantiStreamController.add(partecipanti);
        } else {
          throw Exception('Il campo "partecipanti" non è presente nel documento o è null');
        }
      } else {
        throw Exception('Il documento del gruppo non esiste');
      }
    } catch (e) {
      partecipantiStreamController.addError(e);
    }

    return partecipantiStreamController.stream;
  }



  Future<Stream<List<String>>> getListaSpesa(String gruppoId) async {
    final listaStreamController = StreamController<List<String>>();
    final DocumentReference gruppoDocRef = FirebaseFirestore.instance.collection('gruppi').doc(gruppoId);

    try {
      final DocumentSnapshot gruppoDocSnapshot = await gruppoDocRef.get();
      if (gruppoDocSnapshot.exists) {
        final Map<String, dynamic>? data = gruppoDocSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data['listaSpesa'] != null) {
          final List<String> elementi = List<String>.from(data['listaSpesa'] as List<dynamic>);
          listaStreamController.add(elementi);
        } else {
          throw Exception('Il campo "listaSpesa" non è presente nel documento o è null');
        }
      } else {
        throw Exception('Il documento del gruppo non esiste');
      }
    } catch (e) {
      listaStreamController.addError(e);
    }

    return listaStreamController.stream;
  }
}

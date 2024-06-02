import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/Utente.dart';

class UtenteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getUserGroupId() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('utenti').doc(user.uid).get();
      return userDoc['id_gruppo'];
    }
    return null;
  }

  Future<String?> getCurrentUsername() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('utenti').doc(user.uid).get();
      return userDoc['username'];
    }
    return null;
  }

  Future<void> eliminaIdGruppo(String username) async {
    QuerySnapshot querySnapshot = await _firestore.collection("utenti").where("username", isEqualTo: username).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      //ottieni l'ID del documento
      String documentId = documentSnapshot.id;

      //aggiorna il documento utente impostando a null il campo id_gruppo
      await _firestore.collection("utenti").doc(documentId).update({
        "id_gruppo": null,
      });
    } else {
      //nel caso in cui non venga trovato alcun utente con l'username specificato
      throw Exception("Nessun utente trovato con l'username $username");
    }
  }

  Future<void> setIdGruppo(String? id) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('utenti').doc(user.uid).update({'id_gruppo': id});
      } catch (e) {
        throw Exception('Errore durante l\'aggiornamento del gruppo dell\'utente: $e');
      }
    } else {
      throw Exception('Utente non autenticato');
    }
  }

  Future<void> creaUtente(Utente utente) async {
    try {
      var uid = _auth.currentUser?.uid;
      if (uid != null) {
        await _firestore.collection('utenti').doc(uid).set(utente.toMap());
      } else {
        throw Exception('Utente non autenticato');
      }
    } catch (e) {
      throw Exception('Errore durante la creazione dell\'utente: $e');
    }
  }

  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        Utente nuovoUtente = Utente(
          id_gruppo: null,
          username: username,
          email: email,
          password: password,
        );
        await creaUtente(nuovoUtente);

        return true;
      }
      else
        {
          return false;
        }
    } catch (e) {
      print('Errore durante la registrazione: $e');
      return false;
    }
  }

  Future<bool> isEmailUnique(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('utenti').where('email', isEqualTo: email).get();
      return querySnapshot.docs.isEmpty;
    } catch (e) {
      print('Errore durante il controllo dell\'univocità dell\'email: $e');
      return false;
    }
  }

  Future<bool> isUsernameUnique(String username) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('utenti').where('username', isEqualTo: username).get();
      return querySnapshot.docs.isEmpty;
    } catch (e) {
      print('Errore durante il controllo dell\'univocità dello username: $e');
      return false;
    }
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/Utente.dart';

class UtenteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

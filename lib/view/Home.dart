import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unilife_flutter/view/AccessoPage.dart';
import 'package:unilife_flutter/viewmodel/HomeViewModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key:key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Homeviewmodel();

    //ascolta il cambiamenti nell'autenticazione
    homeViewModel.authStateChanges.listen((User? user) {
      if (user == null) {
        //l'utente si è disconesso
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AccessoPage()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UniLife',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(onPressed: () async{
            await homeViewModel.disconetti();
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'elemento da comprare',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Aggiungi l'azione del pulsante "Aggiungi" qui
              },
              child: Text('Aggiungi'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Numero di elementi nella lista
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Elemento $index'),
                    // Aggiungi altre proprietà o azioni per gli elementi della lista
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
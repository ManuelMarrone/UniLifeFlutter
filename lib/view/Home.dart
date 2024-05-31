import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key:key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //late HomeViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UniLife',
          textAlign: TextAlign.center,
        ),
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unilife_flutter/view/AccessoPage.dart';
import 'package:unilife_flutter/viewmodel/HomeViewModel.dart';
import '../provider/gruppo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _codiceController = TextEditingController();
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    _initializeGruppo();
  }

  Future<void> _initializeGruppo() async {
    bool isGruppo = await _viewModel.controllaIdGruppo();
    context.read<GruppoListener>().setHasGruppo(isGruppo);
    if (context.read<GruppoListener>().hasGruppo) {
      /// fetch della lista della spesa
    }
  }

  @override
  Widget build(BuildContext context) {
    //ascolta il cambiamenti nell'autenticazione
    _viewModel.authStateChanges.listen((User? user) {
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
          IconButton(
            onPressed: () async {
              await _viewModel.disconetti();
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: context.watch<GruppoListener>().hasGruppo
          ? _buildHasGruppoWidget()
          : _buildNoGruppoWidget(),
    );
  }

  Widget _buildHasGruppoWidget() {
    return Center(
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
    );
  }

  Widget _buildNoGruppoWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Non appartieni a nessun gruppo di coinquilini :( \n '
                'Inserisci il codice per unirti al gruppo',
          ),
          TextField(
            controller: _codiceController,
            decoration: InputDecoration(
              hintText: 'codice',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // logica per partecipare ad un gruppo
              String codice = _codiceController.text;

              if (codice.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Inserisci il codice')),
                );
              } else {
                bool result = await _viewModel.accettaInvito(codice);
                if (result) {
                  _codiceController.clear();
                  FocusScope.of(context).unfocus();
                  context.read<GruppoListener>().setHasGruppo(true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Codice non valido')),
                  );
                }
              }
            },
            child: Text('Conferma'),
          ),
          const Text(
            'Oppure crea un gruppo cliccando sul +',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _codiceController.dispose();
    super.dispose();
  }
}

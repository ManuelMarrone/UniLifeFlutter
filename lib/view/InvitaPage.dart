import 'package:flutter/material.dart';

class Invitapage extends StatefulWidget {
  const Invitapage({Key? key});

  @override
  State<Invitapage> createState() => _InvitapageState();
}

class _InvitapageState extends State<Invitapage> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UniLife',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Partecipanti gruppo",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text("Partecipante 1"),
                ),
                ListTile(
                  title: Text("Partecipante 2"),
                ),
                ListTile(
                  title: Text("Partecipante 3"),
                ),
                // Aggiungi altre voci della lista se necessario
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Invita nuovo coinquilino",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Logica per inviare l'invito
              String email = _emailController.text;
              // Esegui azione per inviare l'invito con l'email specificata
            },
            child: Text("Invita"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}

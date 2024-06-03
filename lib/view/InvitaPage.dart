import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unilife_flutter/provider/gruppo.dart';
import '../viewmodel/InvitaViewModel.dart';

class Invitapage extends StatefulWidget {
  const Invitapage({Key? key});

  @override
  State<Invitapage> createState() => _InvitapageState();
}

class _InvitapageState extends State<Invitapage> {
  TextEditingController _emailController = TextEditingController();

  final InvitaViewModel _viewModel = InvitaViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UniLife',
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            if (!context.watch<GruppoListener>().hasGruppo) ...[
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    //creazione del gruppo con l'utente
                    _viewModel.creaGruppo();
                    context.read<GruppoListener>().setHasGruppo(true);
                  },
                  child: const Text('Crea gruppo'),
                ),
              )

            ] else ...[
              const Text(
                "Partecipanti gruppo",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              StreamBuilder<List<String>>(
                stream: _viewModel.partecipanti,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final partecipanti = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: partecipanti.length,
                      itemBuilder: (context, index) {
                        final partecipante = partecipanti[index];
                        return ListTile(
                          title: Text(partecipante),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              _viewModel.eliminaPartecipante(partecipante);

                              //se l'utente si sta togliendo da solo da l gruppo cambio lo stato
                              if (await _viewModel.checkUsername(partecipante))
                                {
                                  context.read<GruppoListener>().setHasGruppo(false);
                                }
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('Non ci sono partecipanti al gruppo'));
                  }
                },
              ),
              SizedBox(height: 191),
              const Text(
                "Invita nuovo coinquilino",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  String email = _emailController.text;
                  String? emailError = _viewModel.validateEmail(email);

                  if (emailError != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(emailError)),
                    );
                  }
                  else
                  {
                    _viewModel.invita(email);
                    _emailController.clear();
                    FocusScope.of(context).unfocus();
                  }
                },
                child: Text("Invita"),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}

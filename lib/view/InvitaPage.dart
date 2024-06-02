import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:unilife_flutter/repository/UtenteRepository.dart';
import '../viewmodel/InvitaViewModel.dart';

class Invitapage extends StatefulWidget {
  const Invitapage({Key? key});

  @override
  State<Invitapage> createState() => _InvitapageState();
}

class _InvitapageState extends State<Invitapage> {
  TextEditingController _emailController = TextEditingController();

  late InvitaViewModel _viewModel;
  bool _hasGroup = false;

  @override
  void initState() {
    super.initState();
    _viewModel = InvitaViewModel();
    _viewModel.caricaIdGruppo();
    _viewModel.addListener(_onViewModelChanged);
    if (_hasGroup)
      {
        _viewModel.fetchPartecipanti();
        print("ViewModel changed: ${_viewModel.idGruppo}");
      }
  }

  void _onViewModelChanged() {
    _viewModel.fetchPartecipanti();
    setState(() {
      _hasGroup = _viewModel.idGruppo != null;
    });
  }

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
            if (!_hasGroup) ...[
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    //creazione del gruppo con l'utente
                    _viewModel.creaGruppo();
                    setState(() {
                      _hasGroup = true;
                    });
                    _viewModel.fetchPartecipanti();
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
                            onPressed: () {
                              _viewModel.eliminaPartecipante(partecipante);
                              _viewModel.fetchPartecipanti();
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
                decoration: InputDecoration(
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
    _viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }
}

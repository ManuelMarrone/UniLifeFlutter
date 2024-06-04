import 'package:flutter/material.dart';
import 'package:unilife_flutter/view/AccessoPage.dart';
import 'package:unilife_flutter/viewmodel/RegistrazioneViewModel.dart';

class Registrazionepage extends StatefulWidget {
  const Registrazionepage({super.key});

  @override
  State<Registrazionepage> createState() => _RegistrazionepageState();
}

class _RegistrazionepageState extends State<Registrazionepage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registrazioneViewModel = RegistrazioneViewModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrazione'),
        backgroundColor: Color(0xFF00629E),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF03C9A9), Color(0xFF16A085)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _username,
                decoration: InputDecoration(
                  labelText: 'username',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'email',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'password',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String? usernameError = registrazioneViewModel.validateUsername(_username.text);
                  String? emailError = registrazioneViewModel.validateEmail(_email.text);
                  String? passwordError = registrazioneViewModel.validatePassword(_password.text);

                  bool usernameUnique = await registrazioneViewModel.isUsernameUnique(_username.text);
                  bool emailUnique = await registrazioneViewModel.isEmailUnique(_email.text);

                  if (!usernameUnique) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Username già esistente")),
                    );
                    return;
                  }
                  if (!emailUnique) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Email già esistente")),
                    );
                    return;
                  }

                  if (usernameError != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(usernameError)),
                    );
                    return;
                  }

                  if (emailError != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(emailError)),
                    );
                    return;
                  }

                  if (passwordError != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(passwordError)),
                    );
                    return;
                  }

                  // Tutti i campi sono corretti, procedi con la registrazione
                  registrazioneViewModel.registra(
                    _email.text,
                    _password.text,
                    _username.text,
                  );

                  if (await registrazioneViewModel.result) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AccessoPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Registrazione fallita')),
                    );
                  }
                },
                child: Text('Registrati'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AccessoPage()),
                  );
                },
                child: Text('Già sei registrato? Accedi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

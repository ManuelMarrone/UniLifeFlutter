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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _username,
              decoration: InputDecoration(label: Text('username')),
            ),
            TextField(
              controller: _email,
              decoration: InputDecoration(label: Text('email')),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(label: Text('password')),
            ),
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
                    SnackBar(content: Text('Registrazione fallito')),
                  );                }
              },
              child: Text('Registrati'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:unilife_flutter/view/RegistrazionePage.dart';
import 'package:unilife_flutter/viewmodel/AccessoViewModel.dart';

import 'BottomNavigation.dart';

class AccessoPage extends StatefulWidget {
  const AccessoPage({super.key});

  @override
  State<AccessoPage> createState() => _AccessoPageState();
}

class _AccessoPageState extends State<AccessoPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final accessoViewModel = Accessoviewmodel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accesso'),
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
                  await accessoViewModel.accedi(_email.text, _password.text);
                  if (await accessoViewModel.result) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavigation()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login fallito')),
                    );
                  }
                },
                child: Text('Accedi'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Registrazionepage()),
                  );
                },
                child: Text('Non hai un account? Registrati'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}

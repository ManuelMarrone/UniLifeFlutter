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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(label: Text('email')),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(label: Text('password')),
            ),
            ElevatedButton(onPressed: () async{
              await accessoViewModel.accedi(_email.text, _password.text);
              if(await accessoViewModel.result)
                {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavigation()),
                  );
                }
              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login fallito')),
                  );
                }
            }, child: Text('Accedi')),
            TextButton(onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Registrazionepage()),
              );
            }, child: Text('Non hai un account? Registrati'))
          ],
        ),
      ),
    );
  }
}

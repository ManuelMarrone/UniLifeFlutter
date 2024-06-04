import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unilife_flutter/provider/gruppo.dart';
import 'package:unilife_flutter/repository/auth.dart';
import 'package:unilife_flutter/view/AccessoPage.dart';
import 'package:unilife_flutter/view/BottomNavigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// tutto ciò che c'è nel main viene letto all'inizio
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // tutti i widget sotto l'app possono accedere al provider
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GruppoListener())],
    child: UniLife(),
  ));
}

class UniLife extends StatelessWidget {
  const UniLife({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.black, // Imposta il colore principale su nero
          secondary: Colors.black,
          surface: Colors.white,
          error: Colors.black,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xFF1082D5), // Imposta il colore di sfondo degli ElevatedButton
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white, // Imposta il colore del testo degli ElevatedButton
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Color(0xFF91EAC5),
        ),
      ),
      home: StreamBuilder(
        // lo stream builder prende uno stream di dati continuo, al contrario del future che lo prende una volta sola
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomNavigation();
          } else {
            return AccessoPage();
          }
        },
      ),
    );
  }
}

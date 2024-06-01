import 'package:flutter/material.dart';
import 'package:unilife_flutter/repository/auth.dart';
import 'package:unilife_flutter/view/AccessoPage.dart';
import 'package:unilife_flutter/view/BottomNavigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


//tutto ciò che c'è nel main viene letto all'inizio
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(UniLife());
}
class UniLife extends StatelessWidget {
  const UniLife({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(//lo stream builder prende uno stream di dati continuo, al contratio del future che lo prende una volta sola
      stream: Auth().authStateChanges,
        builder: (context, snapshot){
        if(snapshot.hasData){
          return BottomNavigation();
        }
        else
          {
            return AccessoPage();
          }
        },

      ),
    );
  }
}

//
// //senza stato
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override  //la funzione costruisce "build" il widget
//   Widget build(BuildContext context) {
//     return MaterialApp(    //ambiente material design
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
// //con stato, permette di salvare uno stato
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title}); //costruttore
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title; //attributo della classe
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// //stato del widget
// class _MyHomePageState extends State<MyHomePage> { //estende lo stato di MyHomePage
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {  //setta lo stato aumentando il counter, che viene passato al widget e lo stampa a schermo
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   //costruzione del widget
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(       //torna lo scaffold, da visibilita all'app
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),  //prende il titolo del wigdet al quale fa riferimento
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',   //fa riferimento al valore del counter
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,  //onPressed si attiva quando il button viene cliccato
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),   //icona
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

/**
 *
 *
 * alt+invio per comandi rapidi
 *
 * crtl+s per hot reload
 *
 * widget: può essere una cosa fisica come una cosa che vediamo a schermo, ma anche una cosa più astratta come ad  esempio lo
scaffold, la column

    widget tree, hai widget dentro altri widget, il numero di figli varia
material app->scaffold->->->


    Scaffold
    Il widget principale di layout che contiene un’intera schermata. Una
    volta inserito, occupa tutto lo spazio disponibile dello schermo.
    Lo Scaffold ha specifiche proprietà per definire, tra gli altri:
    ● La AppBar (appbar)
    ● Il corpo (body)
    ● Una BottomNavigationBar (bottomNavigationBar)
    ● Un navigation Drawer (drawer)
    Normalmente non occorre definire Scaffold annidati

    definizione di bottomnav:
    Corrisponde al bottom navigation su Material Design, e consente di
    mostrare un numero limitato di item (icone con o senza testo) per
    navigare tra le top-level views di un’applicazione
    18
    BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
    ),
    BottomNavigationBarItem(...),
    BottomNavigationBarItem(...)],
    currentIndex: _selectedIndex,
    selectedItemColor: Colors.amber[800],
    onTap: _onItemTapped,
    )

    Se il numero di opzioni è fino a 4, allora il type verrà settato di
    default a BottomNavigationBar.fixed, altrimenti a
    BottomNavigationBar.shifted (cambia lo stile di base e quando si
    clicca l’icona viene ingrandita leggermente e viene mostrato il
    valore del campo label del BottomNavigationBarItem cliccato)


    https://learn.univpm.it/mod/resource/view.php?id=531694
 **/

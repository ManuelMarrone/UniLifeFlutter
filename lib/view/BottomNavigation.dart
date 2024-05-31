import 'package:flutter/material.dart';
import 'package:unilife_flutter/view/Home.dart';
import 'package:unilife_flutter/view/InvitaPage.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  final pagine = [
    Home(),
    Invitapage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pagine[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF364B45),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add,
                    color: Colors.white),
                label: 'Invita'
            ),
          ],
        selectedItemColor: Colors.white,
      ),
    );
  }
}
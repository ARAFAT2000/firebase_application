import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screen/noticeScreen.dart';
import '../screen/notice_board.dart';
import '../screen/profile_screen.dart';
import '../screen/show_sreen.dart';
import '../screen/write_screen.dart';


class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    ShowScreen(),
    NoticeBoard(),
    WriteScreen(),
    NoticeScreen(),
    ProfileScreen()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orangeAccent,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black87,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.circle_notifications_outlined),
            label: 'Notice',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.quickreply),
            label: 'Exam Notice ',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.add_circle_outline_rounded),
            label: 'Send ',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.edit_calendar_outlined),
            label: 'Exam',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.person_pin),
            label: 'Profile',
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BottomNavbar(),
    theme: ThemeData(
      primarySwatch: Colors.orange,
    ),
  ));
}





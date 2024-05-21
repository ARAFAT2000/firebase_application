


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../screen/add_screen.dart';
import '../screen/home_screen.dart';
import '../screen/profile_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final controller= PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      AddScreen(),
      UserProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> __naveBaritem() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add,color: Colors.white,),
        title: ("Add"),
        activeColorPrimary: CupertinoColors.destructiveRed,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_4),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: controller,
      context,
      screens: _buildScreens(),
      items: __naveBaritem(),

      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(1),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}

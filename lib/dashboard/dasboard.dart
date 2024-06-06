//
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../screen/NoticeScreen.dart';
// import '../screen/add_screen.dart';
// import '../screen/home_screen.dart';
//
// import '../screen/notice_board.dart';
// import '../screen/profile_screen.dart';
//
// class DashBoard extends StatefulWidget {
//
//
//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }
//
// class _DashBoardState extends State<DashBoard> {
//   final controller= PersistentTabController(initialIndex: 0);
//
//   List<Widget> _buildScreens() {
//     return [
//       NoticeBoard(),
//       //HomeScreen(),
//      // AddScreen(),
//       NoticeScreen(),
//       ProfileScreen(),
//     ];
//   }
//
//   List<PersistentBottomNavBarItem> __naveBaritem() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.border_all),
//         title: ("Notice Board"),
//         activeColorPrimary: CupertinoColors.activeBlue,
//         inactiveColorPrimary: CupertinoColors.systemGrey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.notifications_active_outlined,color: Colors.white,),
//         title: ("Notice"),
//         activeColorPrimary: CupertinoColors.activeBlue,
//         inactiveColorPrimary: CupertinoColors.systemGrey,
//       ),
//
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.person_4),
//         title: ("Profile"),
//         activeColorPrimary: CupertinoColors.activeBlue,
//         inactiveColorPrimary: CupertinoColors.systemGrey,
//       ),
//
//     ];
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       controller: controller,
//       context,
//       screens: _buildScreens(),
//       items: __naveBaritem(),
//
//       decoration: NavBarDecoration(
//         borderRadius: BorderRadius.circular(1),
//       ),
//       navBarStyle: NavBarStyle.style15,
//     );
//   }
// }

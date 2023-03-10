import 'package:cha_sa_jo_flutter/model/tabbar.dart';

import 'package:cha_sa_jo_flutter/view/board/boardpage.dart';
import 'package:cha_sa_jo_flutter/view/carList.dart';
import 'package:cha_sa_jo_flutter/view/chatting/chat_screen.dart';
import 'package:cha_sa_jo_flutter/view/chatting/chatting.dart';
import 'package:cha_sa_jo_flutter/view/login/login_screen.dart';
import 'package:cha_sa_jo_flutter/view/login/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.tabIndex});
  final tabIndex;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late PersistentTabController controller;
  RxBool _isLightTheme = true.obs;
  bool darkMode = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = PersistentTabController(initialIndex: widget.tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            // ObxValue(
            //   (data) => Switch(
            //     value: _isLightTheme.value,
            //     onChanged: (val) {
            //       _isLightTheme.value = val;
            //       Get.changeThemeMode(
            //         _isLightTheme.value ? ThemeMode.light : ThemeMode.dark,
            //       );
            //       // _saveThemeStatus();
            //     },
            //   ),
            //   false.obs,
            // ),
            // SizedBox(
            //   width: 10,
            // ),
            darkMode
                ? IconButton(
                    onPressed: () {
                      _isLightTheme.value = true;
                      Get.changeThemeMode(
                        _isLightTheme.value ? ThemeMode.light : ThemeMode.dark,
                      );
                      setState(() {
                        darkMode = false;
                      });
                    },
                    icon: Icon(Icons.dark_mode_outlined),
                  )
                : IconButton(
                    onPressed: () {
                      _isLightTheme.value = false;
                      Get.changeThemeMode(
                        _isLightTheme.value ? ThemeMode.light : ThemeMode.dark,
                      );
                      setState(() {
                        darkMode = true;
                      });
                    },
                    icon: Icon(Icons.light_mode_outlined),
                  ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(LoginScreen());

                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        elevation: 0,
      ),
      body: PersistentTabView(
        context,
        screens: [
          carList(),
          BoardPage(),
          ChatScreen(),
        ],
        controller: controller,
        items: _navBarsItems(),
        backgroundColor: _isLightTheme.isTrue
            ? Colors.white
            : Color.fromARGB(255, 76, 76, 76),
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.car),
        title: ("Search Car"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.groups),
        title: ("Board"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.chat_bubble_2_fill),
        title: ("Chat"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}

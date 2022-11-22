import 'package:alltalk_translate/home_page.dart';
import 'package:alltalk_translate/widgets/zoom_drawer/zoom_drawer_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ZoomDrawerScreen extends StatefulWidget {
  const ZoomDrawerScreen({super.key});

  @override
  State<ZoomDrawerScreen> createState() => _ZoomDrawerScreenState();
}

class _ZoomDrawerScreenState extends State<ZoomDrawerScreen> {
  @override
  Widget build(BuildContext context) {
    final _drawerController = ZoomDrawerController();

    return Scaffold(
      body: ZoomDrawer(
        isRtl: false,
        moveMenuScreen: false,
        androidCloseOnBackTap: true,
        mainScreenTapClose: true,
        controller: _drawerController,
        menuScreen: const ZoomDrawerMenuScreen(),
        mainScreen: const HomePage(),
        menuBackgroundColor: Colors.grey.withOpacity(0.2),
        borderRadius: 20.0,
        showShadow: false,
        //menuScreenWidth: double.infinity,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
        angle: 0.0,
        //openCurve: Curves.fastOutSlowIn,
        // closeCurve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 400),
      ),
    );
  }
}

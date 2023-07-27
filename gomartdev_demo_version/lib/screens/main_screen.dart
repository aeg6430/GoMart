import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drawer_screen_provider.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*drawer: const DrawerMenu(),*/
      backgroundColor: Colors.white,
      body: Container(
        child: context.watch<DrawerScreenProvider>().currentScreen,
      ),
    );
  }
}

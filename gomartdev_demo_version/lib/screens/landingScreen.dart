import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/drawer_screen_provider.dart';
import 'main_screen.dart';

class landingPage extends StatefulWidget{
  landingPage({Key? key,}) : super(key: key);


  @override
  stateLandingPage createState() => stateLandingPage();
}

class stateLandingPage extends State<landingPage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => DrawerScreenProvider(),
          ),
        ],
        child: const MainScreen(),
      )
    );
  }
}
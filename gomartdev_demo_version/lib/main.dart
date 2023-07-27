import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gomartdev/providers/drawer_screen_provider.dart';
import 'package:gomartdev/screens/landingScreen.dart';
import 'package:gomartdev/screens/loginPage.dart';
import 'package:gomartdev/screens/main_screen.dart';
import 'package:gomartdev/screens/registerPage.dart';
import 'package:provider/provider.dart';

import 'GraphQLConfig/GraphQLConfig.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp>  {








  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Go Mart Admin Dashboard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        /*home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Controller(),)
        ],
        child: DashBoardScreen(),
      ),*/
        /* home: ChangeNotifierProvider(
        create: (context) => DrawerScreenProvider(),
        child: const MainScreen(),
      ),*/
        /*home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => DrawerScreenProvider(),
            ),
          ],
          child: const MainScreen(),
        )*/




      //home: loginPage(),

      home:StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              User? user = snapshot.data;
              if (user == null) {
                print('No Account');
                return registerPage();
              }else{
                print('Account Actived');
                return loginPage();
              }
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
      routes: <String, WidgetBuilder>{
        '/_': (BuildContext context) => new landingPage(),
        '/login': (BuildContext context) => new loginPage(),
        '/register': (BuildContext context) => new registerPage(),
      },

    );



  }
}


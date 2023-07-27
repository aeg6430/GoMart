import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class stateRegisterPageWidget extends StatefulWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPageWidget();
  }
}

class RegisterPageWidget extends State<stateRegisterPageWidget> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordcheck = TextEditingController();

  @override
  void dispose() {
    userName.dispose();
    email.dispose();
    password.dispose();
    passwordcheck.dispose();
    super.dispose();
  }

  bool agree = false;

  @override
  Widget build(BuildContext context) {
    child: TextField(
      controller: userName,//controll 用戶
    );//TextField
    child: TextField(
      controller: email,//controll 信箱
    );//TextField
    child: TextField(
      controller: password,//controll 密碼
    );//TextField
    child: TextField(
      controller: passwordcheck,//controll 密碼確認
    );//TextField

    Future signUp() async
    {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        ).then((value) {
          setState(() {
            agree = false;


          });

        });
      } catch (e) {
        print("error occured $e");
      }
    }
    // TODO: implement build
    throw UnimplementedError();
  }
}

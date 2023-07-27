/*
*  reset_password_page_widget.dart
*  GoMartClient
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class stateResetPasswordPageWidget extends StatefulWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResetPasswordPageWidget();
  }
}






class ResetPasswordPageWidget extends State<stateResetPasswordPageWidget> {


  TextEditingController emailController = TextEditingController();



  bool isPressed = false;
  int tapCounter=0;






  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: new MaterialApp(
            debugShowCheckedModeBanner: false,
            home: new Scaffold( resizeToAvoidBottomInset:false,
              body:Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                    Container(
                      child: Text(
                        "重設密碼",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: "Noto Sans",
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: isPressed?
                        Text(
                          "我們已寄送電子郵件至"+emailController.text+"\n若未收到信件請至垃圾郵件查看",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Noto Sans",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ):Text(
                          "輸入您的註冊帳號使用的電子郵件我們將寄送電子郵件至您的信箱以重設密碼",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Noto Sans",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        )
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.75,
                      child: isPressed?SizedBox():
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          String email = emailController.text;
                          final bool isValid = EmailValidator.validate(email);
                          if (value == null || value.isEmpty) {   // Validation Logic
                            return '請輸入您的電子郵件';
                          }
                          else if (isValid!=true) {   // Validation Logic
                            return '請輸入有效的電子郵件';
                          }
                          return null;
                        },
                        cursorColor:Color.fromARGB(255, 245, 85, 85),
                        decoration:const InputDecoration(
                            hintText: "輸入電子郵件",
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(103, 40, 40, 40)),),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(103, 40, 40, 40)),),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 245, 85, 85),))
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(255, 31, 31, 31),
                          fontFamily: "Noto Sans",
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        autocorrect: false,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.75,
                        height:MediaQuery.of(context).size.height*0.0025,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 229, 229, 229).withOpacity(0.3),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isPressed?Container(
                              width: MediaQuery.of(context).size.width*0.75,
                              height:MediaQuery.of(context).size.height*0.0025,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 245, 85, 85),
                              ),
                            ):
                            Container(
                              width: MediaQuery.of(context).size.width*0.375,
                              height:MediaQuery.of(context).size.height*0.0025,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 245, 85, 85),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                    Align(alignment: Alignment.center,
                        child: Container(
                            width: MediaQuery.of(context).size.width*0.35,
                            height: MediaQuery.of(context).size.height*0.05,
                            alignment:Alignment.center,
                            child: OutlinedButton(style: OutlinedButton.styleFrom(
                                backgroundColor:Color.fromARGB(255, 245, 85, 85),shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),) ),
                              child: isPressed?Text('前往查看', style: TextStyle(
                                fontSize: 19.5,
                                color: Colors.white,
                                fontFamily: "Noto Sans",
                                //fontWeight: FontWeight.w400,
                              ),):
                              Text('下一步', style: TextStyle(
                                fontSize: 19.5,
                                color: Colors.white,
                                fontFamily: "Noto Sans",
                                //fontWeight: FontWeight.w400,
                              ),),

                              onPressed: () async{
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    tapCounter++;
                                    if(tapCounter %2==1)
                                    {
                                      isPressed=!isPressed;
                                    }
                                    else
                                    {
                                      redirect();
                                      redirectToMailAPP();
                                    }
                                  });
                                  resetPassword();
                                }
                              },
                            )
                        )
                    )
                  ],
                ),
              ),
            )
        )
    );



  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
          email: emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }


  Future redirect() async {
    try {

      Timer(Duration(seconds:2), () async {
        var nav = await {
          Navigator.of(context).pushNamed('/routerLandingPage')
        };
        if(nav==true||nav==null)
        {Navigator.of(context).pushNamedAndRemoveUntil('/routerLoginPage',(Route<dynamic>route)=>false);}
      });
    }  catch (e) {
      print(e);
    }
  }


  Future redirectToMailAPP() async {
    try{
      Timer(Duration(seconds:1), () async {
        await LaunchApp.openApp(
          androidPackageName: 'com.google.android.gm',
          iosUrlScheme: 'message://',
          appStoreLink: 'itms-apps://itunes.apple.com/us/app/mail/id1108187098',
          openStore: false
        );
      });
    }
    catch (e){
      print(e);
    }
  }



}
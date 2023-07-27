/*
*  login_page_widget.dart
*  GoMartClient
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_mart_client/global.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../GraphQLConfig/GraphQLConfig.dart';


class stateLoginPageWidget extends StatefulWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageWidget();
  }
}




class LoginPageWidget extends State<stateLoginPageWidget>{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool checkboxValue=false;


  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  String  memberMuntation="""
  mutation addModel(\$memberID:String!) {
  insert_Memeber(objects: {memberID: \$memberID}) {
    returning {
      memberID
    }
  }
}""";


  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GraphQLConfiguration.client,
      child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: new MaterialApp(
            debugShowCheckedModeBanner: false,
            home: new Scaffold(
              resizeToAvoidBottomInset:false,
              body: Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Container(
                      child: Text(
                        "登入",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: "Noto Sans",
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.75,
                      height:MediaQuery.of(context).size.height*0.05,
                      child: Row(
                        children: [
                          Text(
                            "沒有帳號嗎?",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "Noto Sans",
                              fontWeight: FontWeight.w600,
                              fontSize: 14.25,
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: TextButton(
                              onPressed: () async{
                                var nav = await Navigator.of(context).pushNamed('/routerRegisterPage');
                                if(nav==true||nav==null)
                                {Navigator.of(context).pushNamedAndRemoveUntil('/routerLandingPage',(Route<dynamic>route)=>false);
                                }
                              },
                              child: Expanded(child: Text(
                                "註冊一個新帳號",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 88, 127, 255),
                                  fontFamily: "Noto Sans",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),),

                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.75,
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          String email = emailController.text;
                          final bool isValid = EmailValidator.validate(email);
                          if (value == null || value.isEmpty) {   // Validation Logic
                            return '請輸入您的電子郵件';
                          }
                          else if (isValid!=true) {   // Validation Logic
                            return '請輸入有效的電子郵件格式';
                          }
                          /*else if(checkIfEmailInUse() ==false){
                          return '輸入的電子郵件尚未註冊';
                        }*/
                          return null;
                        },
                        cursorColor:Color.fromARGB(255, 245, 85, 85),
                        decoration:const InputDecoration(
                            hintText: "電子郵件",
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
                    SizedBox(height: MediaQuery.of(context).size.height*0.005,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.75,
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {   // Validation Logic
                            return '請輸入您的密碼';
                          }
                          /*else if(checkIfPasswordCorrect() ==false){
                          return '輸入的密碼錯誤';
                        }*/
                          return null;
                        },
                        obscureText: true,
                        cursorColor:Color.fromARGB(255, 245, 85, 85),
                        decoration:const InputDecoration(
                          hintText: "密碼",
                          border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(103, 40, 40, 40)),),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(103, 40, 40, 40)),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 245, 85, 85),)),
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
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          width: MediaQuery.of(context).size.width*0.35,
                          height: MediaQuery.of(context).size.height*0.05,
                          child: Container(
                              width: MediaQuery.of(context).size.width*0.15,
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: OutlinedButton(style: OutlinedButton.styleFrom(
                                  backgroundColor:Color.fromARGB(255, 245, 85, 85).withOpacity(0.9),
                                  shape:RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),) ),
                                child: Text('登入', style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: "Noto Sans",
                                  fontWeight: FontWeight.w400,
                                ),),
                                onPressed: () async{
                                  // debugPrint(FirebaseAuth.instance.currentUser.uid.toString());
                                  if (_formKey.currentState.validate()) {
                                    _signInUser();

                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    bool firstTime = prefs.getBool('first_time');
                                    if (firstTime != null && !firstTime) {
                                      var nav = await Navigator.of(context).pushNamed('/routerPageCTRL');
                                      if(nav==true||nav==null){
                                        Navigator.of(context).pushNamedAndRemoveUntil('/routerPageCTRL',(Route<dynamic>route)=>false);
                                      }
                                    }
                                    else {
                                      prefs.setBool('first_time', false);
                                      var nav = await Navigator.of(context).pushNamed('/routerSurveyPage');
                                      if(nav==true||nav==null){
                                        Navigator.of(context).pushNamedAndRemoveUntil('/routerPageCTRL',(Route<dynamic>route)=>false);
                                      }
                                    }
                                  }
                                },
                              )
                          )
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.75,
                      child: Row(
                        children: [
                          Expanded(
                              child: Divider(
                                color: Colors.black54.withOpacity(0.3),
                                thickness: 1.5,
                              )
                          ),
                          TextButton(
                            child: Text(
                              "忘記密碼",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 61, 61, 61),
                                fontFamily: "Noto Sans",
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                              ),
                            ),

                            onPressed: () async{


                              debugPrint('Email:' + emailController.text);
                              debugPrint('Password:' + passwordController.text);


                              var nav = await Navigator.of(context).pushNamed('/routerResetPasswordPage');
                              if(nav==true||nav==null)
                              {Navigator.of(context).pushNamedAndRemoveUntil('/routerLoginPage',(Route<dynamic>route)=>false);
                              }

                            },
                          ),
                          Expanded(
                              child: Divider(
                                color: Colors.black54.withOpacity(0.3),
                                thickness: 1.5,)
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
      )
    );
  }
  Future _signInUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (e) {
      print(e);
    }
  }
}
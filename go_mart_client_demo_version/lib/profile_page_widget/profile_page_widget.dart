/*
*  member_pages_widget.dart
*  GoMartClient
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_mart_client/values/values.dart';
import 'package:provider/provider.dart';

import '../register_page_widget/register_page_widget.dart';

class stateProfilePageWidget extends StatefulWidget{




  @override
  Widget build(BuildContext context) {
    return new MaterialApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfilePageWidget();
  }
}
class ProfilePageWidget extends State<stateProfilePageWidget>with AutomaticKeepAliveClientMixin {

  @override
  // implement wantKeepAlive
  bool get wantKeepAlive => true;

  bool isEnabled = true;
  int tapCounter=1;
  bool isPressed = false;



  TextEditingController userNameController = TextEditingController(text: FirebaseAuth.instance.currentUser.displayName);
  TextEditingController emailController = TextEditingController(text: FirebaseAuth.instance.currentUser.email);
  TextEditingController passwordController = TextEditingController(text: '*******');

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomInset:false,
            appBar:AppBar(
              backgroundColor:Color.fromARGB(255, 253, 141, 126),
              elevation: 0,
              title: Center(
                  child: Text("個人資料",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Noto Sans",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  )
              ),
            ),
              body: Container(
                  //constraints: BoxConstraints.expand(),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child:SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.8,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.white.withOpacity(0.2),
                                  Colors.white.withOpacity(0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24.0),
                                topLeft: Radius.circular(24.0),
                              )
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  child:  Image.asset(
                                    "assets/images/logos.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.9,
                                        height: MediaQuery.of(context).size.height*0.075,
                                        color: Colors.white,
                                        child:TextField(
                                          controller: userNameController,
                                          readOnly: isEnabled,
                                          cursorColor:Color.fromARGB(255, 245, 85, 85),
                                          decoration: InputDecoration(
                                              labelText: "用戶名稱",
                                              contentPadding: EdgeInsets.all(5),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),),
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Color.fromARGB(255, 245, 85, 85),)),
                                              suffix: TextButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    isPressed=!isPressed;
                                                    tapCounter++;
                                                    if(tapCounter %2==0){
                                                      debugPrint("編輯");
                                                      isEnabled = false;
                                                    }
                                                    else{
                                                      debugPrint("儲存");
                                                      isEnabled = true;
                                                      FirebaseAuth.instance.currentUser.updateDisplayName(userNameController.text);
                                                      debugPrint("New Password: "+userNameController.text);
                                                    }
                                                  });
                                                },
                                                child: isPressed?Text('儲存'):Text('編輯'),
                                              )
                                          ),
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 31, 31, 31),
                                            fontFamily: "Noto Sans",
                                            fontSize: 13,
                                          ),
                                          maxLines: 1,
                                          autocorrect: false,
                                        ),
                                      ),
                                      SizedBox(height: 11),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.9,
                                        height: MediaQuery.of(context).size.height*0.075,
                                        color: Colors.white,
                                        child: TextField(
                                          controller: emailController,
                                          enabled: false,
                                          cursorColor:Color.fromARGB(255, 245, 85, 85),
                                          decoration: InputDecoration(
                                              labelText: '電子郵件',
                                              contentPadding: EdgeInsets.all(5),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),),
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Color.fromARGB(255, 245, 85, 85),)),
                                          ),
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 31, 31, 31),
                                            fontFamily: "Noto Sans",
                                            fontSize: 13,
                                          ),
                                          maxLines: 1,
                                          autocorrect: false,
                                        ),
                                      ),
                                      SizedBox(height: 11),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.9,
                                        height: MediaQuery.of(context).size.height*0.075,
                                        color: Colors.white,
                                        child: TextField(
                                          controller: passwordController,
                                          readOnly: isEnabled,
                                          obscureText: true,
                                          cursorColor:Color.fromARGB(255, 245, 85, 85),
                                          decoration: InputDecoration(
                                              labelText: "密碼",
                                              contentPadding: EdgeInsets.all(5),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),),
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Color.fromARGB(255, 245, 85, 85),)),
                                            suffix: TextButton(
                                              onPressed: () async {
                                                setState(() {
                                                  isPressed=!isPressed;
                                                  tapCounter++;
                                                  if(tapCounter %2==0){
                                                    debugPrint("編輯");
                                                    isEnabled = false;
                                                  }
                                                  else{
                                                    debugPrint("儲存");
                                                    isEnabled = true;
                                                    FirebaseAuth.instance.currentUser.updatePassword(passwordController.text);
                                                    debugPrint("New Password: "+passwordController.text);
                                                  }
                                                });
                                              },
                                              child: isPressed?Text('儲存'):Text('編輯'),
                                            )
                                          ),
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 31, 31, 31),
                                            fontFamily: "Noto Sans",
                                            fontSize: 13,
                                          ),
                                          maxLines: 1,
                                          autocorrect: false,
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              ),
          );
  }
}
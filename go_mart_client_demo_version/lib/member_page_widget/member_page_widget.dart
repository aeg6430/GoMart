/*
*  member_pages_widget.dart
*  GoMartClient
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_mart_client/icomoon_icons.dart';
import 'package:go_mart_client/landing_page_widget/landing_page_widget.dart';
import 'package:go_mart_client/privacy_policy_show_page_widget/privacy_policy_show_page_widget.dart';
import 'package:go_mart_client/profile_page_widget/profile_page_widget.dart';
import 'package:go_mart_client/setting_area_notification_page_widget/setting_area_notification_page_widget.dart';
import 'package:go_mart_client/values/values.dart';
import 'package:go_mart_client/custom_icon_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restart_app/restart_app.dart';

class stateMemberPageWidget extends StatefulWidget{
  const stateMemberPageWidget({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return  CupertinoApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MemberPageWidget();
  }
}
class MemberPageWidget extends State<stateMemberPageWidget> with AutomaticKeepAliveClientMixin{
  @override
  // implement wantKeepAlive
  bool get wantKeepAlive => true;
  
  @override
  Widget build(BuildContext context)=>CupertinoPageScaffold (
   child:SafeArea(
      child:Scaffold(
        appBar:AppBar(
          backgroundColor:Color.fromARGB(255, 253, 141, 126),
          elevation: 0,
          title: Center(
              child: Text("會員中心",
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
          constraints: BoxConstraints.expand(),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        child:  Image.asset(
                          "assets/images/logos.png",
                          fit: BoxFit.cover,),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.075,
                        color: Colors.white,
                        child: Row(
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Icon(Icons.account_box_rounded,
                              size: 35,color:Color.fromARGB(255, 253, 141, 126),),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Text('個人資料',
                              style: TextStyle(
                                  fontFamily: "Noto Sans",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color:Colors.black54.withOpacity(0.5)
                              ),
                            ),

                          ],
                        ),
                      ),
                      onTap: () async {
                        Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(
                                builder: (context)=>stateProfilePageWidget()
                            ),(Route<dynamic>route)=>true
                        );
                      },
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height*0.005),
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.075,
                        color: Colors.white,
                        child: Row(
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Icon(Icomoon.bot,
                              size: 35,color:Color.fromARGB(255, 253, 141, 126),),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Text('管理購物小幫手',
                              style: TextStyle(
                                  fontFamily: "Noto Sans",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color:Colors.black54.withOpacity(0.5)
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: ()=>Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                              builder: (context)=>stateSettingAreaNotificationPageWidget()
                          ),(Route<dynamic>route)=>true
                      ),
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height*0.005),
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.075,
                        color: Colors.white,
                        child: Row(
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Icon(Icons.privacy_tip_rounded,
                              size: 35,color:Color.fromARGB(255, 253, 141, 126),),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Text('隱私使用政策',
                              style: TextStyle(
                                  fontFamily: "Noto Sans",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color:Colors.black54.withOpacity(0.5)
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: ()=>Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                              builder: (context)=>statePrivacyPolicyShowPageWidget()
                          ),(Route<dynamic>route)=>true
                      ),
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height*0.005),
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.075,
                        color: Colors.white,
                        child: Row(
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Icon(Icons.logout,
                              size: 35,color:Color.fromARGB(255, 253, 141, 126),),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Text('登出',
                              style: TextStyle(
                                  fontFamily: "Noto Sans",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color:Colors.black54.withOpacity(0.5)
                              ),
                            ),

                          ],
                        ),
                      ),
                      onTap: ()async{
                            FirebaseAuth.instance.signOut();
                            deleteCache();
                            deleteStorage();
                            Timer(
                                Duration(milliseconds: 300),
                                    () {
                                      Restart.restartApp();
                                    }
                            );

                      }
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height*0.005),
                  ],
                ),

              )
            ],
          )
        ),
      )
    )
    );
  Future<void> deleteCache() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<void> deleteStorage() async {
    final appDir = await getApplicationSupportDirectory();

    if(appDir.existsSync()){
      appDir.deleteSync(recursive: true);
    }
  }
}
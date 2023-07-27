/*
*  landing_page_widget.dart
*  GoMartClient
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_mart_client/login_page_widget/login_page_widget.dart';
import 'package:go_mart_client/login_page_widget/login_page_widget.dart';

class stateLandingPageWidget extends StatefulWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp( );
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LandingPageWidget();
  }
}




class LandingPageWidget extends State<stateLandingPageWidget> {

  @override
  Widget build(BuildContext context) =>
      CupertinoPageScaffold(

          child: SafeArea(
              child: Scaffold(
                body: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 253, 141, 126),
                          Color.fromARGB(255, 254, 195, 128),
                        ],
                      )
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 516,
                        margin: EdgeInsets.only(top: 242),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 2),
                                child: Column(children: [

                                  Text(
                                    "GoMart",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Helvetica Now',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 35,
                                      height: 0.87273,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "購物趣",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Noto Sans',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 37,
                                      height: 0.87273,
                                    ),
                                  ),
                                ]
                                  ,)
                            ),
                            /*Container(
                              margin: EdgeInsets.only(top: 56),
                              child: Text(
                                "讓購物變有趣\n",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Noto Sans',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 19,
                                ),
                              ),

                            ),*/
                            SizedBox(height: MediaQuery.of(context).size.height*0.25),
                            Column(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: 55,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 245, 85, 85),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                            bottomLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                        )

                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                        '註冊',
                                        style: TextStyle(
                                          fontFamily: 'Noto Sans',
                                          fontSize: 20,
                                          color: Colors.white
                                        )
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        '/routerRegisterPage');
                                  },
                                ),
                                SizedBox(height: 15),
                                GestureDetector(
                                  child: Container(
                                    height: 55,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                        )

                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '登入',
                                      style: TextStyle(
                                        fontFamily: 'Noto Sans',
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 245, 85, 85),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        '/routerLoginPage');
                                  },
                                ),

                              ],
                            )


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
          )

      );
}

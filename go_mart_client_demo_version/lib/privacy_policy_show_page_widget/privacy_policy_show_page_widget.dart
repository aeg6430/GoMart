/*
*  privacy_policy_show_page_widget.dart
*  GoMartClient
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:pdfx/pdfx.dart';


class statePrivacyPolicyShowPageWidget extends StatefulWidget{




  @override
  Widget build(BuildContext context) {
    return new MaterialApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PrivacyPolicyShowPageWidget();
  }
}
class PrivacyPolicyShowPageWidget extends State<statePrivacyPolicyShowPageWidget> {
   String privacyPolicyData;






  void _loadData() async {
    final _loadedData = await rootBundle.loadString('assets/txtFile/privacyPolicy.txt');
    setState(() {
      privacyPolicyData = _loadedData;
    });
  }
  @override
  void initState() {
    super.initState();
    _loadData();



  }








  @override
  Widget build(BuildContext context)=>CupertinoPageScaffold (
    child:Scaffold(
      appBar:AppBar(
        backgroundColor:Color.fromARGB(255, 253, 141, 126),
        elevation: 0,
        title: Center(
            child: Text("隱私使用政策",
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
        child:  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.5),
                ],
              ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: 384,
                  child: Text(
                    privacyPolicyData ?? 'showPrivacyPolicyData',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                  ),




                ),
              ],
            ),
          ),
        ),
      ),
    )
  );
}
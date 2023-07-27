/*
*  privacy_policy_page_widget.dart
*  GoMartClient
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:go_mart_client/values/values.dart';
Future<String> loadAsset(BuildContext context) async {
  return await DefaultAssetBundle.of(context).loadString('assets/privacyPolicy.txt');
}
class statePrivacyPolicyPageWidget extends StatefulWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PrivacyPolicyPageWidget();
  }
}

class PrivacyPolicyPageWidget extends State<statePrivacyPolicyPageWidget> {
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
  Widget build(BuildContext context) {
  
    return Scaffold(
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
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width*0.98,
                height: MediaQuery.of(context).size.height*0.8,
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    privacyPolicyData ?? 'showPrivacyPolicyData',

                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        width: MediaQuery.of(context).size.width*0.35,
                        height: MediaQuery.of(context).size.height*0.05,
                        child: OutlinedButton(style: OutlinedButton.styleFrom(
                            backgroundColor:Color.fromARGB(255, 253, 141, 126),
                            shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),) ),
                          child: Text('確認', style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: "Noto Sans",
                            fontWeight: FontWeight.w400,
                          ),),
                          onPressed:() async{
                            var nav = await Navigator.of(context).pushNamed('/routerRegisterPage');
                            if(nav==true||nav==null)
                            {Navigator.of(context).pushNamedAndRemoveUntil('/routerRegisterPage',(Route<dynamic>route)=>false);
                            }
                          },
                        )
                    ),
                  ),





          ],
        ),
      ),
    );
  }
}
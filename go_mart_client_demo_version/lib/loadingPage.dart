
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_mart_client/product_Content/productContent.dart';

class stateLoadingPageWidget extends StatefulWidget{
  const stateLoadingPageWidget({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return  CupertinoApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoadingPageWidget();
  }
}
class LoadingPageWidget extends State<stateLoadingPageWidget> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    Timer(Duration(seconds: 1), (){
      Navigator.pushReplacement(context, CupertinoPageRoute(
          builder: (context)=>stateProductContent()
      ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context)=>CupertinoPageScaffold (
      child:SafeArea(
          child:Scaffold(
            body: Container(
                constraints: BoxConstraints.expand(),
              child: SpinKitPouringHourGlassRefined(
               color: Color.fromARGB(255, 253, 141, 126),
                  size: 50.0,
              ),

            ),
          )
      )
  );
}
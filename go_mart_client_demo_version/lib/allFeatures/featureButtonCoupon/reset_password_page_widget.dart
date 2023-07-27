/*
*  reset_password_page_widget.dart
*  GoMartClient
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/couponList.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/couponRedeem.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/couponRedeemVerify.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/verify_code_page_widget.dart';
import 'package:go_mart_client/home_page_widget/home_page_widget.dart';
import 'package:go_mart_client/values/values.dart';

class stateCouponRedeemVerifyResetPasswordPageWidget extends StatefulWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CouponRedeemVerifyResetPasswordPageWidget();
  }
}
class CouponRedeemVerifyResetPasswordPageWidget extends State<stateCouponRedeemVerifyResetPasswordPageWidget> {
  
  void onBtnFinishPressed(BuildContext context) {
  
  }
  
  @override
  Widget build(BuildContext context) =>CupertinoPageScaffold(
      child: Scaffold(
        resizeToAvoidBottomInset:false,
        appBar:AppBar(
          backgroundColor:Color.fromARGB(255, 253, 141, 126),
          elevation: 0,
          title: Center(
              child: Text("我的折價券",
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
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height*0.75,
          constraints: BoxConstraints.expand(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child:Container(
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height*0.75,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                      Container(
                        child: Text(
                          "忘記密碼",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Noto Sans",
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                      Container(
                        width: MediaQuery.of(context).size.width*0.75,
                        height:MediaQuery.of(context).size.height*0.05,
                        child: TextField(
                          cursorColor:Color.fromARGB(255, 245, 85, 85),
                          decoration:const InputDecoration(
                              hintText: "輸入新密碼",
                              contentPadding: EdgeInsets.all(5),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(103, 40, 40, 40)),),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromARGB(255, 245, 85, 85),))
                          ),
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 31, 31),
                            fontFamily: "Noto Sans",
                            fontWeight: FontWeight.w200,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          autocorrect: false,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                      Container(
                        width: MediaQuery.of(context).size.width*0.75,
                        height:MediaQuery.of(context).size.height*0.05,
                        child: TextField(
                          cursorColor:Color.fromARGB(255, 245, 85, 85),
                          decoration:const InputDecoration(
                              hintText: "再次輸入新密碼",
                              contentPadding: EdgeInsets.all(5),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(103, 40, 40, 40)),),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromARGB(255, 245, 85, 85),))
                          ),
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 31, 31),
                            fontFamily: "Noto Sans",
                            fontWeight: FontWeight.w200,
                            fontSize: 13,
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
                              Container(
                                width: MediaQuery.of(context).size.width*0.75,
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
                                borderRadius: BorderRadius.circular(30),) ),
                                child: Text('完成', style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: "Noto Sans",
                                  fontWeight: FontWeight.w400,
                                ),),
                                  onPressed:() async {


                                   var nav = await Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (context)=>stateHomePageWidget()
                                        )
                                    );
                                   if(nav==true||nav==null){
                                      Navigator.of(context).pushAndRemoveUntil(
                                          CupertinoPageRoute(
                                              builder: (context)=>stateHomePageWidget()
                                          ), (Route<dynamic>route)=>true
                                      );
                                    }
                                  }
                              )
                          )
                      )
                    ],
                  ),

                ),
              ),
            ],
          ),
        ),
      )
  );

}
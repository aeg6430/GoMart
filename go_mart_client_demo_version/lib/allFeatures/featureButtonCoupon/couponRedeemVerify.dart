import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/couponList.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/couponRedeem.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/forget_password_page_widget.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
class couponRedeemVerify extends StatefulWidget{
  const couponRedeemVerify({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    return stateCouponRedeemVerify();
  }
}
class stateCouponRedeemVerify  extends State<couponRedeemVerify> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController passwordController = new TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool _canCheckBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),
    );
  }
  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(()  {
        _isAuthenticating = true;
        _authorized = '開啟生物辨識';
        debugPrint('Biometric Authentication: ON');
      });
      authenticated = await auth.authenticate(
        localizedReason: '進行生物辨識開啟功能',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: '需進行生物辨識\n以繼續操作',
            cancelButton: '取消辨識',
          ),
          IOSAuthMessages(
            cancelButton: '取消辨識',
          ),
        ],
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs:false,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        debugPrint('Biometric Authentication: OFF');
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
            () async {
              if(authenticated){
                debugPrint('Biometric Authentication Verification: Success');


                var nav = await Navigator.of(context).push(
                    CupertinoPageRoute(
                        builder: (context)=>stateCouponRedeem()
                    )
                );
                if(nav==true||nav==null){
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                          builder: (context)=>stateCouponListWidget()
                      ), (Route<dynamic>route)=>true
                  );
                }

              }
              else
                {
                  debugPrint('Biometric Authentication Verification: Failed');
                }
             }
    );
  }
  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }




  @override
  Widget build(BuildContext context) =>CupertinoPageScaffold(

    child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset : false,
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
            body:  SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child:Container(
               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height,
               child: ListView(
                padding: const EdgeInsets.only(top: 30),
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Align(
                      alignment: Alignment.center,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          Text('折價券已受密碼保護',
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: "Noto Sans",
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                          Text('折價券被鎖在保險箱裡了!',
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Noto Sans",
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                          Container(
                          width: MediaQuery.of(context).size.width*0.35,
                          height:MediaQuery.of(context).size.height*0.05,
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            cursorColor: Color.fromARGB(255, 245, 85, 85),
                            style: TextStyle(
                              color: Color.fromARGB(255, 31, 31, 31),
                              fontFamily: "Noto Sans",
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            autocorrect: false,
                            decoration: InputDecoration(
                                hintText: "密碼",
                                contentPadding: EdgeInsets.all(5),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromARGB(
                                      103, 40, 40, 40)),),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 245, 85, 85),)),
                                suffixIcon:IconButton(
                                    icon: Icon(
                                      Icons.send_rounded,
                                      color: Color.fromARGB(255, 245, 85, 85)
                                    ),
                                    onPressed: () async {
                                      log("${passwordController.text}");
                                      Navigator.of(context).pushAndRemoveUntil(
                                          CupertinoPageRoute(
                                              builder: (context)=>stateCouponRedeem()
                                          ),(Route<dynamic>route)=>true
                                      );
                                    }
                                )
                            ),
                            onSubmitted: (String value) {
                              log("${value}");
                            },
                          ),
                        ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
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
                              onPressed:() async {
                                Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                      builder: (context)=>stateCouponRedeem()
                                  ),(Route<dynamic>route)=>true
                                );
                              }
                        ),

                          if (_isAuthenticating==true)
                          (
                            TextButton(
                                child: Text(
                                  "取消生物辨識",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 61, 61, 61),
                                    fontFamily: "Noto Sans",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              onPressed: ()async{
                                _cancelAuthentication;
                              }
                            )
                          )
                          else(
                            TextButton(
                                child: Text(
                                  "進行生物辨識",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 61, 61, 61),
                                    fontFamily: "Noto Sans",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                                onPressed:() async {
                                  _authenticate();
                                 }
                              )
                          )
                          ],
                         ),
                        )
                       ),
                    ]
                   )
                  ]
                )
               )
              )
           )
    )
  );

}
enum _SupportState {
  unknown,
  supported,
  unsupported,
}
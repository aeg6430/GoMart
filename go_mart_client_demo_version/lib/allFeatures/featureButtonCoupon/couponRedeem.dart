
import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:uuid/uuid.dart';

import '../../GraphQLConfig/GraphQLConfig.dart';
import '../../global.dart';

class stateCouponRedeem extends StatefulWidget{
  const stateCouponRedeem({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CouponRedeem();
  }
}
class CouponRedeem extends State<stateCouponRedeem> with AutomaticKeepAliveClientMixin{
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
            /*startTimer();*/
            _controller.start();
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
  bool showText = false;
 /* Timer _timer;
  int _time = 300;*/

  /*void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_time == 0) {
        } else {
          setState(() {
            _time--;
          });
        }
      },
    );
  }*/


  final int _duration = 150;
  final CountDownController _controller = CountDownController();

  bool _clicked = false;




  @override
  Widget build(BuildContext context) =>CupertinoPageScaffold(

    child: GraphQLProvider(
      client: GraphQLConfiguration.client,
      child: SafeArea(
          child: Scaffold(
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
              body:  Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          color: Colors.white.withOpacity(0.9),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 4,
                              blurRadius: 6,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height*0.25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(discountBrandName,
                                    style: TextStyle
                                      (color: Colors.black54,
                                        fontSize: 30),
                                  ),
                                  Text(discountModelName,
                                    style: TextStyle
                                      (color: Colors.black54,
                                        fontSize: 18),
                                  ),
                                  Text(discountValue+"折",
                                    style: TextStyle
                                      (color: Colors.black54,
                                        fontSize: 40),
                                  ),
                                  Text("效期: 2022/11/20",
                                    style: TextStyle
                                      (color: Colors.black54,
                                        fontSize: 15),
                                  ),
                                ],
                              )
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.08,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(100),
                                      bottomRight: Radius.circular(100),
                                    ),
                                    color: Colors.black12.withOpacity(0.025),
                                    shape: BoxShape.rectangle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: Offset(0, 0.1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: MediaQuery.of(context).size.height*0.051,
                                  width: MediaQuery.of(context).size.width*0.06,
                                ),
                                Dash(
                                    direction: Axis.horizontal,
                                    length: MediaQuery.of(context).size.height*0.3,
                                    dashLength: 8,
                                    dashColor: Colors.black12,
                                    dashThickness:3.5
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      bottomLeft: Radius.circular(100),
                                    ),
                                    color: Colors.black12.withOpacity(0.025),
                                    shape: BoxShape.rectangle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: Offset(0, 0.1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: MediaQuery.of(context).size.height*0.051,
                                  width: MediaQuery.of(context).size.width*0.06,
                                ),

                              ],
                            ),
                            showText ? Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height*0.05,
                              width: MediaQuery.of(context).size.width*0.5,
                              color: Colors.white,
                              child: Text(Uuid().v4().substring(0,16),
                                style: TextStyle(
                                  fontFamily: 'Noto Sans',
                                  fontSize: 10,
                                  color: Colors.black54.withOpacity(0.5),
                                ),),
                            ):
                            Container(
                              height: MediaQuery.of(context).size.height*0.05,
                              width: MediaQuery.of(context).size.width*0.5,
                              color: Colors.white,
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                            GestureDetector(
                                child:Container(
                                    width: MediaQuery.of(context).size.width*0.35,
                                    height: MediaQuery.of(context).size.height*0.05,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 245, 85, 85).withOpacity(0.9),
                                        borderRadius: BorderRadius.all(Radius.circular(90))

                                    ),
                                    alignment:Alignment.center,
                                    child: Text('兌換',
                                      style: TextStyle(
                                        fontFamily: 'Noto Sans',
                                        fontSize: 20,
                                        color: Colors.black54.withOpacity(0.5),
                                      ),
                                    )
                                ),
                                onLongPress:_clicked ? null:(){
                                  debugPrint("Pressed");
                                  setState((){
                                    _clicked = true;
                                    showText = !showText;
                                    if (_isAuthenticating==false)
                                    {
                                      _authenticate();
                                    };
                                  }
                                  );
                                }
                            ),
                            showText ? Column(
                              children: [
                                CircularCountDownTimer(
                                  duration: _duration,
                                  initialDuration: 0,
                                  controller: _controller,
                                  width: MediaQuery.of(context).size.width / 9,
                                  height: MediaQuery.of(context).size.height / 9,
                                  ringColor: Colors.grey.withOpacity(0.5),
                                  ringGradient: null,
                                  fillColor: Color.fromARGB(255, 252, 146, 152),
                                  fillGradient: null,
                                  backgroundColor:Color.fromARGB(255, 245, 85, 85).withOpacity(0.9),
                                  backgroundGradient: null,
                                  strokeWidth: 10.0,
                                  strokeCap: StrokeCap.round,
                                  textStyle: const TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textFormat: CountdownTextFormat.S,
                                  isReverse: true,
                                  isReverseAnimation: false,
                                  isTimerTextShown: true,
                                ),
                                Text('剩餘時間',
                                  style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 10,
                                    color: Colors.black54.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ):
                            Text('請於結帳時至結帳櫃檯使用',
                              style: TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 10,
                                color: Colors.black54.withOpacity(0.5),
                              ),
                            ),
                          ],
                        )
                    ),
                  )
              )
          )
      ),
    )
  );
}
enum _SupportState {
  unknown,
  supported,
  unsupported,
}
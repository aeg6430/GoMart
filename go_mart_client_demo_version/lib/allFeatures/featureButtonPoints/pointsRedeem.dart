
import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:uuid/uuid.dart';

class statePointsRedeem extends StatefulWidget{
  const statePointsRedeem({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PointsRedeem();
  }
}


class PointsRedeem extends State<statePointsRedeem> with AutomaticKeepAliveClientMixin{
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
            log("${pointsController.text}");
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


  final int _duration = 300;
  final CountDownController _controller = CountDownController();

  bool _clicked = false;
  final TextEditingController pointsController = new TextEditingController();




  @override
  Widget build(BuildContext context) =>CupertinoPageScaffold(

    child: SafeArea(
        child: Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Align(
                    alignment: Alignment.center,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                        new Image(
                          image: new AssetImage("assets/images/points.png"),
                          height: MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.width*0.5,
                          color: null,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                        showText ? Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height*0.05,
                          width: MediaQuery.of(context).size.width*0.5,
                         // color: Colors.black12,
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
                          /*color: Colors.black54.withOpacity(0.5),*/
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          height:MediaQuery.of(context).size.height*0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                                color: Color.fromARGB(255, 245, 85, 85),
                                width: 1.0,
                                style: BorderStyle.solid
                            ),
                          ),
                          child: Center(
                            child: TextField(
                              controller: pointsController,
                              cursorColor: Color.fromARGB(255, 245, 85, 85),
                              style: TextStyle(
                                color: Color.fromARGB(255, 31, 31, 31),
                                fontFamily: "Noto Sans",
                                fontSize: 13,
                              ),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              autocorrect: false,
                              decoration: InputDecoration(
                                  hintText: "輸入折抵點數",
                                  contentPadding: EdgeInsets.all(5),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(
                                        color: Colors.white
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(
                                          color: Colors.white
                                      )
                                  ),
                              ),
                              onSubmitted: (String value) {
                                log("${value}");
                              },
                            ),
                          )
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
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
                            /*onLongPress:_clicked ? null:(){
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
                            }*/
                        ),
                        showText ? Column(
                          children: [
                            CircularCountDownTimer(
                              duration: _duration,
                              initialDuration: 0,
                              controller: _controller,
                              width: MediaQuery.of(context).size.width / 9,
                              height: MediaQuery.of(context).size.height / 9,
                              ringColor: Colors.grey[300],
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
                        Text(''/*'長按2秒 請於結帳時至結帳櫃檯使用'*/,
                          style: TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 10,
                            color: Colors.black54.withOpacity(0.5),
                          ),
                        ),
                      ],
                    )
                )
             ),
            )
        )
  );
}
enum _SupportState {
  unknown,
  supported,
  unsupported,
}

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gomartdev/screens/main_screen.dart';
import 'package:http/http.dart';

import '../constants/constants.dart';

class loginPage extends StatefulWidget{
  loginPage({Key? key,}) : super(key: key);


  @override
  stateLoginPage createState() => stateLoginPage();
}

class stateLoginPage extends State<loginPage>{



  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }








  late User auth;
  bool login = false;
  Map errors = {'account':null, 'password':null, 'other':null };

  final _formKey = GlobalKey<FormState>();










  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                            Container(
                              child: Text(
                                "登入",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Noto Sans",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30,
                                    color: Colors.black54
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: MediaQuery.of(context).size.height * 0.05,
                                child: Row(
                                  children: [
                                    Text(
                                      "沒有帳號?",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "Noto Sans",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.18,),
                                    TextButton(
                                      onPressed: () async {
                                        var nav = await Navigator.of(context)
                                            .pushNamed('/register');
                                        if (nav == true || nav == null) {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                              '/_', (
                                              Route<dynamic>route) => false);
                                        }
                                      },
                                      child: Text(
                                        "註冊",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 88, 127, 255),
                                          fontFamily: "Noto Sans",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.05,),

                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            String email = emailController.text;
                            final bool isValid = EmailValidator.validate(email);



                            if (value == null || value.isEmpty) {   // Validation Logic
                              return '請輸入您的電子郵件';
                            }
                            else if (isValid!=true) {   // Validation Logic
                              return '請輸入有效的電子郵件格式';
                            }
                            /*else if(checkIfEmailInUse() ==true){
                        return '輸入的電子郵件已被使用';
                      }*/
                            return null;
                          },
                          cursorColor:Color.fromARGB(255, 245, 85, 85),
                          decoration:const InputDecoration(
                              hintText: "電子郵件",
                              border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(103, 40, 40, 40)),),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(103, 40, 40, 40)),),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromARGB(255, 245, 85, 85),))
                          ),
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 31, 31),
                            fontFamily: "Noto Sans",
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          autocorrect: false,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.005,),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {   // Validation Logic
                              return '請輸入您的密碼 密碼需6個字以上';
                            }
                            else if(value.length<6){
                              return '密碼需6個字以上';
                            }
                            return null;
                          },
                          obscureText: true,
                          cursorColor:Color.fromARGB(255, 245, 85, 85),
                          decoration:const InputDecoration(
                            hintText: "密碼",
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(103, 40, 40, 40)),),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(103, 40, 40, 40)),),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 245, 85, 85),)),
                          ),
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 31, 31),
                            fontFamily: "Noto Sans",
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          autocorrect: false,
                          /* inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
                        FilteringTextInputFormatter.allow(RegExp(r'^ ?\d*')),
                        FilteringTextInputFormatter.allow("[0-9]")
                      ]*/
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: OutlinedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0))),
                                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                                  if (states.contains(
                                      MaterialState.disabled)) {
                                    return (
                                        Color.fromRGBO(17, 159, 250, 1).withOpacity(0.3)
                                    ); // Disabled state
                                  }
                                  return Color.fromRGBO(17, 159, 250, 1).withOpacity(0.9); // Enable state
                                }
                                ),
                              ),
                              child: Text(
                                '登入',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: "Noto Sans",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onPressed:(){
                                if (_formKey.currentState!.validate()) {
                                  var nav =Navigator.of(context).pushNamed('/_');
                                  if (nav == true || nav == null) {
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                        '/_', (Route<dynamic>route) => false);
                                  }
                                  signIn();
                                  debugPrint("Pressed");
                                  debugPrint('Email:' + emailController.text);
                                  debugPrint('Password:' + passwordController.text);


                                  /*checkIfEmailInUse();*/





                                }
                              }
                          )
                      ),
                    ],
                  ),
                ),
              )
          ),
        )
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (error) {
      RegExp exp = new RegExp(r'\d{5}');
      var err = exp.firstMatch(error.toString());
      print(error);
      print(err?.group(0));
      setState((){
        if (err?.group(0) == '17011'){
          errors['account'] = "帳號錯誤";
        }
        if (err?.group(0) == '17009'){
          errors['password'] = "密碼錯誤";
        }else{
          errors['other'] = "請再次確認帳號以及密碼";
        }
      });
    }
  }
  Future httpsCall() async {

    // Fetch the currentUser, and then get its id token
    final user = await FirebaseAuth.instance.currentUser;
    final idToken = await user!.getIdToken();
    String token = idToken.toString();

    final header = { "authorization": 'Bearer $token' };

    var url=Uri.parse("http://us-central1-gomart-358609.cloudfunctions.net/httpsFunction");

    get(url, headers: header)
        .then((response) {
      final status = response.statusCode;
      print('STATUS CODE: $status');
    })
        .catchError((e) {
      print(e);
    });
  }





}
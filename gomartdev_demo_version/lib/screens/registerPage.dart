
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gomartdev/screens/main_screen.dart';
import 'package:http/http.dart';

import '../constants/constants.dart';

class registerPage extends StatefulWidget{
  registerPage({Key? key,}) : super(key: key);


  @override
  stateRegisterPage createState() => stateRegisterPage();
}

class stateRegisterPage extends State<registerPage>{


  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();
  @override
  void dispose(){
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordCheckController.dispose();
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
                              "註冊",
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
                                    "已有帳號?",
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
                                          .pushNamed('/login');
                                      if (nav == true || nav == null) {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                            '/_', (
                                            Route<dynamic>route) => false);
                                      }
                                    },

                                      child: Text(
                                        "登入",
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
                        controller: userNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {   // Validation Logic
                            return '請輸入您的用戶名稱';
                          }
                          return null;
                        },
                        cursorColor:Color.fromARGB(255, 245, 85, 85),
                        decoration:const InputDecoration(
                            hintText: "用戶名稱",
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.005,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        controller: passwordCheckController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {   // Validation Logic
                            return '請再次輸入您的密碼';
                          }
                          else if(value!=passwordController.text){
                            return '密碼不相符 請重新輸入';
                          }
                          else if(value!=passwordController.text){
                            return '密碼不相符 請重新輸入';
                          }
                          return null;
                        },
                        obscureText: true,
                        cursorColor:Color.fromARGB(255, 245, 85, 85),
                        decoration:const InputDecoration(
                          hintText: "再次輸入密碼",
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
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
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
                              '註冊',
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
                                signUp();
                                debugPrint("Pressed");
                                debugPrint('UserName:' + userNameController.text);
                                debugPrint('Email:' + emailController.text);
                                debugPrint('Password:' + passwordController.text);
                                debugPrint('PasswordCheck:' + passwordCheckController.text);

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
  /*Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (e) {
      print("error occured $e");
    }
  }*/


  Future signUp() async {
    try {
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      User? user = result.user;
      user?.updateDisplayName(userNameController.text);
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }



  Future httpsCall() async {

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
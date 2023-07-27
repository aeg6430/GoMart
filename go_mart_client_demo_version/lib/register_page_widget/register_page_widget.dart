
import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_mart_client/global.dart';
import 'package:go_mart_client/profile_page_widget/profile_page_widget.dart';
import 'package:provider/provider.dart';


class stateRegisterPageWidget extends StatefulWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPageWidget();
  }
}

class RegisterPageWidget extends State<stateRegisterPageWidget> {
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



  bool _isAcceptTermsAndConditions = false;

  final _formKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {

    return Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
      child:  new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          resizeToAvoidBottomInset: false,

          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
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
                      SizedBox(width: MediaQuery.of(context).size.width * 0.35,),
                      TextButton(
                        onPressed: () async {
                          var nav = await Navigator.of(context)
                              .pushNamed('/routerLoginPage');
                          if (nav == true || nav == null) {
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil(
                                '/routerLandingPage', (
                                Route<dynamic>route) => false);
                          }
                        },
                        child: Expanded(
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
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
                  width: MediaQuery.of(context).size.width * 0.75,
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
                  width: MediaQuery.of(context).size.width * 0.75,
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
                  width: MediaQuery.of(context).size.width * 0.75,
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isAcceptTermsAndConditions,
                        onChanged: (value) {
                          setState(() {
                            _isAcceptTermsAndConditions = value ?? false;
                          });
                        },
                      ),
                      TextButton(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "已詳細閱讀並同意GoMart",
                                style: TextStyle(
                                  color: Color.fromARGB(
                                      255, 0, 0, 0),
                                  fontFamily: "Noto Sans",
                                  fontWeight: FontWeight.w100,
                                  fontSize: 13,
                                )
                            ),
                            TextSpan(
                                text: "隱私使用政策",
                                style: TextStyle(
                                    color: Color.fromARGB(
                                        255, 88, 127, 255),
                                    fontFamily: "Noto Sans",
                                    fontSize: 13,
                                    fontWeight: FontWeight
                                        .bold)),
                          ]),
                        ),


                        onPressed: () async {
                          var nav = await Navigator.of(context)
                              .pushNamed(
                              '/routerPrivacyPolicyPage');
                          if (nav == true || nav == null) {
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil(
                                '/routerLandingPage', (
                                Route<dynamic>route) => false);
                          }
                        },
                      )
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.35,
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
                                  Color.fromARGB(147, 245, 85, 85).withOpacity(0.3)
                              ); // Disabled state
                            }
                            return Color.fromARGB(255, 245, 85, 85).withOpacity(0.9); // Enable state
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
                        onPressed:_isAcceptTermsAndConditions?() {
                          if (_formKey.currentState.validate()) {
                            var nav =Navigator.of(context).pushNamed('/routerLandingPage');
                            if (nav == true || nav == null) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/routerLandingPage', (Route<dynamic>route) => false);
                            }
                            signUp();
                            debugPrint("Pressed");
                            debugPrint('UserName:' + userNameController.text);
                            debugPrint('Email:' + emailController.text);
                            debugPrint('Password:' + passwordController.text);
                            debugPrint('PasswordCheck:' + passwordCheckController.text);

                            /*checkIfEmailInUse();*/




                          }
                        } : null
                    )
                ),
              ],
            ),
          ),
        ),
      )
    );


  }

  /*Future signUp() async
  {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (e) {
      print(e);
    }
  }*/


  Future signUp() async {
    try {
      //UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );

      User user = result.user;
      user.updateDisplayName(userNameController.text);
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}


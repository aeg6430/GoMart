/*
*  main.dart
*  GoMartClient
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/couponList.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/couponRedeemVerify.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/forget_password_page_widget.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/reset_password_page_widget.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/verify_code_page_widget.dart';
import 'package:go_mart_client/landing_page_widget/landing_page_widget.dart';
import 'package:go_mart_client/login_page_widget/login_page_widget.dart';
import 'package:go_mart_client/member_page_widget/member_page_widget.dart';
import 'package:go_mart_client/allFeatures/featureButtonScanner/MobileScanner.dart';
import 'package:go_mart_client/pageCTRL/pageCTRL.dart';
import 'package:go_mart_client/privacy_policy_page_widget/privacy_policy_page_widget.dart';
import 'package:go_mart_client/privacy_policy_show_page_widget/privacy_policy_show_page_widget.dart';
import 'package:go_mart_client/profile_page_widget/profile_page_widget.dart';
import 'package:go_mart_client/register_page_widget/register_page_widget.dart';
import 'package:go_mart_client/reset_password_page_widget/reset_password_page_widget.dart';
import 'package:go_mart_client/searching_page_widget/searching_page_widget.dart';
import 'package:go_mart_client/setting_area_notification_page_widget/setting_area_notification_page_widget.dart';
import 'package:go_mart_client/survey_page_widget/survey_page_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'GraphQLConfig/GraphQLConfig.dart';
import 'allFeatures/featureButtonCoupon/couponRedeem.dart';
import 'firebase_options.dart';
import 'global.dart';
import 'home_page_widget/home_page_widget.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  Firebase.initializeApp();
  runApp(App());
}




class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  
    return GraphQLProvider(
        client: GraphQLConfiguration.client,
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromARGB(255, 253, 141, 126),
          ),
        ),


        home:StreamBuilder<User>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User user = snapshot.data;
                if (user == null) {
                  print('No Account');

                 // print('Now login user UID is '+user.toString());


                 // appUser= user.uid;
                  return stateLandingPageWidget();
                }else{
                  print('Account Actived');
                  print('Current login user UID is '+user.uid);
                  print(user.email);
                  appUserID= user.uid;
                  appUserEmail=user.email;
                  return statePageCTRLWidget();
                }
              } else {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),





        routes: <String, WidgetBuilder>{
          '/routerLandingPage': (BuildContext context) => new stateLandingPageWidget(),
          '/routerLoginPage': (BuildContext context) => new stateLoginPageWidget(),
          '/routerRegisterPage': (BuildContext context) => new stateRegisterPageWidget(),
          '/routerResetPasswordPage': (BuildContext context) => new stateResetPasswordPageWidget(),
          '/routerPrivacyPolicyPage': (BuildContext context) => new statePrivacyPolicyPageWidget(),
          '/routerHomePage': (BuildContext context) => new stateHomePageWidget(),
          '/routerSearchingPage': (BuildContext context) => new stateSearchingPageWidget(),
          '/routerMemberPage': (BuildContext context) => new stateMemberPageWidget(key: null,),
          '/routerProfilePage': (BuildContext context) => new stateProfilePageWidget(),
          '/routerSettingAreaNotificationPage': (BuildContext context) => new stateSettingAreaNotificationPageWidget(key: null,),
          '/routerPrivacyPolicyShowPage': (BuildContext context) => new statePrivacyPolicyShowPageWidget(),
          '/routerMobileScannerPage': (BuildContext context) => new stateMobileScannerWidget(),
          '/routerSurveyPage': (BuildContext context) => new SurveyPageWidget(),
          '/routerPageCTRL': (BuildContext context) => new statePageCTRLWidget(),
          '/routerCouponList': (BuildContext context) => new stateCouponListWidget(),
          '/routerCouponRedeem': (BuildContext context) => new stateCouponRedeem(),
          '/routerCouponRedeemVerify': (BuildContext context) => new couponRedeemVerify(),
          '/routerCouponRedeemVerifyForgetPasswordPage': (BuildContext context) => new stateCouponRedeemVerifyForgetPasswordPageWidget(),
          '/routerCouponRedeemVerifyVerifyCodePage': (BuildContext context) => new stateCouponRedeemVerifyVerifyCodePageWidget(),
          '/routerCouponRedeemVerifyResetPasswordPage': (BuildContext context) => new stateCouponRedeemVerifyResetPasswordPageWidget(),
        },
      )
    );
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';


import '../../providers/drawer_screen_provider.dart';
import '../constants/constants.dart';
import 'drawer_list_tile.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          /*Container(
            padding: EdgeInsets.all(appPadding),
            child: Image.asset("assets/images/logowithtext.png"),
          ),*/
          Container(
            padding: EdgeInsets.all(appPadding),
          ),

         /* DrawerListTile(
              title: 'Dash Board',
              svgSrc: 'assets/icons/Dashboard.svg',
              tap: () {

                Provider.of<DrawerScreenProvider>(context, listen: false)
                    .changeCurrentScreen(CustomScreensEnum.dashBoardScreen);
              }),*/
          DrawerListTile(
              title: '廣告設定',
              svgSrc: 'assets/icons/BlogPost.svg',
              tap: () {
                Provider.of<DrawerScreenProvider>(context, listen: false)
                    .changeCurrentScreen(CustomScreensEnum.ADSettingScreen);
              }),
          DrawerListTile(
              title: '商品資料設定', svgSrc: 'assets/icons/Message.svg',
              tap: () {
                Provider.of<DrawerScreenProvider>(context, listen: false)
                    .changeCurrentScreen(CustomScreensEnum.productDataSettingScreen);
          }),
          DrawerListTile(
              title: '購物小幫手區域設定',
              svgSrc: 'assets/icons/Statistics.svg',
              tap: () {
                Provider.of<DrawerScreenProvider>(context, listen: false)
                    .changeCurrentScreen(CustomScreensEnum.generateSelectAreaSettingScreen);
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
            child: Divider(
              color: grey,
              thickness: 0.2,
            ),
          ),
          DrawerListTile(
              title: '登出',
              svgSrc: 'assets/icons/Logout.svg',
              tap: () {
                Restart.restartApp();
                FirebaseAuth.instance.signOut();
              }),
        ],
      ),
    );
  }
}

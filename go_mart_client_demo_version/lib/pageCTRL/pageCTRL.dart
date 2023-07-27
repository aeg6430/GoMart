import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_mart_client/allFeatures/featureButtonScanner/MobileScanner.dart';
import 'package:go_mart_client/area_notification_page_widget/areaNotification.dart';
import 'package:go_mart_client/home_page_widget/home_page_widget.dart';
import 'package:go_mart_client/member_page_widget/member_page_widget.dart';
import 'package:go_mart_client/product_category_page_widget/productCategory.dart';
import 'package:go_mart_client/setting_area_notification_page_widget/setting_area_notification_page_widget.dart';

import '../icomoon_icons.dart';

class statePageCTRLWidget extends StatefulWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PageCTRLWidget();
  }
}
class PageCTRLWidget extends State<statePageCTRLWidget> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context)=>CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Color.fromARGB(255, 253, 141, 126),

        items: [
          BottomNavigationBarItem(
              label: '首頁',
              icon: Icon(Icons.home_rounded)
          ),
          BottomNavigationBarItem(
              label: '生活誌',
              icon: Icon(Icons.menu_book_rounded)
          ),
          BottomNavigationBarItem(
              label: '掃一掃',
              icon: ImageIcon(
                AssetImage("assets/images/scanner.png"),
                color: null,
              )
          ),
          BottomNavigationBarItem(
              label: '會員中心',
              icon: Icon(Icons.account_box_rounded)
          ),

        ],
      ),
      tabBuilder:(context,index){

        switch(index){
          case 0:
            return CupertinoTabView(
              builder:(context)=>stateHomePageWidget()
            );
          case 1:
            return CupertinoTabView(
                builder:(context)=>stateProductCategory()
            );
          case 2:
            return CupertinoTabView(
                /*builder:(context)=> stateAreaNotificationWidget()*/
                builder:(context)=> stateMobileScannerWidget()
            );
          default:
            return CupertinoTabView(
                builder:(context)=>stateMemberPageWidget(key: null,)
            );
        }
      }
    );
}
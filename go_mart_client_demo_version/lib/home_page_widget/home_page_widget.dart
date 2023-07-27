/*
*  home_page_widget.dart
*  GoMartClient
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/couponList.dart';
import 'package:go_mart_client/allFeatures/featureButtonGames/game.dart';
import 'package:go_mart_client/allFeatures/featureButtonHistory/historyList.dart';
import 'package:go_mart_client/allFeatures/featureButtonMemo/Memo.dart';
import 'package:go_mart_client/allFeatures/featureButtonPoints/featureButtonPoints.dart';
import 'package:go_mart_client/generateAreaSelectItem/generateAreaSelectItem.dart';
import 'package:go_mart_client/searching_page_widget/searching_page_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../GraphQLConfig/GraphQLConfig.dart';
import '../allFeatures/featureButtonCart/cart.dart';
import '../allFeatures/featureButtonScanner/MobileScanner.dart';
import '../global.dart';
import '../product_Content/productContent.dart';

int cartAmount=0;

class stateHomePageWidget extends StatefulWidget{

  @override
  Widget build(BuildContext context) {
    return  CupertinoApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageWidget();
  }
}




final List<String> activityImgList = [
  'assets/images/activity/132305.jpg',
  'assets/images/activity/20160910143635969321_1.jpg',
  'assets/images/activity/d41d8cd98f00b204e980811.jpeg'
];

String  shoppingCart="""
  query getShoppingCart(\$memberID: String!) {
  ShoppingCart_aggregate(where: {memberID: {_eq: \$memberID}}) {
    aggregate {
      count
    }
  }
}""";




class HomePageWidget extends State<stateHomePageWidget> with AutomaticKeepAliveClientMixin{

  @override
  // implement wantKeepAlive
  bool get wantKeepAlive => true;


  final List<Map> SelectItem =
  List.generate(activityImgList.length, (index) => {"id": index, "name": "SelectItem $index"}).toList();
  List<int> selectedIndexList = <int>[];

  Widget build(BuildContext context)=>CupertinoPageScaffold(
      child:GraphQLProvider(
        client: GraphQLConfiguration.client,
        child: SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  SlidingUpPanel(
                      color:Color.fromARGB(255, 253, 141, 126),
                      body: Center(
                        child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child:OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(width: 0.3, color: Colors.white),
                                        backgroundColor:Colors.white,
                                        shape:RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),) ),
                                    onPressed:  ()=>Navigator.of(context,rootNavigator: true).push(
                                        CupertinoPageRoute(
                                            builder: (context)=>stateSearchingPageWidget()
                                        )
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(Icons.search,color: Colors.black54.withOpacity(0.5)),
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Searching",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color:Colors.black54),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                /*Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*0.08,
                              color: Colors.white,
                              child:CarouselSlider(
                                options: CarouselOptions(
                                  aspectRatio: 7.0,
                                  enlargeCenterPage: false,
                                  scrollDirection: Axis.horizontal,
                                  autoPlay: false,
                                ),
                                items: imageSliders,
                              ),
                            ),*/
                                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Wrap(
                                    spacing: 1,
                                    runSpacing: 1,
                                    alignment: WrapAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.15,
                                        height: MediaQuery.of(context).size.height*0.1,
                                        child: GestureDetector(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.black12),
                                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: ImageIcon(AssetImage("assets/images/coupon.png"),
                                                        color:Color.fromARGB(255, 253, 141, 126), size: 30.5,),
                                                    )

                                                ),
                                                Text('我的折價券', style: TextStyle(color: Colors.black54,fontSize: 8,),),
                                              ],
                                            ),
                                            onTap:() async {
                                              var nav = await Navigator.of(context).push(
                                                  CupertinoPageRoute(
                                                      builder: (context)=>stateCouponListWidget()
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
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.15,
                                        height: MediaQuery.of(context).size.height*0.1,
                                        child: GestureDetector(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black12),
                                                        borderRadius: BorderRadius.all(Radius.circular(8))
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: new Image(
                                                        image: new AssetImage("assets/images/p.png"),
                                                        height: MediaQuery.of(context).size.height*0.035,
                                                        width: MediaQuery.of(context).size.width*0.08,
                                                        color: null,
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                    )

                                                ),
                                                Text('我的點數', style: TextStyle(color: Colors.black54,fontSize: 8,),),
                                              ],
                                            ),
                                            onTap: () async {
                                              var nav = await Navigator.of(context).push(
                                                  CupertinoPageRoute(
                                                      builder: (context)=>stateFeatureButtonPointsWidget()
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
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.15,
                                        height: MediaQuery.of(context).size.height*0.1,
                                        child: GestureDetector(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black12,),
                                                        borderRadius: BorderRadius.all(Radius.circular(8))
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: new Image(
                                                        image: new AssetImage("assets/images/gamepad.png"),
                                                        height: MediaQuery.of(context).size.height*0.035,
                                                        width: MediaQuery.of(context).size.width*0.08,
                                                        color: null,
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                    )

                                                ),
                                                Text('小遊戲', style: TextStyle(color: Colors.black54,fontSize: 8,),),
                                              ],
                                            ),
                                            onTap: () async {
                                              var nav = await Navigator.of(context).push(
                                                  CupertinoPageRoute(
                                                      builder: (context)=>stateGamePageWidget()
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
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.15,
                                        height: MediaQuery.of(context).size.height*0.1,
                                        child: GestureDetector(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black12),
                                                        borderRadius: BorderRadius.all(Radius.circular(8))
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: new Image(
                                                        image: new AssetImage("assets/images/note.png"),
                                                        height: MediaQuery.of(context).size.height*0.035,
                                                        width: MediaQuery.of(context).size.width*0.08,
                                                        color: null,
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                    )

                                                ),
                                                Text('購物便籤', style: TextStyle(color: Colors.black54,fontSize: 8,),),
                                              ],
                                            ),
                                            onTap: () async {
                                              var nav = await Navigator.of(context).push(
                                                  CupertinoPageRoute(
                                                      builder: (context)=>stateMemoWidget()
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
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.15,
                                        height: MediaQuery.of(context).size.height*0.1,
                                        child: GestureDetector(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black12),
                                                        borderRadius: BorderRadius.all(Radius.circular(8))
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: new Image(
                                                        image: new AssetImage("assets/images/record.png"),
                                                        height: MediaQuery.of(context).size.height*0.035,
                                                        width: MediaQuery.of(context).size.width*0.08,
                                                        color: null,
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                    )
                                                ),
                                                Text('歷史紀錄', style: TextStyle(color: Colors.black54,fontSize: 8,),),
                                              ],
                                            ),
                                            onTap:() async {
                                              var nav = await Navigator.of(context).pushAndRemoveUntil(
                                                  CupertinoPageRoute(
                                                      builder: (context)=>stateHistoryListWidget()
                                                  ),(Route<dynamic>route)=>true
                                              );
                                              if(nav==true||nav==null){
                                                Navigator.of(context).pushAndRemoveUntil(
                                                    CupertinoPageRoute(
                                                        builder: (context)=>stateHomePageWidget()
                                                    ), (Route<dynamic>route)=>true
                                                );
                                              }
                                            }
                                        ),
                                      ),
                                      Query(
                                        options: QueryOptions(
                                            document: gql(shoppingCart),
                                            variables: {"memberID" :appUserID},
                                            fetchPolicy: FetchPolicy.cacheAndNetwork,
                                            onError: (result){
                                              debugPrint(result?.graphqlErrors.toString());
                                              debugPrint(result?.linkException.toString());
                                            }
                                        ),
                                        builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
                                          if (result.hasException) {
                                            debugPrint('EXCEPTION: '+result.exception.toString());
                                          }
                                          if (result.isLoading) {
                                            debugPrint('Loading Data...');
                                            return Container(
                                              width: MediaQuery.of(context).size.width*0.15,
                                              height: MediaQuery.of(context).size.height*0.1,
                                              child: GestureDetector(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.black12),
                                                              borderRadius: BorderRadius.all(Radius.circular(8))
                                                          ),
                                                          child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Container(
                                                                height: MediaQuery.of(context).size.height*0.035,
                                                                width: MediaQuery.of(context).size.width*0.08,
                                                                child: new IconTheme(
                                                                    data: new IconThemeData(color:Color.fromARGB(255, 253, 141, 126)),
                                                                    child: new Icon(Icons.shopping_cart,size: 30,)
                                                                ),
                                                              )
                                                          )
                                                      ),
                                                      Text('購物車', style: TextStyle(color: Colors.black54,fontSize: 8,),),
                                                    ],
                                                  ),
                                                  onTap:() async {
                                                    var nav = await Navigator.of(context).pushAndRemoveUntil(
                                                        CupertinoPageRoute(
                                                            builder: (context)=>stateCartWidget()
                                                        ),(Route<dynamic>route)=>true
                                                    );
                                                    if(nav==true||nav==null){
                                                      Navigator.of(context).pushAndRemoveUntil(
                                                          CupertinoPageRoute(
                                                              builder: (context)=>stateHomePageWidget()
                                                          ), (Route<dynamic>route)=>true
                                                      );
                                                    }
                                                  }
                                              ),
                                            );
                                          }
                                           if(result.data['ShoppingCart_aggregate']['aggregate']['count']==0) {
                                             return Container(
                                               width: MediaQuery.of(context).size.width*0.15,
                                               height: MediaQuery.of(context).size.height*0.1,
                                               child: GestureDetector(
                                                   child: Column(
                                                     mainAxisAlignment: MainAxisAlignment.center,
                                                     crossAxisAlignment: CrossAxisAlignment.center,
                                                     children: <Widget>[
                                                       Container(
                                                           decoration: BoxDecoration(
                                                               border: Border.all(color: Colors.black12),
                                                               borderRadius: BorderRadius.all(Radius.circular(8))
                                                           ),
                                                           child: Padding(
                                                               padding: const EdgeInsets.all(8.0),
                                                               child: Container(
                                                                 height: MediaQuery.of(context).size.height*0.035,
                                                                 width: MediaQuery.of(context).size.width*0.08,
                                                                 child: new IconTheme(
                                                                     data: new IconThemeData(color:Color.fromARGB(255, 253, 141, 126)),
                                                                     child: new Icon(Icons.shopping_cart,size: 30,)
                                                                 ),
                                                               )
                                                           )
                                                       ),
                                                       Text('購物車', style: TextStyle(color: Colors.black54,fontSize: 8,),),
                                                     ],
                                                   ),
                                                   onTap:() async {
                                                     var nav = await Navigator.of(context).pushAndRemoveUntil(
                                                         CupertinoPageRoute(
                                                             builder: (context)=>stateCartWidget()
                                                         ),(Route<dynamic>route)=>true
                                                     );
                                                     if(nav==true||nav==null){
                                                       Navigator.of(context).pushAndRemoveUntil(
                                                           CupertinoPageRoute(
                                                               builder: (context)=>stateHomePageWidget()
                                                           ), (Route<dynamic>route)=>true
                                                       );
                                                     }
                                                   }
                                               ),
                                             );
                                           }

                                          cartAmount=result.data['ShoppingCart_aggregate']['aggregate']['count'];
                                          return Container(
                                            width: MediaQuery.of(context).size.width*0.15,
                                            height: MediaQuery.of(context).size.height*0.1,
                                            child: GestureDetector(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.black12),
                                                            borderRadius: BorderRadius.all(Radius.circular(8))
                                                        ),
                                                        child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              height: MediaQuery.of(context).size.height*0.035,
                                                              width: MediaQuery.of(context).size.width*0.08,
                                                              child: new IconTheme(
                                                                  data: new IconThemeData(color:Color.fromARGB(255, 253, 141, 126)),
                                                                  child: new Icon(Icons.shopping_cart,size: 30,)
                                                              ),
                                                            )
                                                        )
                                                    ),
                                                    Text('購物車', style: TextStyle(color: Colors.black54,fontSize: 8,),),
                                                  ],
                                                ),
                                                onTap:() async {


                                                  var nav = await Navigator.of(context).pushAndRemoveUntil(
                                                      CupertinoPageRoute(
                                                          builder: (context)=>stateCartWidget()
                                                      ),(Route<dynamic>route)=>true
                                                  );
                                                  if(nav==true||nav==null){
                                                    Navigator.of(context).pushAndRemoveUntil(
                                                        CupertinoPageRoute(
                                                            builder: (context)=>stateHomePageWidget()
                                                        ), (Route<dynamic>route)=>true
                                                    );
                                                  }
                                                }
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Expanded(
                                    child: Container(
                                      child: GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 720,
                                              childAspectRatio:2,
                                              crossAxisSpacing: 0.1,
                                              mainAxisSpacing: 0.1),
                                          itemCount: SelectItem.length,
                                          itemBuilder: (BuildContext ctx, index) {
                                            return Container(
                                              height: MediaQuery.of(context).size.height*0.08,
                                              width: MediaQuery.of(context).size.width*0.3,
                                              padding: EdgeInsets.all(0.1),
                                              child:  new Image(
                                                image: new AssetImage(activityImgList[index]),
                                                height: MediaQuery.of(context).size.height*0.8,
                                                width: MediaQuery.of(context).size.width*0.8,
                                                color: null,
                                                fit: BoxFit.fill,
                                              ),
                                            );
                                          }
                                      ) ,
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                      collapsed: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 253, 141, 126),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0),
                            )
                        ),
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.maximize_rounded,color: Colors.white,size: 40,),
                                Text(
                                  "購物小幫手",
                                  style: TextStyle(decoration: TextDecoration.none,color: Colors.white,fontSize: 20),
                                ),
                              ],
                            )
                        ),
                      ),
                      panel: Expanded(
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_drop_down_rounded,color: Colors.white,size: 40,),
                                Align(alignment: Alignment.center,
                                  child: Text(
                                    "開啟後可在購物小幫手通知\n收到賣場內各區優惠通知",
                                    style: TextStyle(decoration: TextDecoration.none, color:Colors.white,fontSize: 15),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height*0.45,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 253, 141, 126),
                                  ),
                                  padding: EdgeInsets.only(
                                    left:  MediaQuery.of(context).size.width*0.025,
                                    right: MediaQuery.of(context).size.width*0.025,
                                  ),
                                  child:stateGenerateAreaSelectItemWidget(),
                                ),
                              ],
                            )
                        ),
                      )
                  ),
                ],
              ),
            )
        )
      )
  );
}

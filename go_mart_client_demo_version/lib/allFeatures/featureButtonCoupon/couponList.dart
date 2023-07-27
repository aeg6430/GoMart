
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/couponRedeem.dart';
import 'package:go_mart_client/home_page_widget/home_page_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../GraphQLConfig/GraphQLConfig.dart';
import '../../global.dart';
import 'couponRedeemVerify.dart';

class stateCouponListWidget extends StatefulWidget{
  const stateCouponListWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    return CouponListWidget();
  }
}
List<String> coupons = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "A",
  "B",
  "Q",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "C",


];
List<String> name = [
  "A",
];

String  couponListQuery="""
  query getCouponList(\$memberID: String!) {
   MemeberDiscount(where: {memberID: {_eq: \$memberID}}) {
    Model {
      discount {
        coupons
      }
      modelName
      modelID
      brand {
        brandName
      }
      productLocation {
        productThumnail
      }
    }
  }
  
  MemeberDiscount_aggregate(where: {memberID: {_eq: \$memberID}}) {
    aggregate {
      count
    }
  }
  
}""";




class CouponListWidget extends State<stateCouponListWidget> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  List<int> selectedIndexList = <int>[];
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
              body:  Query(
                options: QueryOptions(
                    document: gql(couponListQuery),
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
                      constraints: BoxConstraints.expand(),
                      child: SpinKitPouringHourGlassRefined(
                        color: Color.fromARGB(255, 253, 141, 126),
                        size: 50.0,
                      ),

                    );
                  }
                  if(result.data['MemeberDiscount_aggregate']['aggregate']['count']==0) {
                    debugPrint("Nothing here!!!!!");
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Image(
                            image: new AssetImage('assets/images/noResult.jpg'),
                            width: MediaQuery.of(context).size.width*0.5,
                            color: null,
                            fit: BoxFit.scaleDown,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                          Text(
                              '沒有任何折價券',
                              style: TextStyle(fontSize:20,color: Colors.black87.withOpacity(0.6),)
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: result.data['MemeberDiscount_aggregate']['aggregate']['count'],
                      itemBuilder: (BuildContext ctx, index) {
                        return SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                GestureDetector(
                                    child: Container(
                                        width:MediaQuery.of(context).size.width*0.8,
                                        height: MediaQuery.of(context).size.height*0.125,
                                        decoration: new BoxDecoration(
                                          borderRadius:BorderRadius.only (
                                            topLeft: const Radius.circular(15.0),
                                            topRight: const Radius.circular(15.0),
                                            bottomLeft: const Radius.circular(15.0),
                                            bottomRight: const Radius.circular(15.0),
                                          ),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.1),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: Offset(0, 1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              width:MediaQuery.of(context).size.width*0.2,
                                              height: MediaQuery.of(context).size.height*0.5,
                                              decoration: new BoxDecoration(
                                                borderRadius:BorderRadius.only (
                                                  topLeft: const Radius.circular(15.0),
                                                  bottomLeft: const Radius.circular(15.0),
                                                ),
                                              ),
                                              child: Container(
                                                height: MediaQuery.of(context).size.height*0.1,
                                                width: MediaQuery.of(context).size.width*0.15,
                                                child: Image.memory(base64Decode(
                                                    result.data['MemeberDiscount'][index]['Model'][0]['productLocation']['productThumnail']
                                                )),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:MediaQuery.of(context).size.width*0.45,
                                            height: MediaQuery.of(context).size.height*0.5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                                Text(result.data['MemeberDiscount'][index]['Model'][0]['brand']['brandName'],
                                                  style: TextStyle
                                                    (color: Colors.black54,
                                                      fontSize: 15),
                                                ),
                                                Text(result.data['MemeberDiscount'][index]['Model'][0]['modelName'],
                                                  style: TextStyle
                                                    (color: Colors.black54,
                                                      fontSize: 10),
                                                ),
                                                Text( (result.data['MemeberDiscount'][index]['Model'][0]['discount']['coupons']).toString()+"折",
                                                  style: TextStyle
                                                    (color: Colors.black54,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(100),
                                                    bottomRight: Radius.circular(100),
                                                  ),
                                                  color: Colors.black12.withOpacity(0.025),
                                                  shape: BoxShape.rectangle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.withOpacity(0.05),
                                                      blurRadius: 8,
                                                      offset: Offset(0, 0.1), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                height: MediaQuery.of(context).size.height*0.0125,
                                                width: MediaQuery.of(context).size.width*0.05,
                                              ),
                                              Dash(
                                                  direction: Axis.vertical,
                                                  length: MediaQuery.of(context).size.height*0.08,
                                                  dashLength: 8,
                                                  dashColor: Color.fromARGB(255, 250, 169, 161),
                                                  dashThickness:3
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(100),
                                                    topRight: Radius.circular(100),
                                                  ),
                                                  color: Colors.black12.withOpacity(0.025),
                                                  shape: BoxShape.rectangle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.withOpacity(0.05),
                                                      blurRadius: 8,
                                                      offset: Offset(0, 0.1), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                height: MediaQuery.of(context).size.height*0.0125,
                                                width: MediaQuery.of(context).size.width*0.05,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:MediaQuery.of(context).size.width*0.1,
                                            height: MediaQuery.of(context).size.height*0.1,
                                            child: RotatedBox(
                                                quarterTurns: 3,
                                                child: Center(
                                                  child: Text(
                                                    'COUPON',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black54.withOpacity(0.5)
                                                    ),
                                                  ),
                                                )
                                            ),
                                          ),


                                        ],
                                        )
                                    ),
                                    onTap:() async {
                                      /*discountBrandName=result.data['MemeberDiscount'][index]['Model'][0]['brand']['brandName'];
                                      discountModelName=result.data['MemeberDiscount'][index]['Model'][0]['modelName'];
                                      discountValue=(result.data['MemeberDiscount'][index]['Model'][0]['discount']['coupons']).toString();
                                      Navigator.of(context).pushAndRemoveUntil(
                                          CupertinoPageRoute(
                                              builder: (context)=>couponRedeemVerify()
                                          ), (Route<dynamic>route)=>true
                                      );*/
                                    }
                                )
                              ],
                            )
                        );
                      }
                  );
                },
              )
          )
      ),
    )
  );
}
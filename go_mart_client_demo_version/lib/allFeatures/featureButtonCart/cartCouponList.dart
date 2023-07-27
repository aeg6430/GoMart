
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/couponRedeem.dart';
import 'package:go_mart_client/home_page_widget/home_page_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../GraphQLConfig/GraphQLConfig.dart';
import '../../global.dart';


class stateCartCouponListWidget extends StatefulWidget{
  const stateCartCouponListWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    return cartCouponListWidget();
  }
}

String  couponListQuery="""
  query getCouponList(\$modelID: [uuid!]) {
  
  Discount(where: {modelID: {_in:  \$modelID,}}) {
    model {
      discount {
        coupons
      }
      brand {
        brandName
      }
      modelName
      modelID
    }
  }
  Discount_aggregate(where: {modelID: {_in:  \$modelID,}}) {
    aggregate {
      count
    }
  }
  
 
 
  
}""";

bool isChecked=false;



class cartCouponListWidget extends State<stateCartCouponListWidget> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<int> selectedIndexList = <int>[];

  @override
  Widget build(BuildContext context) =>
      CupertinoPageScaffold(
          child: GraphQLProvider(
            client: GraphQLConfiguration.client,
            child: SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Color.fromARGB(255, 253, 141, 126),
                      elevation: 0,
                      title: Center(
                          child: Text("我的折價券", style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Noto Sans",
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            ),
                          )
                      ),
                    ),
                    body: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Expanded(
                              child: Query(
                                options: QueryOptions(
                                    document: gql(couponListQuery),
                                    variables: {
                                      "modelID": selectedItemCouponIDList
                                          .toList()
                                    },
                                    fetchPolicy: FetchPolicy.cacheAndNetwork,
                                    onError: (result) {
                                      debugPrint(result?.graphqlErrors.toString());
                                      debugPrint(result?.linkException.toString());
                                    }
                                ),
                                builder: (QueryResult result,
                                    { VoidCallback refetch, FetchMore fetchMore }) {
                                  if (result.hasException) {
                                    debugPrint('EXCEPTION: ' + result.exception.toString());
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
                                  if (result.data['Discount_aggregate']['aggregate']['count'] == 0) {
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
                                            width: MediaQuery.of(context).size.width * 0.5,
                                            color: null,
                                            fit: BoxFit.scaleDown,
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                                          Text(
                                              '沒有任何折價券',
                                              style: TextStyle(fontSize: 20,
                                                color: Colors.black87.withOpacity(0.6),)
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
                                        ],
                                      ),
                                    );
                                  }
                                  return ListView.builder(
                                      itemCount: result.data['Discount_aggregate']['aggregate']['count'],
                                      itemBuilder: (BuildContext ctx, index) {
                                        return SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    IconTheme(
                                                      data: IconThemeData(
                                                        color: Color.fromARGB(255, 253, 141, 126),),
                                                      child: IconButton(
                                                        icon: selectedIndexList.contains(index)
                                                            ? Icon(
                                                            Icons.check_box)
                                                            : Icon(Icons.check_box_outline_blank),
                                                        onPressed: () async {
                                                          if (!selectedIndexList.contains(index)) {
                                                            selectedIndexList.add(index);
                                                            setState(() {
                                                              //usingItemCouponIDList.add(result.data['Discount'][index]['model']['modelID']);

                                                            //  usingItemCouponValueList.removeAt(index);


                                                              /*usingItemCouponValueList.insert(index, result.data['Discount'][index]['model']['discount']['coupons']);*/


                                                              //  usingItemCouponValueList.add(result.data['Discount'][index]['model']['discount']['coupons']);


                                                             // usingItemCouponValueList.insert(index, result.data['Discount'][index]['model']['discount']['coupons']);
                                                              /*usingItemCouponValueList.removeAt(itemSelected.last);*/

                                                              setState(() {});


                                                              couponSelected = selectedIndexList;





                                                            });
                                                          }
                                                          else {
                                                            selectedIndexList.remove(index);
                                                            setState(() {
                                                              // usingItemCouponIDList.remove(result.data['Discount'][index]['model']['modelID']);


                                                              /*usingItemCouponValueList.remove(result.data['Discount'][index]['model']['discount']['coupons']);*/

                                                              couponSelected = selectedIndexList;



                                                            });
                                                          }
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      child: Container(
                                                          width: MediaQuery.of(context).size.width * 0.8,
                                                          height: MediaQuery.of(context).size.height * 0.125,
                                                          decoration: new BoxDecoration(
                                                            borderRadius: BorderRadius.only(
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
                                                                  width: MediaQuery.of(context).size.width * 0.45,
                                                                  height: MediaQuery.of(context).size.height * 0.5,
                                                                  decoration: new BoxDecoration(
                                                                    borderRadius: BorderRadius.only(
                                                                      topLeft: const Radius.circular(15.0),
                                                                      bottomLeft: const Radius.circular(15.0),
                                                                    ),
                                                                    color: Color.fromARGB(255, 250, 169, 161),
                                                                  ),
                                                                  child: new Image(
                                                                    image: new AssetImage("assets/images/brandTest.png"),
                                                                    height: MediaQuery.of(context).size.height * 0.1,
                                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                                    color: null,
                                                                    fit: BoxFit.scaleDown,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                alignment: Alignment.center,
                                                                width: MediaQuery.of(context).size.width * 0.4,
                                                                height: MediaQuery.of(context).size.height * 0.5,
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(result.data['Discount'][index]['model']['brand']['brandName'],
                                                                      style: TextStyle(color: Colors.black54, fontSize: 15),
                                                                    ),
                                                                    Text(result.data['Discount'][index]['model']['modelName'],
                                                                      style: TextStyle(color: Colors.black54, fontSize: 10),
                                                                    ),
                                                                    Text((result.data['Discount'][index]['model']['discount']['coupons']).toString() + "折",
                                                                      style: TextStyle(color: Colors.black54, fontSize: 20),
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
                                                                    height: MediaQuery.of(context).size.height * 0.0125,
                                                                    width: MediaQuery.of(context).size.width * 0.05,
                                                                  ),
                                                                  Dash(
                                                                      direction: Axis.vertical,
                                                                      length: MediaQuery.of(context).size.height * 0.08,
                                                                      dashLength: 8,
                                                                      dashColor: Colors.black12,
                                                                      dashThickness: 3
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
                                                                    height: MediaQuery.of(context).size.height * 0.0125,
                                                                    width: MediaQuery.of(context).size.width * 0.05,
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                alignment: Alignment.center,
                                                                width: MediaQuery.of(context).size.width * 0.1,
                                                                height: MediaQuery.of(context).size.height * 0.1,
                                                                child: RotatedBox(quarterTurns: 3,
                                                                    child: Center(
                                                                      child: Text(
                                                                        'COUPON',
                                                                        style: TextStyle(
                                                                            fontSize: 15, color: Colors.black54.withOpacity(0.5)
                                                                        ),
                                                                      ),
                                                                    )
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                      ),

                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                        );
                                      }
                                  );
                                },
                              ),
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    height: MediaQuery.of(context).size.height * 0.05,
                                    color: Color.fromARGB(255, 253, 141, 126),
                                    child: Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: GestureDetector(
                                              child: Text(
                                                "確定" + "(" + selectedIndexList.length.toString() + ")",
                                                style: TextStyle(
                                                    color: Colors.white),),
                                              onTap: () {
                                                debugPrint(usingItemCouponValueList.toList().toString());

                                                debugPrint(itemSelected.toList().toString());

                                              },
                                            )
                                        )
                                    )
                                )
                            )
                          ],
                        )
                    )
                )
            ),
          )
      );
}
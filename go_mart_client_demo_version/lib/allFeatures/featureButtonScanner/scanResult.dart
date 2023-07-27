
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:go_mart_client/global.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../GraphQLConfig/GraphQLConfig.dart';


class stateScanResult extends StatefulWidget{
  const stateScanResult({ Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScanResult();
  }
}



class ScanResult extends State<stateScanResult>{

  bool toggle = false;












  String  modelQuery="""
query getSearchTerm(\$modelID:uuid!){
  Model(where: {modelID: {_eq: \$modelID}}) {
    modelName
    brand {
      brandName
    }
    category {
      categoryName
    }
    price {
      priceOriginal
      priceSelling
    }
    productlocation {
      productlocationName
    }
  }
}""";


  List<String> itemThumbnail = [
    "assets/images/product/Pocky百奇 牛奶餅乾棒.jpg",
    "assets/images/product/Pocky百奇 巧克力棒.jpg",
    "assets/images/product/Pocky百奇 香蕉棒.jpg",
    "assets/images/product/Pocky百奇 草莓棒.jpg",
    "assets/images/product/Pocky百奇 極細巧克力棒.jpg"
  ];





  @override
  Widget build(BuildContext context) {

    return GraphQLProvider(
        client: GraphQLConfiguration.client,
        child: CupertinoPageScaffold(
          child: SafeArea(
              child: Scaffold(
                  appBar:AppBar(
                    backgroundColor:Color.fromARGB(255, 253, 141, 126),
                    elevation: 0,
                    title: Center(
                        child: Text("商品資訊",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Noto Sans",
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        )
                    ),
                  ),
                  body:  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Expanded(
                      child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                             Container(
                                height: MediaQuery.of(context).size.height*0.3,
                                width: MediaQuery.of(context).size.width*0.9,
                                child: new Image(
                                  image: new AssetImage('assets/images/map/map.png'),
                                  height: MediaQuery.of(context).size.height*0.9,
                                  width: MediaQuery.of(context).size.width*0.9,
                                  color: null,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: toggle
                                            ? Icon(Icons.bookmark,
                                          color: Color.fromARGB(255, 253, 141, 126),
                                          size: 40,)
                                            : Icon(
                                          Icons.bookmark_border,
                                          color: Color.fromARGB(255, 253, 141, 126),
                                          size: 40,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            toggle = !toggle;
                                          });
                                        }),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height*0.15,
                                    width: MediaQuery.of(context).size.width*0.35,
                                    child: new Image(
                                      image: new AssetImage(itemThumbnail[0]),
                                      height: MediaQuery.of(context).size.height*0.9,
                                      width: MediaQuery.of(context).size.width*0.9,
                                      color: null,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.08,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Query(
                                        options: QueryOptions(
                                            document: gql(modelQuery),
                                            variables: {"modelID" :globalScanModelID},
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
                                            return Text('資料載入中',
                                              style: TextStyle
                                                (color: Colors.black87,
                                                  fontSize: 18),
                                            );
                                          }
                                          debugPrint(result.data.toString());
                                          return Text(result.data['Model'][0]['brand']['brandName'].toString(),
                                            style: TextStyle
                                              (color: Colors.black87,
                                                fontSize: 18),
                                          );
                                        },
                                      ),
                                      Query(
                                        options: QueryOptions(
                                            document: gql(modelQuery),
                                            variables: {"modelID" :globalScanModelID},
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
                                            return Text('資料載入中',
                                              style: TextStyle
                                                (color: Colors.black87,
                                                  fontSize: 20),
                                            );
                                          }
                                          return Text(result.data['Model'][0]['modelName'],
                                            style: TextStyle
                                              (color: Colors.black87,
                                                fontSize: 20),
                                          );
                                        },
                                      ),
                                      Text("商品陳列位置:",
                                        style: TextStyle
                                          (color: Colors.black87,
                                            fontSize: 15),
                                      ),
                                      Query(
                                        options: QueryOptions(
                                            document: gql(modelQuery),
                                            variables: {"modelID" :globalScanModelID},
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
                                            return Text('資料載入中',
                                              style: TextStyle
                                                (color: Colors.black87,
                                                  fontSize: 15),
                                            );
                                          }
                                          debugPrint(result.data.toString());
                                          return Text(result.data['Model'][0]['productlocation']['productlocationName'].toString(),
                                            style: TextStyle
                                              (color: Colors.black87,
                                                fontSize: 15),
                                          );
                                        },
                                      ),
                                      Query(
                                        options: QueryOptions(
                                            document: gql(modelQuery),
                                            variables: {"modelID" :globalScanModelID},
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
                                            return Text('資料載入中',
                                              style: TextStyle
                                                (color: Colors.black87,
                                                  fontSize: 15),
                                            );
                                          }
                                          debugPrint(result.data.toString());
                                          if(result.data['Model'][0]['price']['priceSelling'] < result.data['Model'][0]['price']['priceOriginal']){
                                            return Align(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("原價: \$"+result.data['Model'][0]['price']['priceOriginal'].toString(),
                                                    style: TextStyle
                                                      (
                                                        decoration: TextDecoration.lineThrough,
                                                        decorationColor: Colors.red,
                                                        decorationStyle: TextDecorationStyle.double,
                                                        color: Colors.black87,
                                                        fontSize: 15),
                                                  ),
                                                  Text("特價: \$"+result.data['Model'][0]['price']['priceSelling'].toString(),
                                                    style: TextStyle
                                                      (color: Colors.red,
                                                        fontSize: 20),
                                                  )
                                                ],
                                              )
                                            );
                                          }
                                          return Text("售價: \$"+result.data['Model'][0]['price']['priceOriginal'].toString(),
                                            style: TextStyle
                                              (color: Colors.black87,
                                                fontSize: 15),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Dash(
                                  direction: Axis.horizontal,
                                  length: MediaQuery.of(context).size.width,
                                  dashLength: 8,
                                  dashColor: Colors.black12,
                                  dashThickness:3
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('相關商品',style: TextStyle
                                    (color: Colors.black54,
                                      fontSize: 20),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height*0.125,
                                      child: Center(
                                        child: ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: new List.generate(4, (int index) {
                                            return  GestureDetector(
                                              child: Card(
                                                child:Container(
                                                    width: MediaQuery.of(context).size.width*0.3,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height: MediaQuery.of(context).size.height*0.1,
                                                          width: MediaQuery.of(context).size.width*0.2,
                                                          child: new Image(
                                                            image: new AssetImage(itemThumbnail[index+1]),
                                                            height: MediaQuery.of(context).size.height*0.9,
                                                            width: MediaQuery.of(context).size.width*0.9,
                                                            color: null,
                                                            fit: BoxFit.scaleDown,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ),
                                              onTap: (){debugPrint('Pressed $index');},
                                            );
                                          }),
                                        ),
                                      )
                                  )
                                ],
                              )
                            ],
                          )
                      ),
                    ),
                  )
              )
          ),
        )
    );
  }
}
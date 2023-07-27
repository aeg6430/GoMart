
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_mart_client/global.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:uuid/uuid.dart';

import '../GraphQLConfig/GraphQLConfig.dart';

class stateProductResult extends StatefulWidget{
  const stateProductResult({ Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductResult();
  }
}



class ProductResult extends State<stateProductResult>{

  bool toggle = false;












  String  modelQuery="""
query getSearchTerm(\$modelID:uuid!){
  Model(where: {modelID: {_eq: \$modelID}}) {
    modelName
    modelID
    brand {
      brandName
      brandID
    }
    category {
      categoryName
    }
    price {
      priceOriginal
      priceSelling
    }
    productLocation {
      productlocationName
      productThumnail
      productlocateThumnail
    }
  }
}""";

  String  relatedModelQuery="""
  query getRelatedModel(\$brandID: uuid!,\$modelID: uuid!) {
   Model(where: {_and: {brand: {brandID: {_eq: \$brandID}}, modelID: {_neq: \$modelID}}}) {
    modelID
    modelName
    productLocation {
      productThumnail
    }
  }
  Model_aggregate(where: {_and: {brandID: {_eq: \$brandID}, modelID: {_neq: \$modelID}}}) {
    aggregate {
      count
    }
  }
}""";





  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;





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
                      child: Query(
                        options: QueryOptions(
                            document: gql(modelQuery),
                            variables: {"modelID" :globalTermModelID},
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
                          getSearchTermRelatedBrandID=result.data['Model'][0]['brand']['brandID'];
                          getSearchTermRelatedModelID=result.data['Model'][0]['modelID'];
                          return Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Container(
                                      height: MediaQuery.of(context).size.height*0.3,
                                      width: MediaQuery.of(context).size.width*0.9,

                                      child: Image.memory(base64Decode(
                                          result.data['Model'][0]['productLocation']['productlocateThumnail']
                                      ))
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
                                                // Here we changing the icon.
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
                                        width: MediaQuery.of(context).size.width*0.325,
                                        child: Image.memory(base64Decode(
                                            result.data['Model'][0]['productLocation']['productThumnail']
                                        )),
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width*0.08,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(result.data['Model'][0]['brand']['brandName'].toString(),
                                            style: TextStyle
                                              (color: Colors.black87,
                                                fontSize: 18),
                                          ),
                                          Text(result.data['Model'][0]['modelName'],
                                            style: TextStyle
                                              (color: Colors.black87,
                                                fontSize: 15),
                                          ),
                                          Text("商品陳列位置:",
                                            style: TextStyle
                                              (color: Colors.black87,
                                                fontSize: 15),
                                          ),
                                          Text(result.data['Model'][0]['productLocation']['productlocationName'].toString(),
                                            style: TextStyle
                                              (color: Colors.black87,
                                                fontSize: 15),
                                          ),
                                          Text("售價: \$"+result.data['Model'][0]['price']['priceOriginal'].toString(),
                                            style: TextStyle
                                              (color: Colors.black87,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
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
                                      Query(
                                        options: QueryOptions(
                                            document: gql(relatedModelQuery),
                                            variables: {"brandID" :globalTermBrandID,"modelID":globalTermModelID},
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
                                            return SpinKitRing(
                                              color: Color.fromARGB(255, 253, 141, 126),
                                              size: 50.0,
                                            );
                                          }
                                          //debugPrint(result.data['Model_aggregate']['aggregate']['count'].toString());
                                          int count = result.data['Model_aggregate']['aggregate']['count'];
                                          if(count==null){
                                            SpinKitRing(
                                              color: Color.fromARGB(255, 253, 141, 126),
                                              size: 50.0,
                                            );
                                          }
                                          return Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height*0.125,
                                              child: Center(
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.horizontal,
                                                  children: new List.generate(count, (int index) {
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
                                                                  child: Image.memory(base64Decode(
                                                                      result.data['Model'][index]['productLocation']['productThumnail']
                                                                  )),
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
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              )
                          );
                        },
                      ),
                    ),
                  )
              )
          ),
        )
    );
  }
}
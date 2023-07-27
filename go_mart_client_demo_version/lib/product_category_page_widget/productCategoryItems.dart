
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_mart_client/loadingPage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../GraphQLConfig/GraphQLConfig.dart';
import '../global.dart';
import '../product_Content/productContent.dart';

class stateProductCategoryItems extends StatefulWidget{
  const stateProductCategoryItems({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductCategoryItems();
  }
}



List<String> strs = [
  "Item0",
  "Item1",
  "Item2",
  "Item3",
  "Item4",
  "Item5",
  "Item6",
  "Item7",
];

List<String> itemBrandName = [
  "LOTTE 樂天",
  "LOTTE 樂天",
  "Pocky 百奇",
  "Pocky 百奇",
  "Pocky 百奇",
  "聯華",
  "宏亞",
  "宏亞",
];

List<String> itemModelName = [
  "巧克力派",
  "黑巧克力派",
  "巧克力棒",
  "牛奶餅乾棒",
  "香蕉棒",
  "可樂果原味",
  "新貴派巧克力-花生口味",
  "77經典乳加",
];

List<String> itemThumbnail = [
  "assets/images/product/LOTTE 樂天巧克力派.jpg",
  "assets/images/product/LOTTE 黑巧克力派.jpg",
  "assets/images/product/Pocky百奇 巧克力棒.jpg",
  "assets/images/product/Pocky百奇 牛奶餅乾棒.jpg",
  "assets/images/product/Pocky百奇 香蕉棒.jpg",
  "assets/images/product/可樂果 原味.jpeg",
  "assets/images/product/宏亞 新貴派巧克力-花生口味.jpg",
  "assets/images/product/宏亞  77經典乳加.jpg",
];

String  modelQuery="""
  query getModel(\$categoryID:uuid!){
  Model(where: {categoryID: {_eq: \$categoryID}}) {
    modelName
    modelID
    brand {
      brandName
      brandID
    }
    category {
      category_aggregate {
        aggregate {
          count
        }
      }
    }
    productLocation {
      productThumnail
    }
  }
  Model_aggregate(where: {categoryID: {_eq: \$categoryID}}) {
    aggregate {
      count
    }
  }
}""";

String  relatedModelQuery="""
  query getRelatedModel(\$brandID: uuid!,\$modelID: uuid!) {
    Model(where: {_and: {brand: {brandID: {_eq: \$brandID}}, modelID: {_neq: \$modelID}}}) {
    modelID
    modelName
  }
  Model_aggregate(where: {_and: {brandID: {_eq: \$brandID}, modelID: {_neq: \$modelID}}}) {
    aggregate {
      count
    }
  }
}""";



class ProductCategoryItems extends State<stateProductCategoryItems> with AutomaticKeepAliveClientMixin{


  @override
  bool get wantKeepAlive => true;






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
                      child: Text("生活誌",
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
                      child: Query(
                          options: QueryOptions(
                              document: gql(modelQuery),
                              variables: {"categoryID" :globalCategoryID},
                              pollInterval: const Duration(seconds: 10),
                              fetchPolicy: FetchPolicy.cacheAndNetwork,
                              onError: (result){
                                debugPrint(result?.graphqlErrors.toString());
                                debugPrint(result?.linkException.toString());
                              }
                          ),
                          builder: (QueryResult result, {
                            Future<QueryResult> Function(FetchMoreOptions) fetchMore,
                            Future<QueryResult> Function() refetch,
                          }){
                            if (result.hasException) {
                              // debugPrint('EXCEPTION: '+result.exception.toString());
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

                            if(result.data['Model_aggregate']['aggregate']['count']==0){

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
                                        '糟糕 沒有任何商品',
                                        style: TextStyle(fontSize:20,color: Colors.black87.withOpacity(0.6),)
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                                  ],
                                ),
                              );
                            }




                            return GridView.builder(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 360,
                                    childAspectRatio:0.8,
                                    crossAxisSpacing: 0.1,
                                    mainAxisSpacing: 0.1),
                                itemCount: result.data['Model'][0]['category']['category_aggregate']['aggregate']['count'],
                                itemBuilder: (BuildContext ctx, index) {
                                  return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              color: Colors.white70
                                          ),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: MediaQuery.of(context).size.height*0.15,
                                                    width: MediaQuery.of(context).size.width*0.325,
                                                    child: Image.memory(base64Decode(
                                                        result.data['Model'][index]['productLocation']['productThumnail']
                                                    )),
                                                  ),
                                                  Text(result.data['Model'][index]['brand']['brandName'].toString(),
                                                    style: TextStyle
                                                      (color: Colors.black87,
                                                        fontSize: 18),
                                                  ),
                                                  Text(result.data['Model'][index]['modelName'].toString(),
                                                    style: TextStyle
                                                      (color: Colors.black87,
                                                        fontSize: 14),
                                                  )

                                                ],
                                              )
                                          ),
                                        ),
                                        onTap: () async{
                                          setState(() {
                                            debugPrint('Pressed $index');

                                            debugPrint(result.data['Model'][index]['brand']['brandName']);
                                            debugPrint(result.data['Model'][index]['modelName']);

                                            getRelatedBrandID=result.data['Model'][index]['brand']['brandID'];
                                            getRelatedModelID=result.data['Model'][index]['modelID'];

                                            Navigator.of(context).pushAndRemoveUntil(
                                                CupertinoPageRoute(
                                                    builder: (context)=>stateProductContent()
                                                ),(Route<dynamic>route)=>true
                                            );
                                            globalCategoryModelID=result.data['Model'][index]['modelID'].toString();
                                            productThumnail=result.data['Model'][index]['productLocation']['productThumnail'];
                                          });
                                        },
                                      )
                                  );
                                }
                            );
                          }
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
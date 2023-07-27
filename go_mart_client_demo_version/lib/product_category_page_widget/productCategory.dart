
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_mart_client/global.dart';
import 'package:go_mart_client/loadingPage.dart';
import 'package:go_mart_client/product_category_page_widget/productCategoryItems.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../GraphQLConfig/GraphQLConfig.dart';
import '../product_Content/productContent.dart';

class stateProductCategory extends StatefulWidget{
  const stateProductCategory({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductCategory();
  }
}



List<String> strs = [
  "冷藏冷凍",
  "休閒食品",
  "蔬果",
  "調味品",
  "飲料",
  "沖調飲品",
  "個人清潔美妝",
  "家用紙品",
  "寵物用品",
  "嬰幼用品",
];

class ProductCategory extends State<stateProductCategory> with AutomaticKeepAliveClientMixin{


  @override
  bool get wantKeepAlive => true;



  String  categoryQuery="""
  query getCategory{
  Category(distinct_on: categoryName) {
    categoryName
    categoryID
  }
  Category_aggregate {
    aggregate {
      count
    }
  }
}""";

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
                              document: gql(categoryQuery),
                              pollInterval: const Duration(seconds: 10),
                              fetchPolicy: FetchPolicy.cacheAndNetwork,
                              onError: (result){
                                //debugPrint(result?.graphqlErrors.toString());
                                //debugPrint(result?.linkException.toString());
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

                            return GridView.builder(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 360,
                                    childAspectRatio:1.35,
                                    crossAxisSpacing: 0.5,
                                    mainAxisSpacing: 1),
                                itemCount: result.data['Category_aggregate']['aggregate']['count'],
                                itemBuilder: (BuildContext ctx, index) {
                                  return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        child: Container(
                                          height: MediaQuery.of(context).size.height*0.09,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Color.fromARGB(255, 253, 141, 126),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(result.data['Category'][index]['categoryName'],
                                                style: TextStyle(color: Colors.white)
                                            ),
                                          ),
                                        ),
                                        onTap: () async{

                                          setState(() {
                                            debugPrint('Pressed $index');
                                            Navigator.of(context).pushAndRemoveUntil(
                                                CupertinoPageRoute(
                                                    builder: (context)=>stateProductCategoryItems()
                                                ),(Route<dynamic>route)=>true
                                            );
                                           globalCategoryID=result.data['Category'][index]['categoryID'];
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
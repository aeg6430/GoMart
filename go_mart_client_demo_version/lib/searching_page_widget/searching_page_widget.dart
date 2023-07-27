
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_mart_client/global.dart';
import 'package:go_mart_client/product_Content/productContent.dart';
import 'package:go_mart_client/searching_page_widget/productResult.dart';
import 'package:go_mart_client/values/values.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../GraphQLConfig/GraphQLConfig.dart';
import '../product_category_page_widget/productCategory.dart';

class stateSearchingPageWidget extends StatefulWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return searchingPageWidget();
  }
}
class searchingPageWidget extends State<stateSearchingPageWidget> {

  static const historyLength = 5;

  List<String> _searchHistory = [
    //history
  ];

  List<String> filteredSearchHistory;

  String selectedTerm;

  List<String> filterSearchTerms({
    @required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed.where((term) => term.startsWith(filter)).toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GraphQLConfiguration.client,
      child: Scaffold(
        body: FloatingSearchBar(
          controller: controller,
          body: FloatingSearchBarScrollNotifier(
            child: SearchResultsListView(
              searchTerm: selectedTerm,
            ),
          ),
          transition: CircularFloatingSearchBarTransition(),
          physics: BouncingScrollPhysics(),
          title: Text(
            selectedTerm ?? 'Searching',
            style: TextStyle
              (color: Colors.black54,
                fontSize: 20),
          ),
          hint: '搜尋些什麼吧',
          actions: [
            FloatingSearchBarAction.searchToClear(),
          ],
          onQueryChanged: (query) {
            setState(() {
              filteredSearchHistory = filterSearchTerms(filter: query);
            });
          },
          onSubmitted: (query) {
            setState(() {
              addSearchTerm(query);
              selectedTerm = query;
            });
            controller.close();
            debugPrint("Searching "+selectedTerm);
          },
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
                elevation: 1,
                child: Builder(
                  builder: (context) {
                    if (filteredSearchHistory.isEmpty && controller.query.isEmpty) {
                      return Container(
                        height: 56,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          '開始搜尋',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      );
                    } else if (filteredSearchHistory.isEmpty) {
                      return ListTile(
                        title: Text(controller.query),
                        leading: const Icon(Icons.search_rounded),
                        onTap: () {
                          setState(() {
                            addSearchTerm(controller.query);
                            selectedTerm = controller.query;
                          });
                          controller.close();
                        },
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: filteredSearchHistory.map((term) =>
                            ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: const Icon(Icons.history),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  deleteSearchTerm(term);
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                putSearchTermFirst(term);
                                selectedTerm = term;
                              });
                              controller.close();
                            },
                          ),
                        ).toList(),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  const SearchResultsListView({
    Key key,
    @required this.searchTerm,
  }) : super(key: key);





  final String  searchTermQuery="""
  query getSearchTerms(\$title:String!,\$modelName:String!,\$brandName:String!,\$categoryName:String!){
   Title_aggregate(where: {title: {_similar: \$title}}) {
    aggregate {
      count
    }
  }
   Title(where: {title: {_similar: \$title}}) {
    model {
      modelID
      modelName
       brand{
        brandID
      }
    }
  }
  Model(
    where: {
      _or: [
        {
        modelName: {_similar: \$modelName}
        },
        {
        brand: {
            brandName: {_similar: \$brandName}
            }
        },
        {
        category: {
            categoryName: {_similar: \$categoryName}
            }
        }
      ]
    }
  ) {
    modelName
    modelID
     brand{
        brandID
      }
  }
  Model_aggregate(where: {_or: [{modelName: {_similar: \$modelName}}, {brand: {brandName: {_similar: \$brandName}}}, {category: {categoryName: {_similar: \$categoryName}}}]}) {
    aggregate {
      count
    }
  }
}""";





  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_rounded,
              size: 64,
              color: Colors.black54,
            ),
            Text(
              '開始搜尋',
              style: TextStyle
                (color: Colors.black54,),
            )
          ],
        ),
      );
    }

    final fsb = FloatingSearchBar.of(context);
    return Query(
        options: QueryOptions(
            document: gql(searchTermQuery),
            pollInterval: const Duration(seconds: 10),
            variables: {'title':searchTerm,'modelName':searchTerm,'brandName':searchTerm,'categoryName':searchTerm},

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
            debugPrint('EXCEPTION: '+result.exception.toString());
          }
          if (result.isLoading) {
            debugPrint('Loading Data...');
            return Container(
              width: MediaQuery.of(context).size.width*0.15,
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Text('資料載入中',
              ),
            );
          }

          if(result.data['Title_aggregate']['aggregate']['count']==0 || result.data['Model_aggregate']['aggregate']['count']!=0)
            return ListView(
              padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
              children: List.generate(result.data['Model_aggregate']['aggregate']['count'],
                      (index) => GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        subtitle: Text(result.data['Model'][index]['modelName'].toString()),
                      ),
                    ),
                    onTap: (){

                      //debugPrint(result.data['Model'][index]['modelName'].toString());

                      /*globalTermModelID=result.data['Model'][index]['modelID'].toString();
                      globalTermBrandID=result.data['Model'][index]['brand']['brandID'].toString();*/

                      debugPrint(index.toString()+' is Pressed');
                      Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                              builder: (context)=>stateProductResult()
                          ),(Route<dynamic>route)=>true
                      );


                    },
                  )
              ),
            );
          if(result.data['Title_aggregate']['aggregate']['count']!=0 || result.data['Model_aggregate']['aggregate']['count']==0)
            return ListView(
              padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
              children: List.generate(result.data['Title_aggregate']['aggregate']['count'],
                      (index) => GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        subtitle: Text(result.data['Title'][index]['model'][0]['modelName']),
                      ),
                    ),
                    onTap: (){


                      debugPrint(index.toString()+' is Pressed');

                      Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                              builder: (context)=>stateProductResult()
                          ),(Route<dynamic>route)=>true
                      );
                      globalTermModelID=result.data['Title'][index]['model'][0]['modelID'].toString();
                      globalTermBrandID=result.data['Title'][index]['model'][0]['brand']['brandID'].toString();

                    },
                  )
              ),
            );
          if(result.data['Title_aggregate']['aggregate']['count']==0 || result.data['Model_aggregate']['aggregate']['count']==0)
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
                      '找不到有關'+searchTerm+'的商品',
                      style: TextStyle(fontSize:20,color: Colors.black87.withOpacity(0.6),)
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                ],
              ),
            );
        }
    );
    /*return Query(
        options: QueryOptions(
            document: gql(searchTermQuery),
            pollInterval: const Duration(seconds: 10),
            variables: {'title':searchTerm,'modelName':searchTerm,'brandName':searchTerm,'categoryName':searchTerm},

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
            debugPrint('EXCEPTION: '+result.exception.toString());
          }
          if (result.isLoading) {
            debugPrint('Loading Data...');
            return Container(
              width: MediaQuery.of(context).size.width*0.15,
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Text('資料載入中',
              ),
            );
          }
          if(result.data['Title'].isEmpty || result.data['Model_aggregate']['aggregate']['count']!=0)
            return ListView(
              padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
              children: List.generate(result.data['Model_aggregate']['aggregate']['count'],
                      (index) => GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        subtitle: Text(result.data['Model'][index]['modelName'].toString()),
                      ),
                    ),
                    onTap: (){
                      debugPrint(index.toString()+' is Pressed');
                      Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                              builder: (context)=>stateProductResult()
                          ),(Route<dynamic>route)=>true
                      );
                      globalTermModelID=result.data['Model'][index]['modelID'].toString();
                      globalTermBrandID=result.data['Model'][index]['brand']['brandID'].toString();

                    },
                  )
              ),
            );
          if(result.data['Title'].isEmpty==false || result.data['Model_aggregate']['aggregate']['count']==0)
            return ListView(
            padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
            children: List.generate(result.data['Title_aggregate']['aggregate']['count'],
                    (index) => GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListTile(
                      subtitle: Text(result.data['Title'][index]['model'][index]['modelName'].toString()),
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                            builder: (context)=>stateProductResult()
                        ),(Route<dynamic>route)=>true
                    );
                    globalTermModelID=result.data['Title'][index]['model'][index]['modelID'].toString();
                    globalTermBrandID=result.data['Title'][index]['model'][index]['brand']['brandID'].toString();
                    debugPrint(globalTermBrandID);
                  },
                )
            ),
          );
        }
    );*/
  }
}

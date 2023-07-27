import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_mart_client/allFeatures/featureButtonCoupon/couponRedeem.dart';
import 'package:go_mart_client/allFeatures/featureButtonPoints/pointsRedeem.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../GraphQLConfig/GraphQLConfig.dart';
import '../../global.dart';

class stateFeatureButtonPointsWidget extends StatefulWidget{
  const stateFeatureButtonPointsWidget({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return featureButtonPointsWidget();
  }
}




/*String  pointsListQuery="""
  query getPointsList(\$memberID: String!) {
   MemeberDiscount(where: {memberID: {_eq: \$memberID}}) {
    Model {
      discount {
        points
      }
      modelName
      modelID
      brand {
        brandName
      }
    }
    
  }
  
  GamePoints_aggregate(where: {memberdiscount: {memberID: {_eq: \$memberID}}}) {
    aggregate {
      count
    }
  }
  
  MemeberDiscount_aggregate(where: {memberID: {_eq: \$memberID}}) {
    aggregate {
      count
    }
  }
  
}""";*/

String  pointsListQuery2="""
  query getPointsList(\$memberID: String!) {
   MemeberDiscount(where: {memberID: {_eq: \$memberID}}) {
    Model {
      discount {
        points
      }
      modelName
      modelID
      brand {
        brandName
      }
    }
  }

  GamePoints(where: {memberID: {_eq: \$memberID}}) {
    points
  }
  GamePoints_aggregate(where: {memberID: {_eq: \$memberID}}) {
    aggregate {
      count
    }
  }
  
 
  
  MemeberDiscount_aggregate(where: {memberID: {_eq: \$memberID}}) {
    aggregate {
      count
    }
  }
  
}""";

class featureButtonPointsWidget extends State<stateFeatureButtonPointsWidget> with AutomaticKeepAliveClientMixin{

  @override
  // implement wantKeepAlive
  bool get wantKeepAlive => true;




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
                    child: Text("我的點數",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Noto Sans",
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    )
                ),
              ),
              body: Query(
                options: QueryOptions(
                    document: gql(pointsListQuery2),
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


                  int points=0;
                  int pointsAmount=0;
                  int count = result.data['MemeberDiscount_aggregate']['aggregate']['count'];
                  for(int i=0; i<count; i++){
                    points=result.data['MemeberDiscount'][i]['Model'][0]['discount']['points'];
                    pointsAmount+=points;
                  }

                  int gamePoints=0;
                  int gamePointsAmount=0;
                  int gameCount = result.data['GamePoints_aggregate']['aggregate']['count'];
                  for(int i=0; i<gameCount; i++){
                    gamePoints=result.data['GamePoints'][i]['points'];
                    gamePointsAmount+=gamePoints;
                  }
                  int sum= pointsAmount+gamePointsAmount;
                  debugPrint(result.data['GamePoints_aggregate']['aggregate']['count'].toString());
                  if(result.data['GamePoints_aggregate']['aggregate']['count']==0){
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Expanded(
                        child: DefaultTabController(
                          animationDuration: Duration.zero,
                          length: 2,
                          child: SizedBox(
                            height:MediaQuery.of(context).size.height,
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                    Text(
                                      "剩餘點數:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54.withOpacity(0.5)
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        new Image(
                                          image: new AssetImage("assets/images/p.png"),
                                          height: MediaQuery.of(context).size.height*0.1,
                                          width: MediaQuery.of(context).size.width*0.1,
                                          color: null,
                                          fit: BoxFit.scaleDown,
                                        ),
                                        SizedBox(width: MediaQuery.of(context).size.width*0.025,),
                                        Text(
                                          sum.toString(),
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.black54.withOpacity(0.65)
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  height:MediaQuery.of(context).size.height*0.08,
                                  color: Color.fromARGB(255, 253, 141, 126),
                                  child: TabBar(
                                    indicator: UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                          width: MediaQuery.of(context).size.width*0.005,
                                          color:Colors.white ),
                                    ),
                                    tabs: <Tab>[
                                      Tab(
                                        child: Text(
                                          "小遊戲點數\n獲得紀錄",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color:Colors.white,fontSize: 12,),),
                                      ),
                                      Tab(
                                        child: Text(
                                          "掃一掃點數\n獲得紀錄",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color:Colors.white,fontSize: 12),),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: <Widget>[
                                      Container(
                                        height: MediaQuery.of(context).size.height*0.5,
                                        child:ListView.builder(
                                            itemCount: gameCount,
                                            itemBuilder: (BuildContext ctx, index) {
                                              return Container(
                                                height: MediaQuery.of(context).size.height*0.5,
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
                                                        '沒有任何點數 快去玩小遊戲吧',
                                                        style: TextStyle(fontSize:20,color: Colors.black87.withOpacity(0.6),)
                                                    ),
                                                    SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                                                  ],
                                                ),
                                              );
                                            }
                                        ),
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height*0.5,
                                        child: ListView.builder(
                                            itemCount: count,
                                            itemBuilder: (BuildContext ctx, index) {
                                              return Column(
                                                children: [
                                                  SizedBox(height: 10,),
                                                  Container(
                                                      width:MediaQuery.of(context).size.width*0.9,
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
                                                      child:
                                                      Row(children: [
                                                        Container(
                                                          alignment: Alignment.center,
                                                          width:MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.5,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(result.data['MemeberDiscount'][index]['Model'][0]['modelName'],
                                                                style: TextStyle
                                                                  (color: Colors.black54,
                                                                    fontSize: 20),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                new Image(
                                                                  image: new AssetImage("assets/images/p.png"),
                                                                  height: MediaQuery.of(context).size.height*0.08,
                                                                  width: MediaQuery.of(context).size.width*0.08,
                                                                  color: null,
                                                                  fit: BoxFit.scaleDown,
                                                                ),
                                                                SizedBox(width: MediaQuery.of(context).size.width*0.025,),
                                                                Text(
                                                                  "+"+result.data['MemeberDiscount'][index]['Model'][0]['discount']['points'].toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 20,
                                                                      color: Colors.black54.withOpacity(0.65)
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                        )
                                                      ],
                                                      )
                                                  ),
                                                ],
                                              );
                                            }
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    );
                  }
                  if(gameCount!=0){
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Expanded(
                        child: DefaultTabController(
                          animationDuration: Duration.zero,
                          length: 2,
                          child: SizedBox(
                            height:MediaQuery.of(context).size.height,
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                    Text(
                                      "剩餘點數:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54.withOpacity(0.5)
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        new Image(
                                          image: new AssetImage("assets/images/p.png"),
                                          height: MediaQuery.of(context).size.height*0.1,
                                          width: MediaQuery.of(context).size.width*0.1,
                                          color: null,
                                          fit: BoxFit.scaleDown,
                                        ),
                                        SizedBox(width: MediaQuery.of(context).size.width*0.025,),
                                        Text(
                                          sum.toString(),
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.black54.withOpacity(0.65)
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  height:MediaQuery.of(context).size.height*0.08,
                                  color: Color.fromARGB(255, 253, 141, 126),
                                  child: TabBar(
                                    indicator: UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                          width: MediaQuery.of(context).size.width*0.005,
                                          color:Colors.white ),
                                    ),
                                    tabs: <Tab>[
                                      Tab(
                                        child: Text(
                                          "小遊戲點數\n獲得紀錄",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color:Colors.white,fontSize: 12,),),
                                      ),
                                      Tab(
                                        child: Text(
                                          "掃一掃點數\n獲得紀錄",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color:Colors.white,fontSize: 12),),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: <Widget>[
                                      Container(
                                        height: MediaQuery.of(context).size.height*0.5,
                                        child:ListView.builder(
                                            itemCount: gameCount,
                                            itemBuilder: (BuildContext ctx, index) {
                                              return Column(
                                                children: [
                                                  SizedBox(height: 10,),
                                                  Container(
                                                      width:MediaQuery.of(context).size.width*0.9,
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
                                                      child:
                                                      Row(children: [
                                                        Container(
                                                          alignment: Alignment.center,
                                                          width:MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.5,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text("小遊戲",
                                                                style: TextStyle
                                                                  (color: Colors.black54,
                                                                    fontSize: 25),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                new Image(
                                                                  image: new AssetImage("assets/images/p.png"),
                                                                  height: MediaQuery.of(context).size.height*0.08,
                                                                  width: MediaQuery.of(context).size.width*0.08,
                                                                  color: null,
                                                                  fit: BoxFit.scaleDown,
                                                                ),
                                                                SizedBox(width: MediaQuery.of(context).size.width*0.025,),
                                                                Text(
                                                                  "+"+result.data['GamePoints'][index]['points'].toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 20,
                                                                      color: Colors.black54.withOpacity(0.65)
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                        )
                                                      ],
                                                      )
                                                  ),
                                                ],
                                              );
                                            }
                                        ),
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height*0.5,
                                        child: ListView.builder(
                                            itemCount: count,
                                            itemBuilder: (BuildContext ctx, index) {
                                              return Column(
                                                children: [
                                                  SizedBox(height: 10,),
                                                  Container(
                                                      width:MediaQuery.of(context).size.width*0.9,
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
                                                      child:
                                                      Row(children: [
                                                        Container(
                                                          alignment: Alignment.center,
                                                          width:MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.5,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(result.data['MemeberDiscount'][index]['Model'][0]['modelName'],
                                                                style: TextStyle
                                                                  (color: Colors.black54,
                                                                    fontSize: 20),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                new Image(
                                                                  image: new AssetImage("assets/images/p.png"),
                                                                  height: MediaQuery.of(context).size.height*0.08,
                                                                  width: MediaQuery.of(context).size.width*0.08,
                                                                  color: null,
                                                                  fit: BoxFit.scaleDown,
                                                                ),
                                                                SizedBox(width: MediaQuery.of(context).size.width*0.025,),
                                                                Text(
                                                                  "+"+result.data['MemeberDiscount'][index]['Model'][0]['discount']['points'].toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 20,
                                                                      color: Colors.black54.withOpacity(0.65)
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                        )
                                                      ],
                                                      )
                                                  ),
                                                ],
                                              );
                                            }
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    );
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Expanded(
                      child: DefaultTabController(
                        animationDuration: Duration.zero,
                        length: 2,
                        child: SizedBox(
                          height:MediaQuery.of(context).size.height,
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                  Text(
                                    "剩餘點數:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54.withOpacity(0.5)
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      new Image(
                                        image: new AssetImage("assets/images/p.png"),
                                        height: MediaQuery.of(context).size.height*0.1,
                                        width: MediaQuery.of(context).size.width*0.1,
                                        color: null,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width*0.025,),
                                      Text(
                                        sum.toString(),
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black54.withOpacity(0.65)
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                height:MediaQuery.of(context).size.height*0.08,
                                color: Color.fromARGB(255, 253, 141, 126),
                                child: TabBar(
                                  indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                        width: MediaQuery.of(context).size.width*0.005,
                                        color:Colors.white ),
                                  ),
                                  tabs: <Tab>[
                                    Tab(
                                      child: Text(
                                        "小遊戲點數\n獲得紀錄",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color:Colors.white,fontSize: 12,),),
                                    ),
                                    Tab(
                                      child: Text(
                                        "掃一掃點數\n獲得紀錄",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color:Colors.white,fontSize: 12),),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: <Widget>[
                                    Container(
                                      height: MediaQuery.of(context).size.height*0.5,
                                      child:ListView.builder(
                                          itemCount: gameCount,
                                          itemBuilder: (BuildContext ctx, index) {
                                            return Container(
                                              height: MediaQuery.of(context).size.height*0.5,
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
                                                      '沒有任何點數 快去玩小遊戲吧',
                                                      style: TextStyle(fontSize:20,color: Colors.black87.withOpacity(0.6),)
                                                  ),
                                                  SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                                                ],
                                              ),
                                            );
                                          }
                                      ),
                                    ),
                                    Container(
                                      height: MediaQuery.of(context).size.height*0.5,
                                      child: ListView.builder(
                                          itemCount: count,
                                          itemBuilder: (BuildContext ctx, index) {
                                            return Column(
                                              children: [
                                                SizedBox(height: 10,),
                                                Container(
                                                    width:MediaQuery.of(context).size.width*0.9,
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
                                                    child:
                                                    Row(children: [
                                                      Container(
                                                        alignment: Alignment.center,
                                                        width:MediaQuery.of(context).size.width*0.55,
                                                        height: MediaQuery.of(context).size.height*0.5,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(result.data['MemeberDiscount'][index]['Model'][0]['modelName'],
                                                              style: TextStyle
                                                                (color: Colors.black54,
                                                                  fontSize: 20),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              new Image(
                                                                image: new AssetImage("assets/images/p.png"),
                                                                height: MediaQuery.of(context).size.height*0.08,
                                                                width: MediaQuery.of(context).size.width*0.08,
                                                                color: null,
                                                                fit: BoxFit.scaleDown,
                                                              ),
                                                              SizedBox(width: MediaQuery.of(context).size.width*0.025,),
                                                              Text(
                                                                "+"+result.data['MemeberDiscount'][index]['Model'][0]['discount']['points'].toString(),
                                                                style: TextStyle(
                                                                    fontSize: 20,
                                                                    color: Colors.black54.withOpacity(0.65)
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                      )
                                                    ],
                                                    )
                                                ),
                                              ],
                                            );
                                          }
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  );
                },
              )
          )
      ),
    )
  );
}
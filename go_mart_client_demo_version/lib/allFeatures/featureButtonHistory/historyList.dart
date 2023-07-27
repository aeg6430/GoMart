
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_mart_client/global.dart';
import 'package:go_mart_client/product_Content/productContent.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../GraphQLConfig/GraphQLConfig.dart';

class stateHistoryListWidget extends StatefulWidget{
  const stateHistoryListWidget({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HistoryListWidget();
  }
}

List<String> coupons = [
  "0A",
  "1B",
];


String  storedModelQuery="""
  query getStoredModel(\$memberID: String!) {
  StoredModel(where: {memberID: {_eq: \$memberID}}) {
    No
    model {
      modelName
      brand {
        brandName
      }
      productLocation {
        
      }
      modelID
    }
  }
  StoredModel_aggregate(
  where: {memberID: {_eq: \$memberID}
  }) {
    aggregate {
      count
    }
  }
}""";

String  deleteStoredModelMuntation="""
  mutation deleteStoredModel(\$No:uuid!) {
  delete_StoredModel(where: {No: {_eq: \$No}}) {
    affected_rows
  }
}""";

String  scannedHistoryQuery="""
  query getScannedHistory(\$memberID: String!) {
  ScannedHistory(where: {memberID: {_eq: \$memberID}}) {
    No
    model {
      modelName
      brand {
        brandName
      }
      productLocation {
        
      }
      modelID
    }
  }
  ScannedHistory_aggregate(
  where: {
  memberID: {_eq: \$memberID}
  }){
    aggregate {
      count
    }
  }
  
}""";

String  deleteScannedHistoryMuntation="""
  mutation deleteScannedHistory(\$No:uuid!) {
  delete_ScannedHistory(where: {No: {_eq: \$No}}) {
    affected_rows
  }
}""";



var refreshKey = GlobalKey<RefreshIndicatorState>();


class HistoryListWidget extends State<stateHistoryListWidget> with AutomaticKeepAliveClientMixin{
  @override
  // implement wantKeepAlive
  bool get wantKeepAlive => true;
  final List<Map> SelectItem =
  List.generate(coupons.length, (index) => {"id": index, }).toList();
  List<int> selectedIndexList = new List<int>();

  DateTime startDateTime=DateTime.now();
  DateTime endDateTime=DateTime.now();








  @override
  Widget build(BuildContext context) {
    final startHours=startDateTime.hour.toString().padLeft(2,'0');
    final startMinutes=startDateTime.minute.toString().padLeft(2,'0');
    return GraphQLProvider(
        client: GraphQLConfiguration.client,
      child: CupertinoPageScaffold(
        child: SafeArea(
            child: Scaffold(
                appBar:AppBar(
                  backgroundColor:Color.fromARGB(255, 253, 141, 126),
                  elevation: 0,
                  title: Center(
                      child: Text("歷史紀錄",
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
                    child: DefaultTabController(
                      animationDuration: Duration.zero,
                      length: 2,
                      child: SizedBox(
                        height:MediaQuery.of(context).size.height,
                        child: Column(
                          children: <Widget>[
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
                                      "掃描紀錄",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color:Colors.white,fontSize: 12,),),
                                  ),
                                  Tab(
                                    child: Text(
                                      "蒐藏紀錄",
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
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: MediaQuery.of(context).size.height*0.72,
                                              child: Query(
                                                options: QueryOptions(
                                                    document: gql(scannedHistoryQuery),
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
                                                  if(result.data['ScannedHistory_aggregate']['aggregate']['count']==0) {
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
                                                          RotatedBox(quarterTurns: 1,
                                                            child: Text(
                                                                ':(',
                                                                style: TextStyle(fontSize:35,color: Colors.black87.withOpacity(0.6),)
                                                            ),
                                                          ),
                                                          SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                  scannedModelNo=result.data['ScannedHistory'][0]['No'];
                                                  return ListView.builder(
                                                      itemCount: result.data['ScannedHistory_aggregate']['aggregate']['count'],
                                                      itemBuilder: (BuildContext ctx, index) {
                                                        return SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                SizedBox(height: 10,),
                                                                GestureDetector(
                                                                    child: Container(
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
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                                                                  color: Color.fromARGB(255, 250, 169, 161).withOpacity(0.5),
                                                                                ),
                                                                                child: Container(
                                                                                  height: MediaQuery.of(context).size.height*0.15,
                                                                                  width: MediaQuery.of(context).size.width*0.325,
                                                                                  /*child: Image.memory(base64Decode(
                                                                                          result.data['StoredModel'][index]['model']['productLocation']['productThumnail']
                                                                                      )),*/
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.center,
                                                                              width:MediaQuery.of(context).size.width*0.475,
                                                                              height: MediaQuery.of(context).size.height*0.5,
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(result.data['ScannedHistory'][index]['model']['brand']['brandName'].toString(),
                                                                                    style: TextStyle
                                                                                      (color: Colors.black54,
                                                                                        fontSize: 20),
                                                                                  ),
                                                                                  Text(result.data['ScannedHistory'][index]['model']['modelName'].toString(),
                                                                                    style: TextStyle
                                                                                      (color: Colors.black54,
                                                                                        fontSize: 15),
                                                                                  ),
                                                                                  Text("2022/10/10 21/30/02",
                                                                                    style: TextStyle
                                                                                      (color: Colors.black54.withOpacity(0.35),
                                                                                        fontSize: 10),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Mutation(
                                                                              options: MutationOptions(
                                                                                  document: gql(deleteScannedHistoryMuntation),
                                                                                  onError: (result){
                                                                                    debugPrint(result?.graphqlErrors.toString());
                                                                                    debugPrint(result?.linkException.toString());
                                                                                  }
                                                                              ),
                                                                              builder: (
                                                                                  MultiSourceResult<Object> Function(Map<String, dynamic>, {Object optimisticResult})
                                                                                  runMutation,
                                                                                  QueryResult<Object> result) {
                                                                                return  IconButton(
                                                                                  icon: Icon(
                                                                                    Icons.delete,
                                                                                    color: Color.fromARGB(255, 253, 141, 126),
                                                                                    size: 35.0,),
                                                                                  onPressed: () async{
                                                                                    if (!selectedIndexList.contains(index)) {
                                                                                      selectedIndexList.add(index);
                                                                                      debugPrint('Item '+index.toString()+' is Deleted');

                                                                                      runMutation(
                                                                                          {
                                                                                            "No": scannedModelNo
                                                                                          }
                                                                                      );
                                                                                    }
                                                                                    setState(() {

                                                                                    });
                                                                                  },
                                                                                );
                                                                              },
                                                                            )
                                                                          ],
                                                                        )
                                                                    ),
                                                                    onTap:() async {
                                                                      Navigator.of(context).pushAndRemoveUntil(
                                                                          CupertinoPageRoute(
                                                                              builder: (context)=>stateProductContent()
                                                                          ),(Route<dynamic>route)=>true
                                                                      );
                                                                    }
                                                                )
                                                              ],
                                                            )
                                                        );
                                                      }
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Align(
                                              alignment:Alignment.topCenter,
                                              child: GestureDetector(
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height:MediaQuery.of(context).size.height*0.05,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(255, 253, 141, 126),
                                                    ),
                                                    child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              '${startDateTime.year}/${startDateTime.month}/${startDateTime.day} $startHours:$startMinutes',
                                                              style: TextStyle(color: Colors.white),
                                                            ),
                                                            Icon(Icons.calendar_month_outlined,color: Colors.white,),
                                                          ],
                                                        )
                                                    )
                                                ),
                                                onTap: (){
                                                  pickStartDateTime();
                                                },
                                              )
                                          ),
                                        ],
                                      )
                                  ),
                                  Container(
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: MediaQuery.of(context).size.height*0.72,
                                              child: Query(
                                                options: QueryOptions(
                                                    document: gql(storedModelQuery),
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
                                                    return Container(
                                                      constraints: BoxConstraints.expand(),
                                                      child: SpinKitPouringHourGlassRefined(
                                                        color: Color.fromARGB(255, 253, 141, 126),
                                                        size: 50.0,
                                                      ),

                                                    );
                                                  }
                                                  if(result.data['StoredModel_aggregate']['aggregate']['count']==0) {
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
                                                          RotatedBox(quarterTurns: 1,
                                                            child: Text(
                                                                ':(',
                                                                style: TextStyle(fontSize:35,color: Colors.black87.withOpacity(0.6),)
                                                            ),
                                                          ),
                                                          SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                  savedModelNo = result.data['StoredModel'][0]['No'];
                                                  return ListView.builder(
                                                      itemCount: result.data['StoredModel_aggregate']['aggregate']['count'],
                                                      itemBuilder: (BuildContext ctx, index) {
                                                        return SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                SizedBox(height: 10,),
                                                                GestureDetector(
                                                                    child: Container(
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
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                                                                    color: Color.fromARGB(255, 250, 169, 161).withOpacity(0.5),
                                                                                  ),
                                                                                  child: Container(
                                                                                    height: MediaQuery.of(context).size.height*0.15,
                                                                                    width: MediaQuery.of(context).size.width*0.325,
                                                                                    /*child: Image.memory(base64Decode(
                                                                                          result.data['StoredModel'][index]['model']['productLocation']['productThumnail']
                                                                                      )),*/
                                                                                  )
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.center,
                                                                              width:MediaQuery.of(context).size.width*0.475,
                                                                              height: MediaQuery.of(context).size.height*0.5,
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(result.data['StoredModel'][index]['model']['brand']['brandName'].toString(),
                                                                                    style: TextStyle
                                                                                      (color: Colors.black54,
                                                                                        fontSize: 20),
                                                                                  ),
                                                                                  Text(result.data['StoredModel'][index]['model']['modelName'].toString(),
                                                                                    style: TextStyle
                                                                                      (color: Colors.black54,
                                                                                        fontSize: 15),
                                                                                  ),
                                                                                  Text("2022/10/10 21/30/02",
                                                                                    style: TextStyle
                                                                                      (color: Colors.black54.withOpacity(0.35),
                                                                                        fontSize: 10),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Mutation(
                                                                              options: MutationOptions(
                                                                                  document: gql(deleteStoredModelMuntation),
                                                                                  onError: (result){
                                                                                    debugPrint(result?.graphqlErrors.toString());
                                                                                    debugPrint(result?.linkException.toString());
                                                                                  }
                                                                              ),
                                                                              builder: (
                                                                                  MultiSourceResult<Object> Function(Map<String, dynamic>, {Object optimisticResult})
                                                                                  runMutation,
                                                                                  QueryResult<Object> result) {
                                                                                return  IconButton(
                                                                                  icon: Icon(
                                                                                    Icons.bookmark,
                                                                                    color: Color.fromARGB(255, 253, 141, 126),
                                                                                    size: 35.0,),
                                                                                  onPressed: () async{
                                                                                    if (!selectedIndexList.contains(index)) {
                                                                                      selectedIndexList.add(index);
                                                                                      debugPrint('Item '+index.toString()+' is Deleted');

                                                                                      runMutation(
                                                                                          {
                                                                                            "No": savedModelNo
                                                                                          }
                                                                                      );
                                                                                    }
                                                                                    setState(() {

                                                                                    });
                                                                                  },
                                                                                );
                                                                              },
                                                                            )
                                                                          ],
                                                                        )
                                                                    ),
                                                                    onTap:() async {
                                                                      Navigator.of(context).pushAndRemoveUntil(
                                                                          CupertinoPageRoute(
                                                                              builder: (context)=>stateProductContent()
                                                                          ),(Route<dynamic>route)=>true
                                                                      );
                                                                    }
                                                                )
                                                              ],
                                                            )
                                                        );
                                                      }
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Align(
                                              alignment:Alignment.topCenter,
                                              child: GestureDetector(
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height:MediaQuery.of(context).size.height*0.05,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(255, 253, 141, 126),
                                                    ),
                                                    child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              '${startDateTime.year}/${startDateTime.month}/${startDateTime.day} $startHours:$startMinutes',
                                                              style: TextStyle(color: Colors.white),
                                                            ),
                                                            Icon(Icons.calendar_month_outlined,color: Colors.white,),
                                                          ],
                                                        )
                                                    )
                                                ),
                                                onTap: (){
                                                  pickStartDateTime();
                                                },
                                              )
                                          ),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                )
            )
        ),
      )
    );
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {


    });
  }


  Future pickStartDateTime() async{
    DateTime date=await pickDate();
    if(date==null) return;
    TimeOfDay time =await pickTime();
    if(time==null)return;
    final dateTime=DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(()=>this.startDateTime=dateTime);
  }

  Future<DateTime>pickDate()=> showDatePicker
    (context: context,
    initialDate: startDateTime,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  Future<TimeOfDay>pickTime()=> showTimePicker
    (context: context,
    initialTime:TimeOfDay(hour: startDateTime.hour, minute: startDateTime.minute),
  );
}




import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_mart_client/allFeatures/featureButtonCart/cartCouponList.dart';
import 'package:go_mart_client/global.dart';
import 'package:go_mart_client/product_Content/productContent.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../GraphQLConfig/GraphQLConfig.dart';
import 'package:collection/collection.dart';

import '../../home_page_widget/home_page_widget.dart';

class stateCartWidget extends StatefulWidget{
  const stateCartWidget({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CartWidget();
  }
}

List<String> coupons = [
  "0A",
  "1B",
];


String  shoppingCartQuery="""
  query getShoppingCart(\$memberID: String!) {
  ShoppingCart(where: {memberID: {_eq: \$memberID}}) {
    Model {
      modelName
      modelID
      discount {
        coupons
      }
      price {
        priceSelling
        priceOriginal
      }
      productLocation{
      productThumnail
      }
    }
     No
    
    Discount_aggregate {
      aggregate {
        count
      }
    }
    
  }
  ShoppingCart_aggregate(where: {memberID: {_eq: \$memberID}}) {
    aggregate {
      count
    }
  }
}""";

String  deleteShoppingCartMuntation="""
  mutation deleteShoppingCart(\$No:uuid!) {
  delete_ShoppingCart(where: {No: {_eq: \$No}}) {
    affected_rows
  }
}""";


String getMemberPoints="""
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





var refreshKey = GlobalKey<RefreshIndicatorState>();


class CartWidget extends State<stateCartWidget> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  final List<Map> SelectItem =
  List.generate(coupons.length, (index) => {"id": index, }).toList();
  List<int> selectedIndexList = new List<int>();

  DateTime startDateTime=DateTime.now();
  DateTime endDateTime=DateTime.now();

  bool isChecked=false;





  TextEditingController pointsController = new TextEditingController(text: '0');

  List<TextEditingController> itemController =
  List.generate(cartAmount, (i) => TextEditingController(text: '1'));



  @override
  void dispose() {
    pointsController.dispose();
    super.dispose();
  }


  List<int> unitPrice = [];
  List<int> amount = [];





 /* Future<List<int>> getTotal() async {
    List<int> total = [];
    for(int i=0;i<unitPrice.length;i++)
      total.add(unitPrice[i]*amount[i]*usingItemCouponValueList[i]);
    return total;
  }
  Future<List<int>> removeItem(int index) async {
    debugPrint("Button "+index.toString());
    return[unitPrice.removeAt(index),amount.removeAt(index),usingItemCouponValueList.removeAt(index)];
  }*/


  Future<List<int>> getTotal() async {
    List<int> total = [];
    for(int i=0;i<unitPrice.length;i++)
      total.add(unitPrice[i]*amount[i]);
    return total;
  }
  Future<List<int>> removeItem(int index) async {
    debugPrint("Button "+index.toString());
    return[unitPrice.removeAt(index),amount.removeAt(index)];
  }






  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GraphQLConfiguration.client,
      child: CupertinoPageScaffold(
        child: SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar:AppBar(
                  backgroundColor:Color.fromARGB(255, 253, 141, 126),
                  elevation: 0,
                  title: Center(
                      child: Text("購物車",
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
                      document: gql(shoppingCartQuery),
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
                   /*if(result.data['ShoppingCart_aggregate']['aggregate']['count']==0) {
                      debugPrint("Nothing here!!!!!");
                      return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Expanded(
                                  child: Container(
                                      height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                          Container(
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
                                                    '還沒加入任何商品',
                                                    style: TextStyle(fontSize:18,color: Colors.black87.withOpacity(0.6),)
                                                ),
                                                SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                                              ],
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                  height: MediaQuery.of(context).size.height*0.3,
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  ImageIcon(AssetImage("assets/images/coupon.png"),
                                                                      color:Color.fromARGB(255, 253, 141, 126), size: 20),
                                                                  SizedBox(width:10),
                                                                  Text("折價券",
                                                                    style: TextStyle
                                                                      (color: Colors.black54,
                                                                        fontSize: 15),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            if(selectedIndexList.isNotEmpty)
                                                              GestureDetector(
                                                                child: Row(
                                                                  children: [
                                                                    Text("選擇折價券", style: TextStyle(color: Colors.black54, fontSize: 15),),
                                                                    Icon(Icons.arrow_right,color:Color.fromARGB(255, 253, 141, 126),)
                                                                  ],
                                                                ),
                                                                onTap: (){
                                                                  Navigator.of(context).pushAndRemoveUntil(
                                                                      CupertinoPageRoute(
                                                                          builder: (context)=>stateCartCouponListWidget()
                                                                      ), (Route<dynamic>route)=>true
                                                                  );

                                                                },
                                                              ),
                                                            if(selectedIndexList.isEmpty)
                                                              GestureDetector(
                                                                child: Row(
                                                                  children: [
                                                                    Text("尚未選擇商品", style: TextStyle(color: Colors.black54, fontSize: 15),),
                                                                    Icon(Icons.arrow_right,color:Color.fromARGB(255, 253, 141, 126),)
                                                                  ],
                                                                ),
                                                                onTap: (){

                                                                },
                                                              )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image(
                                                              image: new AssetImage("assets/images/p.png"),
                                                              height: MediaQuery.of(context).size.height*0.025,
                                                              width: MediaQuery.of(context).size.width*0.05,
                                                              color: null,
                                                              fit: BoxFit.scaleDown,
                                                            ),
                                                            SizedBox(width:10),
                                                            Query(
                                                              options: QueryOptions(
                                                                  document: gql(getMemberPoints),
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
                                                                    height: MediaQuery.of(context).size.height,
                                                                    width: MediaQuery.of(context).size.width,
                                                                    constraints: BoxConstraints.expand(),
                                                                    child: SpinKitPouringHourGlassRefined(
                                                                      color: Color.fromARGB(255, 253, 141, 126),
                                                                      size: 50.0,
                                                                    ),

                                                                  );
                                                                }
                                                                return Text("現有 "+0.toString()+" GoMartPoints",
                                                                  style: TextStyle
                                                                    (color: Colors.black54,
                                                                      fontSize: 15),
                                                                );
                                                              },
                                                            ),
                                                            Spacer(),
                                                            Container(
                                                                height: MediaQuery.of(context).size.height*0.065,
                                                                width: MediaQuery.of(context).size.width*0.3,
                                                                child: Padding(
                                                                    padding:  EdgeInsets.all(8),
                                                                    child: Form(
                                                                        child: selectedIndexList.isNotEmpty?
                                                                        TextFormField(
                                                                          controller: pointsController,
                                                                          keyboardType: TextInputType.number,
                                                                          decoration: InputDecoration(
                                                                            border: OutlineInputBorder(),
                                                                            labelText: '折抵點數',
                                                                          ),
                                                                          onEditingComplete: (){
                                                                            setState(() {

                                                                            });
                                                                          },
                                                                        ):
                                                                        TextFormField(
                                                                          controller: pointsController,
                                                                          enabled: false,
                                                                          keyboardType: TextInputType.number,
                                                                          decoration: InputDecoration(
                                                                            border: OutlineInputBorder(),
                                                                            labelText: '折抵點數',
                                                                          ),
                                                                          onEditingComplete: (){
                                                                            setState(() {
                                                                              pointsController.clear();

                                                                            });
                                                                          },
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [

                                                            FutureBuilder<List<int>>(
                                                              future: getTotal(),
                                                              builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                                                                if (snapshot.hasData) {
                                                                  double total = snapshot.data.fold(0, (a, b) => a + b);
                                                                  int points = int.parse(pointsController.text);
                                                                  if (total < 1) {
                                                                    return Text('總金額: 0', style: TextStyle(fontSize: 20),);
                                                                  }
                                                                  if (usingItemCouponValueList.isEmpty || pointsController.text.isEmpty) {
                                                                    return Text('總金額: ${(total)}', style: TextStyle(fontSize: 20));
                                                                  }
                                                                  if(pointsController.text.isNotEmpty || points>total){
                                                                    return Text('總金額: ${(points>total? 0 : total-points)}',style: TextStyle( fontSize: 20),);
                                                                  }
                                                                  if(pointsController.text.isNotEmpty || points<total){
                                                                    return Text('總金額: ${(total-points)}',style: TextStyle( fontSize: 20),);
                                                                  }
                                                                  if(usingItemCouponValueList.isNotEmpty){
                                                                    return Text('總金額: ${(total)}',style: TextStyle( fontSize: 20),);
                                                                  }
                                                                  if (selectedIndexList.isEmpty) {
                                                                    return Text('總金額: 0', style: TextStyle(fontSize: 20));
                                                                  }

                                                                }

                                                                if (snapshot.hasError){
                                                                  debugPrint(snapshot.error.toString());
                                                                  return Text('總金額:Has ERROR',style: TextStyle( fontSize: 20),);
                                                                }

                                                                return Center(child: CircularProgressIndicator());
                                                              },
                                                            ),
                                                            SizedBox(width:10),
                                                            Container(
                                                                height: MediaQuery.of(context).size.height*0.035,
                                                                color: Color.fromARGB(255, 253, 141, 126),
                                                                child: Center(
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.all(3.0),
                                                                        child: GestureDetector(
                                                                          child: Text("去買單"+"("+selectedIndexList.length.toString()+")",style:TextStyle( color:Colors.white),),
                                                                          onTap: (){


                                                                            itemSelected=selectedIndexList;

                                                                            if(couponSelected.isNotEmpty){
                                                                              for(int i=0; i< itemSelected.length;i++){
                                                                                if(result.data['ShoppingCart'][i]['Discount_aggregate']['aggregate']['count']!=0){

                                                                                  if(itemSelected.contains(1)){
                                                                                    debugPrint( '第'+selectedIndexList[i].toString()+'沒選折價');
                                                                                  }

                                                                                  for(int i=0; i<couponSelected.length;i++){
                                                                                    usingItemCouponValueList.remove(i);
                                                                                    usingItemCouponValueList.insert(i, result.data['ShoppingCart'][i]['Model'][i]['discount']['coupons']);
                                                                                    debugPrint("已選折扣 插入數值"+result.data['ShoppingCart'][i]['Model'][i]['discount']['coupons'].toString());
                                                                                  }
                                                                                }
                                                                                debugPrint("現有折扣數 "+couponSelected.length.toString());
                                                                                debugPrint('在第'+usingItemCouponValueList.indexWhere((e)=>e== 1).toString()+'個項目為1');

                                                                              }
                                                                            }


                                                                            if(couponSelected.isEmpty){
                                                                              for(int i=0; i< itemSelected.length;i++){
                                                                                if(result.data['ShoppingCart'][i]['Discount_aggregate']['aggregate']['count']!=0){
                                                                                  // usingItemCouponValueList.insert(i, 1);
                                                                                  for(int i=0; i<couponSelected.length;i++){
                                                                                    debugPrint("未選折扣 未插入數值"+result.data['ShoppingCart'][i]['Model'][i]['discount']['coupons'].toString());
                                                                                  }
                                                                                }

                                                                                /* if(result.data['ShoppingCart'][i]['Discount_aggregate']['aggregate']['count']==0){
                                                                            // usingItemCouponValueList.insert(i, 1);
                                                                            for(int i=0; i<couponSelected.length;i++){
                                                                              debugPrint("未選折扣  插入數值"+1.toString() );
                                                                              usingItemCouponValueList.insert(i, 1);
                                                                            }
                                                                          }*/
                                                                              }
                                                                            }

                                                                            debugPrint('折扣狀態'+usingItemCouponValueList.toList().toString());




                                                                            if(selectedIndexList.isEmpty)
                                                                            {
                                                                              debugPrint("current IndexList is null");
                                                                            }
                                                                            if(selectedIndexList.isNotEmpty)
                                                                            {
                                                                              debugPrint("currentIndexList "+selectedIndexList.toString());
                                                                            }






                                                                          },
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              )
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              )
                          )
                      );
                    };*/





                    return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Expanded(
                                child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                        Container(
                                            height: MediaQuery.of(context).size.height*0.625,
                                            child: Container(
                                                height: MediaQuery.of(context).size.height*0.625,
                                                child: ListView.builder(
                                                    itemCount: result.data['ShoppingCart_aggregate']['aggregate']['count'],
                                                    itemBuilder: (BuildContext ctx, index) {
                                                      cartModelNo= result.data['ShoppingCart'][index]['No'];
                                                      return SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  GestureDetector(
                                                                      child: Container(
                                                                        width:MediaQuery.of(context).size.width,
                                                                        height: MediaQuery.of(context).size.height*0.145,
                                                                        decoration: new BoxDecoration(
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
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            Align(
                                                                              alignment: Alignment.center,
                                                                              child:IconTheme(
                                                                                data: IconThemeData(color: Color.fromARGB(255, 253, 141, 126),),
                                                                                child: IconButton(
                                                                                  icon: selectedIndexList.contains(index) ? Icon(Icons.check_box):Icon(Icons.check_box_outline_blank),
                                                                                  onPressed: ()async{
                                                                                    if (!selectedIndexList.contains(index)) {
                                                                                      selectedIndexList.add(index);
                                                                                      setState(() {
                                                                                        unitPrice.add(result.data['ShoppingCart'][index]['Model'][0]['price']['priceOriginal']);
                                                                                        int parse = int.parse(itemController[index].text);
                                                                                        amount.add(parse);
                                                                                        selectedItemCouponIDList.add(result.data['ShoppingCart'][index]['Model'][0]['modelID']);




                                                                                        /*if(selectedIndexList.isEmpty){
                                                                                      for(int i=0; i<result.data['ShoppingCart_aggregate']['aggregate']['count'];i++){
                                                                                        usingItemCouponValueList.insert(i, 1);
                                                                                      }
                                                                                    }




                                                                                    itemSelected=selectedIndexList;

                                                                                    if(couponSelected.isNotEmpty){
                                                                                      for(int i=0; i< itemSelected.length;i++){
                                                                                        if(result.data['ShoppingCart'][i]['Discount_aggregate']['aggregate']['count']!=0){

                                                                                          if(itemSelected.contains(1)){
                                                                                            debugPrint( '第'+selectedIndexList[i].toString()+'沒選折價');
                                                                                          }

                                                                                          for(int i=0; i<couponSelected.length;i++){
                                                                                            usingItemCouponValueList.remove(i);
                                                                                            usingItemCouponValueList.insert(i, result.data['ShoppingCart'][i]['Model'][i]['discount']['coupons']);
                                                                                            debugPrint("已選折扣 插入數值"+result.data['ShoppingCart'][i]['Model'][i]['discount']['coupons'].toString());
                                                                                          }
                                                                                        }
                                                                                        debugPrint("現有折扣數 "+couponSelected.length.toString());
                                                                                        debugPrint('在第'+usingItemCouponValueList.indexWhere((e)=>e== 1).toString()+'個項目為1');

                                                                                      }
                                                                                    }


                                                                                    if(couponSelected.isEmpty){
                                                                                      for(int i=0; i< itemSelected.length;i++){
                                                                                        if(result.data['ShoppingCart'][i]['Discount_aggregate']['aggregate']['count']!=0){
                                                                                          // usingItemCouponValueList.insert(i, 1);
                                                                                          for(int i=0; i<couponSelected.length;i++){
                                                                                            debugPrint("未選折扣 未插入數值"+result.data['ShoppingCart'][i]['Model'][i]['discount']['coupons'].toString());
                                                                                          }
                                                                                        }

                                                                                        /* if(result.data['ShoppingCart'][i]['Discount_aggregate']['aggregate']['count']==0){
                                                                            // usingItemCouponValueList.insert(i, 1);
                                                                            for(int i=0; i<couponSelected.length;i++){
                                                                              debugPrint("未選折扣  插入數值"+1.toString() );
                                                                              usingItemCouponValueList.insert(i, 1);
                                                                            }
                                                                          }*/
                                                                                      }
                                                                                    }

                                                                                    debugPrint('折扣狀態'+usingItemCouponValueList.toList().toString());*/

                                                                                        /* if(result.data['ShoppingCart'][index]['Discount_aggregate']['aggregate']['count']==0){
                                                                                      debugPrint(index.toString()+ ' has no coupon');
                                                                                      usingItemCouponValueList.insert(index, 1);
                                                                                    }*/

                                                                                        /* if(result.data['ShoppingCart'][index]['Discount_aggregate']['aggregate']['count']!=0){
                                                                                      debugPrint(index.toString()+ ' has coupon');
                                                                                      debugPrint("Value is "+ result.data['ShoppingCart'][index]['Model'][index]['discount']['coupons'].toString());
                                                                                      usingItemCouponValueList.insert(index, result.data['ShoppingCart'][index]['Model'][index]['discount']['coupons']);
                                                                                    }*/

                                                                                        /*if(couponSelected.isNotEmpty){

                                                                                      if(result.data['ShoppingCart'][index]['Discount_aggregate']['aggregate']['count']==0){
                                                                                        usingItemCouponValueList.insert(index, 1);
                                                                                      }
                                                                                      usingItemCouponValueList.insert(index, result.data['ShoppingCart'][index]['Model'][index]['discount']['coupons']);
                                                                                    }*/

                                                                                        /*  if(couponSelected.isNotEmpty) {

                                                                                     // usingItemCouponValueList.remove(index);
                                                                                     // usingItemCouponValueList.insert(couponSelected[index], result.data['ShoppingCart'][index]['Model'][index]['discount']['coupons']);


                                                                                    }*/

                                                                                        /* if(couponSelected.isEmpty){
                                                                                    usingItemCouponValueList.insert(index, 1);
                                                                                    }*/

                                                                                      });
                                                                                    }
                                                                                    else {
                                                                                      selectedIndexList.remove(index);
                                                                                      setState(() {
                                                                                        removeItem(index);
                                                                                        selectedItemCouponID='';
                                                                                        selectedItemCouponIDList.remove(result.data['ShoppingCart'][index]['Model'][0]['modelID']);

                                                                                        //  usingItemCouponValueList.remove(index);


                                                                                        /* if(couponSelected.isNotEmpty){
                                                                                      for(int i=0; i< itemSelected.length;i++){
                                                                                        if(result.data['ShoppingCart'][i]['Discount_aggregate']['aggregate']['count']!=0){

                                                                                          for(int i=0; i<couponSelected.length;i++){
                                                                                            usingItemCouponValueList.remove(i);
                                                                                          }
                                                                                        }

                                                                                      }
                                                                                    }*/





                                                                                      });
                                                                                    }
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.center,
                                                                              width:MediaQuery.of(context).size.width*0.275,
                                                                              height: MediaQuery.of(context).size.height*0.5,
                                                                              decoration: new BoxDecoration(
                                                                                borderRadius:BorderRadius.only (
                                                                                  topLeft: const Radius.circular(15.0),
                                                                                  bottomLeft: const Radius.circular(15.0),
                                                                                ),

                                                                              ),
                                                                              child: Container(
                                                                                height: MediaQuery.of(context).size.height*0.15,
                                                                                width: MediaQuery.of(context).size.width*0.325,
                                                                                child: Image.memory(base64Decode(
                                                                                    result.data['ShoppingCart'][index]['Model'][index]['productLocation']['productThumnail']
                                                                                )),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                alignment: Alignment.center,
                                                                                width:MediaQuery.of(context).size.width*0.35,
                                                                                height: MediaQuery.of(context).size.height*0.5,
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text(
                                                                                      result.data['ShoppingCart'][index]['Model'][0]['modelName'],
                                                                                      style: TextStyle
                                                                                        (color: Colors.black54,
                                                                                          fontSize: 12),
                                                                                    ),
                                                                                    Text("\$"+result.data['ShoppingCart'][index]['Model'][0]['price']['priceOriginal'].toString(),
                                                                                      style: TextStyle
                                                                                        (color:Color.fromARGB(255, 253, 141, 126), fontSize: 18),
                                                                                    ),
                                                                                    Container(
                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Container(
                                                                                              child: IconTheme(
                                                                                                  data: IconThemeData(color: Color.fromARGB(255, 253, 141, 126),),
                                                                                                  child: IconButton(
                                                                                                    icon: Icon(Icons.indeterminate_check_box_rounded),
                                                                                                    onPressed: (){
                                                                                                      int currentValue = int.parse(itemController[index].text);
                                                                                                      setState(() {
                                                                                                        currentValue--;
                                                                                                        itemController[index].text = (currentValue > 0 ? currentValue : 1).toString();
                                                                                                      });
                                                                                                    },
                                                                                                  )
                                                                                              )
                                                                                          ),
                                                                                          Container(
                                                                                              height: MediaQuery.of(context).size.height*0.05,
                                                                                              width: MediaQuery.of(context).size.width*0.15,
                                                                                              child: TextField(
                                                                                                controller:itemController[index],
                                                                                                keyboardType: TextInputType.number,
                                                                                                decoration: InputDecoration(
                                                                                                  border: OutlineInputBorder(),
                                                                                                ),
                                                                                                onChanged: (text){
                                                                                                  setState(() {
                                                                                                    debugPrint(itemController.toString());
                                                                                                    debugPrint("INPUT"+itemController[index].text);

                                                                                                  });
                                                                                                },
                                                                                              )
                                                                                          ),
                                                                                          Container(
                                                                                              child: IconTheme(
                                                                                                  data: IconThemeData(color: Color.fromARGB(255, 253, 141, 126),),
                                                                                                  child: IconButton(
                                                                                                    icon: Icon(Icons.add_box),
                                                                                                    onPressed: (){
                                                                                                      int currentValue = int.parse(itemController[index].text);
                                                                                                      setState(() {
                                                                                                        currentValue++;
                                                                                                        itemController[index].text = (currentValue).toString();
                                                                                                      });
                                                                                                    },
                                                                                                  )
                                                                                              )
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Mutation(
                                                                              options: MutationOptions(
                                                                                  document: gql(deleteShoppingCartMuntation),
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
                                                                                    //  selectedIndexList.remove(index);
                                                                                      debugPrint('Item '+index.toString()+' is Deleted');

                                                                                     runMutation(
                                                                                          {
                                                                                            "No": cartModelNo
                                                                                          }
                                                                                      );

                                                                                      debugPrint("TEST------------");

                                                                                      debugPrint("Value    "+cartModelNo.toString());




                                                                                    }
                                                                                    setState(() {

                                                                                    });
                                                                                  },
                                                                                );
                                                                              },
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      onTap:() async {
                                                                      }
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                                            ],
                                                          )
                                                      );
                                                    }
                                                )
                                            )
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                                height: MediaQuery.of(context).size.height*0.3,
                                                width: MediaQuery.of(context).size.width,
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              children: [
                                                                ImageIcon(AssetImage("assets/images/coupon.png"),
                                                                    color:Color.fromARGB(255, 253, 141, 126), size: 20),
                                                                SizedBox(width:10),
                                                                Text("折價券",
                                                                  style: TextStyle
                                                                    (color: Colors.black54,
                                                                      fontSize: 15),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          if(selectedIndexList.isNotEmpty)
                                                            GestureDetector(
                                                              child: Row(
                                                                children: [
                                                                  Text("選擇折價券", style: TextStyle(color: Colors.black54, fontSize: 15),),
                                                                  Icon(Icons.arrow_right,color:Color.fromARGB(255, 253, 141, 126),)
                                                                ],
                                                              ),
                                                              onTap: (){
                                                                Navigator.of(context).pushAndRemoveUntil(
                                                                    CupertinoPageRoute(
                                                                        builder: (context)=>stateCartCouponListWidget()
                                                                    ), (Route<dynamic>route)=>true
                                                                );

                                                              },
                                                            ),
                                                          if(selectedIndexList.isEmpty)
                                                            GestureDetector(
                                                              child: Row(
                                                                children: [
                                                                  Text("尚未選擇商品", style: TextStyle(color: Colors.black54, fontSize: 15),),
                                                                  Icon(Icons.arrow_right,color:Color.fromARGB(255, 253, 141, 126),)
                                                                ],
                                                              ),
                                                              onTap: (){

                                                              },
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Image(
                                                            image: new AssetImage("assets/images/p.png"),
                                                            height: MediaQuery.of(context).size.height*0.025,
                                                            width: MediaQuery.of(context).size.width*0.05,
                                                            color: null,
                                                            fit: BoxFit.scaleDown,
                                                          ),
                                                          SizedBox(width:10),
                                                          Query(
                                                            options: QueryOptions(
                                                                document: gql(getMemberPoints),
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
                                                                  height: MediaQuery.of(context).size.height,
                                                                  width: MediaQuery.of(context).size.width,
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

                                                              return Text("現有 "+sum.toString()+" GoMartPoints",
                                                                style: TextStyle
                                                                  (color: Colors.black54,
                                                                    fontSize: 15),
                                                              );
                                                            },
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                              height: MediaQuery.of(context).size.height*0.065,
                                                              width: MediaQuery.of(context).size.width*0.3,
                                                              child: Padding(
                                                                  padding:  EdgeInsets.all(8),
                                                                  child: Form(
                                                                      child: selectedIndexList.isNotEmpty?
                                                                      TextFormField(
                                                                        controller: pointsController,
                                                                        keyboardType: TextInputType.number,
                                                                        decoration: InputDecoration(
                                                                          border: OutlineInputBorder(),
                                                                          labelText: '折抵點數',
                                                                        ),
                                                                        onEditingComplete: (){
                                                                          setState(() {

                                                                          });
                                                                        },
                                                                      ):
                                                                      TextFormField(
                                                                        controller: pointsController,
                                                                        enabled: false,
                                                                        keyboardType: TextInputType.number,
                                                                        decoration: InputDecoration(
                                                                          border: OutlineInputBorder(),
                                                                          labelText: '折抵點數',
                                                                        ),
                                                                        onEditingComplete: (){
                                                                          setState(() {
                                                                            pointsController.clear();

                                                                          });
                                                                        },
                                                                      )
                                                                  )
                                                              )
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [

                                                          FutureBuilder<List<int>>(
                                                            future: getTotal(),
                                                            builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                                                              if (snapshot.hasData) {
                                                                int total = snapshot.data.fold(0, (a, b) => a + b);
                                                                int points = int.parse(pointsController.text);
                                                                if (total < 1) {
                                                                  return Text('總金額: 0', style: TextStyle(fontSize: 20),);
                                                                }

                                                                if(pointsController.text.isNotEmpty || points>total){
                                                                  debugPrint('pointsController.text.isNotEmpty || points>total');
                                                                  debugPrint(

                                                                      pointsController.text.isNotEmpty.toString()
                                                                  );
                                                                  debugPrint(
                                                                      (points<total).toString()
                                                                  );
                                                                  return Text('總金額: ${(points>total? 0 : total-points)}',style: TextStyle( fontSize: 20),);
                                                                }
                                                                if(pointsController.text.isNotEmpty || points<total){
                                                                  debugPrint('pointsController.text.isNotEmpty || points<total');
                                                                  debugPrint(

                                                                      pointsController.text.isNotEmpty.toString()
                                                                  );
                                                                  debugPrint(
                                                                      (points<total).toString()
                                                                  );
                                                                  return Text('總金額: ${(total-points)}',style: TextStyle( fontSize: 20),);
                                                                }
                                                                if(usingItemCouponValueList.isNotEmpty){
                                                                  debugPrint('usingItemCouponValueList.isNotEmpty');
                                                                  debugPrint(

                                                                      pointsController.text.isNotEmpty.toString()
                                                                  );
                                                                  debugPrint(
                                                                      (points<total).toString()
                                                                  );
                                                                  return Text('總金額: ${(total)}',style: TextStyle( fontSize: 20),);
                                                                }
                                                                if (selectedIndexList.isEmpty) {
                                                                  debugPrint('selectedIndexList.isEmpty');
                                                                  debugPrint(
                                                                      pointsController.text.isNotEmpty.toString()
                                                                  );
                                                                  debugPrint(
                                                                      (points<total).toString()
                                                                  );
                                                                  return Text('總金額: 0', style: TextStyle(fontSize: 20));
                                                                }
                                                                if (usingItemCouponValueList.isEmpty || pointsController.text.isEmpty) {
                                                                  debugPrint('usingItemCouponValueList.isEmpty || pointsController.text.isEmpty');
                                                                  debugPrint(

                                                                      pointsController.text.isNotEmpty.toString()
                                                                  );
                                                                  debugPrint(
                                                                      (points<total).toString()
                                                                  );
                                                                  return Text('總金額: ${(total)}', style: TextStyle(fontSize: 20));
                                                                }

                                                              }

                                                              if (snapshot.hasError){
                                                                debugPrint(snapshot.error.toString());
                                                                return Text('總金額:Has ERROR',style: TextStyle( fontSize: 20),);
                                                              }

                                                              return Center(child: CircularProgressIndicator());
                                                            },
                                                          ),
                                                          SizedBox(width:10),
                                                          Container(
                                                              height: MediaQuery.of(context).size.height*0.035,
                                                              color: Color.fromARGB(255, 253, 141, 126),
                                                              child: Center(
                                                                  child: Padding(
                                                                      padding: const EdgeInsets.all(3.0),
                                                                      child: GestureDetector(
                                                                        child: Text("去買單"+"("+selectedIndexList.length.toString()+")",style:TextStyle( color:Colors.white),),
                                                                        onTap: (){


                                                                          itemSelected=selectedIndexList;

                                                                          if(couponSelected.isNotEmpty){
                                                                            for(int i=0; i< itemSelected.length;i++){
                                                                              if(result.data['ShoppingCart'][i]['Discount_aggregate']['aggregate']['count']!=0){

                                                                                if(itemSelected.contains(1)){
                                                                                  debugPrint( '第'+selectedIndexList[i].toString()+'沒選折價');
                                                                                }

                                                                                for(int i=0; i<couponSelected.length;i++){
                                                                                  usingItemCouponValueList.remove(i);
                                                                                  usingItemCouponValueList.insert(i, result.data['ShoppingCart'][i]['Model'][i]['discount']['coupons']);
                                                                                  debugPrint("已選折扣 插入數值"+result.data['ShoppingCart'][i]['Model'][i]['discount']['coupons'].toString());
                                                                                }
                                                                              }
                                                                              debugPrint("現有折扣數 "+couponSelected.length.toString());
                                                                              debugPrint('在第'+usingItemCouponValueList.indexWhere((e)=>e== 1).toString()+'個項目為1');

                                                                            }
                                                                          }


                                                                          if(couponSelected.isEmpty){
                                                                            for(int i=0; i< itemSelected.length;i++){
                                                                              if(result.data['ShoppingCart'][i]['Discount_aggregate']['aggregate']['count']!=0){
                                                                                // usingItemCouponValueList.insert(i, 1);
                                                                                for(int i=0; i<couponSelected.length;i++){
                                                                                  debugPrint("未選折扣 未插入數值"+result.data['ShoppingCart'][i]['Model'][i]['discount']['coupons'].toString());
                                                                                }
                                                                              }

                                                                              /* if(result.data['ShoppingCart'][i]['Discount_aggregate']['aggregate']['count']==0){
                                                                            // usingItemCouponValueList.insert(i, 1);
                                                                            for(int i=0; i<couponSelected.length;i++){
                                                                              debugPrint("未選折扣  插入數值"+1.toString() );
                                                                              usingItemCouponValueList.insert(i, 1);
                                                                            }
                                                                          }*/
                                                                            }
                                                                          }

                                                                          debugPrint('折扣狀態'+usingItemCouponValueList.toList().toString());




                                                                          if(selectedIndexList.isEmpty)
                                                                          {
                                                                            debugPrint("current IndexList is null");
                                                                          }
                                                                          if(selectedIndexList.isNotEmpty)
                                                                          {
                                                                            debugPrint("currentIndexList "+selectedIndexList.toString());
                                                                          }






                                                                        },
                                                                      )
                                                                  )
                                                              )
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            )
                                        )
                                      ],
                                    )
                                ),
                              ),
                            )
                        )
                    );
                  },
                ),
            )
        ),
      )
    );
  }
}




import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_mart_client/allFeatures/featureButtonHistory/historyList.dart';
import 'package:go_mart_client/allFeatures/featureButtonScanner/scanResult.dart';
import 'package:go_mart_client/product_Content/productContent.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:uuid/uuid.dart';

import '../../GraphQLConfig/GraphQLConfig.dart';
import '../../global.dart';
class stateMobileScannerWidget extends StatefulWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MobileScannerWidget();
  }
}
class MobileScannerWidget  extends State<stateMobileScannerWidget>{





  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode scannedResult;
  QRViewController controller;


  String  addScannedHistoryMuntation="""
  mutation addScannedHistory(\$No:uuid!,\$memberID:String!,\$modelID:uuid!) {
   insert_ScannedHistory(objects: {No: \$No, memberID: \$memberID, modelID: \$modelID}) {
  
  }
  
}""";


  String  addScannedHistoryAndMemberDiscountMuntation="""
  mutation addScannedHistoryAndMemberDiscount(\$No:uuid!,\$memberID:String!,\$modelID:uuid!) {
   insert_ScannedHistory(objects: {No: \$No, memberID: \$memberID, modelID: \$modelID}) {
  
  }
  
  insert_MemeberDiscount(objects: {No: \$No, memberID: \$memberID, modelID: \$modelID}) {
  
  }
  
}""";








  @override
  Widget build(BuildContext context) =>CupertinoPageScaffold (
    child: GraphQLProvider(
        client: GraphQLConfiguration.client,
      child: SafeArea(
          child: Scaffold(
              appBar:AppBar(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                title: Center(
                    child: Text("掃一掃",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Noto Sans",
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    )
                ),
              ),
              body: Container(
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        flex: 6,
                        child:Stack(
                            children: <Widget>[
                              _QRView(),
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset('assets/images/scannerBoarder.png',fit: BoxFit.contain,),),
                            ]
                        )
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.01,
                      color: Colors.black,
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                          color: Colors.black,
                          alignment:Alignment.bottomCenter,
                          child: Column(
                            children: [
                              (scannedResult != null) ? Container
                                (
                                  color: Colors.white,
                                  child: Mutation(
                                    options: MutationOptions(
                                        document: gql(addScannedHistoryAndMemberDiscountMuntation),
                                        onError: (result){
                                          debugPrint(result?.graphqlErrors.toString());
                                          debugPrint(result?.linkException.toString());
                                        }
                                    ),
                                    builder: (
                                        MultiSourceResult<Object> Function(Map<String, dynamic>, {Object optimisticResult})
                                        runMutation,
                                        QueryResult<Object> result) {
                                      return CupertinoActionSheet(
                                        title: Text("掃描成功",style: TextStyle(fontSize:18,color:Colors.black38),),
                                        message: Text("已儲存於瀏覽紀錄",style: TextStyle(color:Colors.black38)),
                                        actions: <Widget>[
                                          CupertinoActionSheetAction(
                                              child:  Text('繼續掃描',style: TextStyle(fontSize: 12,color: Colors.blue),),
                                              onPressed:(){
                                                debugPrint('Barcode Type: ${describeEnum(scannedResult.format)}\nData: ${scannedResult.code}');

                                                globalScanModelID=scannedResult.code;
                                                scannedModelID = Uuid().v4();

                                                runMutation(
                                                    {
                                                      "No": scannedModelID,
                                                      "modelID": globalScanModelID,
                                                      "memberID":appUserID,
                                                    }
                                                );

                                                setState(() {
                                                  scannedResult=null;
                                                });
                                              }
                                          ),
                                          CupertinoActionSheetAction(
                                              child:  Text('前往歷史紀錄',style: TextStyle(fontSize: 12,color: Colors.blue),),
                                              onPressed:(){
                                                debugPrint('Barcode Type: ${describeEnum(scannedResult.format)}\nData: ${scannedResult.code}');

                                                globalScanModelID=scannedResult.code;
                                                scannedModelID = Uuid().v4();

                                                runMutation(
                                                    {

                                                      "No": scannedModelID,
                                                      "modelID": globalScanModelID,
                                                      "memberID":appUserID,
                                                    }
                                                );

                                                setState(() {
                                                  scannedResult!=null;
                                                });
                                                Navigator.of(context).pushAndRemoveUntil(
                                                    CupertinoPageRoute(
                                                        builder: (context)=>stateHistoryListWidget()
                                                    ),(Route<dynamic>route)=>true
                                                );
                                              }
                                          ),
                                          CupertinoActionSheetAction(
                                              child: Text('查看商品',style: TextStyle(fontSize: 12,color: Colors.blue),),
                                              onPressed:() {
                                                debugPrint('Barcode Type: ${describeEnum(scannedResult.format)}\nData: ${scannedResult.code}');

                                                globalScanModelID=scannedResult.code;
                                                scannedModelID = Uuid().v4();

                                                runMutation(
                                                    {

                                                      "No": scannedModelID,
                                                      "modelID": globalScanModelID,
                                                      "memberID":appUserID,
                                                    }
                                                );

                                                setState(() {
                                                  scannedResult!=null;
                                                });
                                                Navigator.of(context).push(
                                                  CupertinoPageRoute(
                                                      builder: (context)=>stateScanResult()
                                                  ),
                                                );
                                              }
                                          ),
                                        ],
                                      );
                                    },
                                  )
                              ) : Text('請將二維條碼對準辨識框',style: TextStyle(color: Colors.white),),
                            ],
                          )
                      )

                    )
                  ],
                ),
              )
          )
      )
    )
  );

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedResult = scanData;
      });
    });
  }
  Widget _QRView()
  {
    return QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
    );
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

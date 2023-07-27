
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_mart_client/home_page_widget/home_page_widget.dart';
import 'package:go_mart_client/product_Content/productContent.dart';

class stateAreaNotificationWidget extends StatefulWidget{
  const stateAreaNotificationWidget({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AreaNotificationWidget();
  }
}

List<String> coupons = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
];
List<String> name = [
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
];

List<IconData> icons = [
  Icons.timelapse,
  Icons.sell,
  Icons.recommend,
];



class AreaNotificationWidget extends State<stateAreaNotificationWidget> with AutomaticKeepAliveClientMixin{
  @override
  // implement wantKeepAlive
  bool get wantKeepAlive => true;
  final List<Map> SelectItem =
  List.generate(coupons.length, (index) => {"id": index, name: "$index"}).toList();
  List<int> selectedIndexList = new List<int>();




  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      child: SafeArea(
          child: Scaffold(
              appBar:AppBar(
                backgroundColor:Color.fromARGB(255, 253, 141, 126),
                elevation: 0,
                title: Center(
                    child: Text("購物小幫手",
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
                  child: ListView.builder(
                      itemCount: SelectItem.length,
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
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
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
                                                  color: Color.fromARGB(255, 250, 169, 161),
                                                ),
                                                child: Icon(icons[0],size: 50,color: Colors.white,)
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width:MediaQuery.of(context).size.width*0.6,
                                              height: MediaQuery.of(context).size.height*0.5,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("Title",
                                                    style: TextStyle
                                                      (color: Colors.black54,
                                                        fontSize: 20),
                                                  ),
                                                  Text("SubTitle",
                                                    style: TextStyle
                                                      (color: Colors.black54,
                                                        fontSize: 15),
                                                  ),
                                                  Text("YY/MM/DD HH/MM/SS",
                                                    style: TextStyle
                                                      (color: Colors.black54.withOpacity(0.35),
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
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
                  ),
                ),

              )
          )
      ),
    );
  }
}
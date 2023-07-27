
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_mart_client/allFeatures/featureButtonMemo/screens/note_list.dart';

class stateMemoWidget extends StatefulWidget{
  const stateMemoWidget({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MemoWidget();
  }
}
class MemoWidget extends State<stateMemoWidget> with AutomaticKeepAliveClientMixin{
  @override
  // implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) =>CupertinoPageScaffold(

    child: SafeArea(
        child: Scaffold(
          appBar:AppBar(
            backgroundColor:Color.fromARGB(255, 253, 141, 126),
            elevation: 0,
            title: Center(
                child: Text("購物便籤",
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
            child: const NoteList(),


          ),
        )
    ),


  );

}
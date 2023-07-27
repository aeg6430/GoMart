import 'package:delayed_display/delayed_display.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_mart_client/global.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import "package:ntp/ntp.dart";
import 'package:uuid/uuid.dart';
import 'dart:async';

import '../../GraphQLConfig/GraphQLConfig.dart';


class stateGamePageWidget extends StatefulWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp( );
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GamePageWidget();
  }
}
class TextWidget extends StatefulWidget {
  final Key key;

  const TextWidget(this.key);

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  String text = " ";

  void onPressed(int count,var point) {

    setState((){
      text = ('剩餘次數:$count\n獲得點數:$point');

    });
  }

  @override
  Widget build(BuildContext context) {
    return new Text(text,style: TextStyle(fontSize: 20));
  }
}
//時間
/*Future<void> NetTime() async {
    _checkTime('pool.ntp.org');
  }*/
Future<void>_checkTime(String lookupAddress,String str1,int i) async {
  DateTime _myTime;
  DateTime _ntpTime;
  int timeStamp;
  var oldDate=1;//從資料庫抓取上次抽點數的時間戳
  /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
  _myTime = DateTime.now();

  /// Or get NTP offset (in milliseconds) and add it yourself
  final int offset = await NTP.getNtpOffset(localTime: _myTime, lookUpAddress: lookupAddress);

  _ntpTime = _myTime.add(Duration(milliseconds: offset));

  timeStamp=_ntpTime.microsecondsSinceEpoch;

  print(timeStamp);
  print('\n $lookupAddress');
  print('Time: $_ntpTime');

  /* date=_ntpTime.day ;
    print('Day: $date');*/

  if(timeStamp>=oldDate+86400){
    //將點數、剩餘次數、時間輸入進資料庫
  }



}



class GamePageWidget extends State<stateGamePageWidget>{
  List<bool> cardFlips = [true,true,true,true,true,true,true,true,true,];
  List<String> data = ["10","15","20","25","30","50","5","35","40"];//點數內容

  int i=0;//抓資料庫的剩餘次數
  var points=' ';//存放點數的變數
  GlobalKey<_TextWidgetState> textKey = GlobalKey();//翻牌後呼叫
  @override
  void check(String lookupAddress) async{ //抓取時間比照，若是換日則剩餘次數加1
    DateTime _myTime;
    DateTime _ntpTime;
    int timeStamp;

    var oldDate=0;//從資料庫抓取上次抽點數的時間戳
    /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
    _myTime = DateTime.now();
    /// Or get NTP offset (in milliseconds) and add it yourself
    final int offset = await NTP.getNtpOffset(localTime: _myTime, lookUpAddress:lookupAddress);
    _ntpTime = _myTime.add(Duration(milliseconds: offset));
    timeStamp=_ntpTime.microsecondsSinceEpoch;


    setState((){
    if(timeStamp>=oldDate+86400){
       i++;//抽獎次數增加
       cardFlips = [true,true,true,true,true,true,true,true,true,];
    }
  });
  }
  @override
  void initState() {

 check('pool.ntp.org');

    data.shuffle();//洗牌
    if (i <= 0) {//初始剩餘次數小於等於0的情況下禁止翻牌
        cardFlips = [false,false,false,false,false,false,false,false,false,];
      };
    super.initState();
  }

  /*String  addGamePointsMuntation="""
  mutation addGamePoints(\$gameID:uuid!,\$memberID:String!,\$points:float8!,\$No:uuid!) {
    insert_GamePoints(objects: {gameID: \$gameID, memberID: \$memberID, points: \$points}) {
    affected_rows
  }
  insert_MemeberDiscount(objects: {gameID: \$gameID, memberID: \$memberID, No: \$No}) {
    affected_rows
  }
}""";*/

  String  addGamePointsMuntation="""
  mutation addGamePoints(\$gameID:uuid!,\$memberID:String!,\$points:float8!) {
    insert_GamePoints(objects: {gameID: \$gameID, memberID: \$memberID, points: \$points}) {
    affected_rows
  }
 
}""";


  Widget build(BuildContext context) {
    textKey.currentState?.onPressed(i,points);
    return GraphQLProvider(
        client: GraphQLConfiguration.client,
      child: CupertinoPageScaffold(
          child: SafeArea(
              child: Scaffold(
                appBar:AppBar(
                  backgroundColor:Color.fromARGB(255, 253, 141, 126),
                  elevation: 0,
                  title: Center(
                      child: Text("小遊戲",
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
                  child: Mutation(
                    options: MutationOptions(
                        document: gql(addGamePointsMuntation),
                        onError: (result){
                          debugPrint(result?.graphqlErrors.toString());
                          debugPrint(result?.linkException.toString());
                        }
                    ),
                    builder: (
                        MultiSourceResult<Object> Function(Map<String, dynamic>, {Object optimisticResult})
                        runMutation,
                        QueryResult<Object> result) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:<Widget>[
                          GridView.builder(
                            itemCount: 9,//卡片數量
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            //翻牌
                            itemBuilder: (context, index) => FlipCard(
                                direction: FlipDirection.HORIZONTAL,
                                flipOnTouch: cardFlips[index],
                                front: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/images/cover1.gif',
                                    fit:BoxFit.fill,
                                    height: MediaQuery.of(context).size.height*0.4,
                                  ),
                                ),
                                back: DelayedDisplay(
                                  delay: Duration(seconds: 8),
                                  child:  Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 253, 141, 126).withOpacity(0.7),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    margin: EdgeInsets.all(12.0),
                                    child: Center(
                                      child: Text(
                                          "${data[index]}",
                                          style: TextStyle(color: Colors.black54,fontSize: 35)
                                      ),
                                    ),
                                  ),
                                ),
                                //點擊後翻牌所得的資訊
                                onFlip: () {
                                  i--; //剩餘次數-1
                                  points = data[index]; //抽到的點數

                                  debugPrint("第" + index.toString() + "號卡牌作動" + " 數值:" + data[index].toString());

                                  gameID = Uuid().v4();
                                  discountGameID = Uuid().v4();

                                  /*runMutation(
                                      {
                                        "memberID":appUserID,
                                        "gameID": gameID,
                                        "No": discountGameID,
                                        "points": points,
                                      }
                                  );*/

                                  runMutation(
                                      {
                                        "memberID":appUserID,
                                        "gameID": gameID,
                                        "points": points,
                                      }
                                  );

                                  //點數剩餘次數資訊(方法)
                                  var emp = new GamePageWidget();
                                  emp.points=points;
                                  emp.i=i;
                                  emp.showPoint();

                                  //NetTime();
                                  _checkTime('pool.ntp.org',points,i);

                                  //於畫面顯示點數資訊
                                  textKey.currentState?.onPressed(i,points);//呼叫點數值

                                  setState((){
                                    if (i <= 0) {
                                      cardFlips = [false,false,false,false,false,false,false,false,false,];
                                    };
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          elevation: 2,
                                          child: Container(
                                            width: MediaQuery.of(context).size.width*0.3,
                                            height: MediaQuery.of(context).size.height*0.3,
                                            decoration: new BoxDecoration(
                                                color: Color.fromARGB(255, 253, 141, 126),
                                                borderRadius:BorderRadius.all(Radius.circular(10))
                                            ),
                                            child: Stack(
                                              children: [

                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    child: Stack(
                                                      alignment: Alignment.center,
                                                      //mainAxisAlignment: MainAxisAlignment.center,
                                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Align(

                                                          alignment: Alignment.center,
                                                          child: Image.asset(
                                                            'assets/images/openbox-unscreen.gif',
                                                            fit:BoxFit.fill,
                                                            height: MediaQuery.of(context).size.height*0.3,

                                                          ),
                                                        ),
                                                        DelayedDisplay(
                                                          delay: Duration(seconds: 8),
                                                          child:Align(
                                                              alignment: Alignment.center,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    '獲得點數:',
                                                                    style: TextStyle(
                                                                        fontSize: 25,
                                                                        color: Colors.white
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    points,
                                                                    style: TextStyle(
                                                                        fontSize: 45,
                                                                        color: Colors.white
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '今日次數 ('+i.toString()+"/"+(i+1).toString()+')',
                                                                    style: TextStyle(
                                                                        fontSize: 15,
                                                                        color: Colors.white
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  );




                                }
                            ),
                          ),
                          Text('抽抽樂',style: TextStyle(fontSize: 30,color: Colors.black54),),
                          Text('請從上方選取一張卡片',style: TextStyle(fontSize: 25,color: Colors.black54)),
                          //TextWidget(textKey),//顯示剩餘次數&點數
                        ],
                      );
                    },
                  )
                ),
              )
          )
      )
    );
  }
  showPoint() {
    print("點數${points}");
    print("剩餘次數${i}");
  }
}




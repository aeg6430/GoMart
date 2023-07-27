
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class stateSettingAreaNotificationPageWidget extends StatefulWidget{
  const stateSettingAreaNotificationPageWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingAreaNotificationPageWidget();
  }
}
class SettingAreaNotificationPageWidget extends State<stateSettingAreaNotificationPageWidget>with AutomaticKeepAliveClientMixin<stateSettingAreaNotificationPageWidget>  {

   bool onSaleNotification,
       activityNotification,
       personalizeNotification;

  @override
  void initState() {
    onSaleNotification = Global1.shared.onSaleNotification;
    activityNotification = Global2.shared.activityNotification;
    personalizeNotification = Global3.shared.personalizeNotification;
    super.initState();
  }

  @override
    Widget build(BuildContext context)=>CupertinoPageScaffold (
       child: SafeArea(
        child:Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 253, 141, 126),
            elevation: 0,
            title: Center(
                child: Text("管理購物小幫手",
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
                crossAxisAlignment: CrossAxisAlignment.center,

                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height*0.8,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),

                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24.0),
                          topLeft: Radius.circular(24.0),
                        )
                    ),
                    child: Column(

                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            child: Image.asset(
                              "assets/images/logos.png",
                              fit: BoxFit.cover,),
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.075,
                          color: Colors.white,
                          child: Row(
                            children: [
                                  SizedBox(width:MediaQuery.of(context).size.width*0.001),
                                  IconButton(
                                  icon: Icon(Icons.sell,
                                      size: 35,color:Colors.white70),
                                  onPressed:(){}
                                  ),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.05),
                                  Text('商品特價通知',
                                  style: TextStyle(
                                    fontFamily: "Noto Sans",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color:Colors.black54.withOpacity(0.5)
                                    ),
                                  ),
                                  SizedBox(width:MediaQuery.of(context).size.width*0.3),
                                  Switch(value: onSaleNotification,
                                  onChanged: (bool isEnabled) {

                                    setState(() {
                                      onSaleNotification = isEnabled;
                                      Global1.shared.onSaleNotification = isEnabled;
                                      isEnabled =!isEnabled;
                                    });
                                  },
                                  activeColor: Color.fromARGB(255, 253, 141, 126),
                                )
                            ],
                          ),
                        ),
                        SizedBox(height:MediaQuery.of(context).size.height*0.005),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.075,
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(width:MediaQuery.of(context).size.width*0.001),
                              IconButton(
                                  icon: Icon(Icons.timelapse,
                                      size: 35,color:Colors.white70),
                                  onPressed:(){}
                              ),
                              SizedBox(width:MediaQuery.of(context).size.width*0.05),
                              Text('賣場活動通知',
                                style: TextStyle(
                                    fontFamily: "Noto Sans",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color:Colors.black54.withOpacity(0.5)
                                ),
                              ),
                              SizedBox(width:MediaQuery.of(context).size.width*0.3),
                              Switch(value: activityNotification,
                                onChanged: (bool isEnabled) {

                                  setState(() {
                                    activityNotification = isEnabled;
                                    Global2.shared.activityNotification = isEnabled;
                                    isEnabled =!isEnabled;
                                  });
                                },
                                activeColor: Color.fromARGB(255, 253, 141, 126),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height:MediaQuery.of(context).size.height*0.005),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.075,
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(width:MediaQuery.of(context).size.width*0.001),
                              IconButton(
                                  icon: Icon(Icons.recommend,
                                      size: 35,color:Colors.white70),
                                  onPressed:(){}
                              ),
                              SizedBox(width:MediaQuery.of(context).size.width*0.05),
                              Text('商品推薦通知',
                                style: TextStyle(
                                    fontFamily: "Noto Sans",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color:Colors.black54.withOpacity(0.5)
                                ),
                              ),
                              SizedBox(width:MediaQuery.of(context).size.width*0.3),
                              Switch(value: personalizeNotification,
                                onChanged: (bool isEnabled) {

                                  setState(() {
                                    personalizeNotification = isEnabled;
                                    Global3.shared.personalizeNotification = isEnabled;
                                    isEnabled =!isEnabled;
                                  });
                                },
                                activeColor: Color.fromARGB(255, 253, 141, 126),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
          ),
        )
       )
      );

  @override
  // implement wantKeepAlive
  bool get wantKeepAlive => true;
  }
class Global1{
  static final shared =Global1();
  bool onSaleNotification = true;
}
class Global2{
  static final shared =Global2();
  bool activityNotification = true;
}
class Global3{
  static final shared =Global3();
  bool personalizeNotification = true;
}





 



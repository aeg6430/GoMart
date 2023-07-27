import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofence/Geolocation.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_mart_client/loadingPage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


import '../GraphQLConfig/GraphQLConfig.dart';
import '../area_notification_page_widget/areaNotification.dart';
import '../global.dart';
import '../product_Content/productContent.dart';
import 'eventContent.dart';

class stateGenerateAreaSelectItemWidget extends StatefulWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp();
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return generateAreaSelectItemWidget();
  }
}









List<String> SubTitle = [
  "商品促銷!!",
  "賣場活動進行中",
  "你可能會喜歡",
  "無通知"
];

String  categoryQuery="""
  query getCategory{
  Category {
    category(where: {discount: {points: {_is_null: false}}, _or: {discount: {coupons: {_is_null: false}}}}) {
      modelID
      modelName
      brand{
        brandID
        brandName
      }
      discount {
        points
        coupons
      }
    }
    category_aggregate(where: {discount: {coupons: {_is_null: false}}, _or: {discount: {points: {_is_null: false}}}}) {
      aggregate {
        count
      }
    }
    categoryName
    categoryID
    GeoFenceLatitude
    GeoFenceLongitude
    GeoFenceRadius
  }
  Category_aggregate {
    aggregate {
      count
    }
  }
}""";





class generateAreaSelectItemWidget extends State<stateGenerateAreaSelectItemWidget> with AutomaticKeepAliveClientMixin{


  List<int> selectedIndexList = new List<int>();


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    requestPermissions();
    var androidSettings = AndroidInitializationSettings('@mipmap/logo');
    var iOSSettings = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    var initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onClickNotification);
  }

  Future<void> initPlatformState() async {

    if (!mounted) return;
    Geofence.initialize();
    Geofence.startListening(GeolocationEvent.entry, (entry) {

      showInsistentNotification();

    });

    Geofence.startListening(GeolocationEvent.exit, (entry) {
    });

    Geofence.requestPermissions();

    setState(() {});
  }

  int buttonCount = 0;
  void requestPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future onClickNotification(String payload) {

    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
            builder: (context)=>stateEventContent()
        ),(Route<dynamic>route)=>true
    );


  }
  Future<void> showPeriodicNotification() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channel_id', 'Channel Name',);
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, );
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'Flutter Local Notification', 'Flutter Periodic Notification',
        RepeatInterval.everyMinute, notificationDetails, payload: 'Destination Screen(Periodic Notification)');
  }
  Future<void> showInsistentNotification() async {
    const int insistentFlag = 1;
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails('channel_id', 'Channel Name',
        importance: Importance.max,
        priority: Priority.max,
        ticker: 'ticker',
        additionalFlags: Int32List.fromList(<int>[insistentFlag]));
    final NotificationDetails notificationDetails = NotificationDetails(android: androidPlatformChannelSpecifics, );

    await flutterLocalNotificationsPlugin.show(0, '購物小幫手通知', SubTitle[0],
        notificationDetails, payload: '');
  }


  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GraphQLConfiguration.client,
      child: Query(
          options: QueryOptions(
              document: gql(categoryQuery),
              pollInterval: const Duration(seconds: 10),
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
                constraints: BoxConstraints.expand(),
                child: SpinKitPouringHourGlassRefined(
                  color: Colors.white,
                  size: 50.0,
                ),

              );
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold( resizeToAvoidBottomInset:true,
                  body:Container(
                      color: Color.fromARGB(255, 253, 141, 126),
                      child: Expanded(
                        child:GridView.builder(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 360,
                                childAspectRatio:1.35,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12),
                            itemCount: result.data['Category_aggregate']['aggregate']['count'],
                            itemBuilder: (BuildContext ctx, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.white.withOpacity(0.4),
                                        Colors.white.withOpacity(0.4),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child:Column(
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.height*0.09,
                                      decoration: new BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Colors.white.withOpacity(0.35),
                                              Colors.white.withOpacity(0.35),
                                            ],
                                          ),
                                          borderRadius:BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0) )
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          result.data['Category'][index]['categoryName']+'區',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: "Noto Sans",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),),
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                    FlatButton(
                                      color: selectedIndexList.contains(index) ? Colors.green : Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(15))),
                                      child: selectedIndexList.contains(index) ? Icon(CupertinoIcons.checkmark_alt_circle_fill, color: Colors.white60, size: 35.0,) :
                                      Icon(CupertinoIcons.clear_thick_circled, color: Colors.white60, size: 35.0,),
                                      onPressed: () async{





                                        int convertRadius=result.data['Category'][index]['GeoFenceRadius'];
                                        double radius=convertRadius.toDouble();





                                        if (!selectedIndexList.contains(index)) {
                                          selectedIndexList.add(index);
                                          debugPrint('Button '+index.toString()+' is Applied');



                                          if(result.data['Category'][index]['category_aggregate']['aggregate']['count']!=0){
                                            setState(() {
                                              eventModelID=result.data['Category'][index]['category'][index]['modelID'].toString();
                                              eventRelatedBrandID=result.data['Category'][index]['category'][index]['brand']['brandID'].toString();
                                            });
                                            showInsistentNotification();
                                          }




                                          debugPrint("Area "+index.toString()+" Starting GeoFencing Service");
                                          Geolocation location = Geolocation(
                                              latitude: result.data['Category'][index]['GeoFenceLatitude'],
                                              longitude: result.data['Category'][index]['GeoFenceLongitude'],
                                              radius: radius

                                          );
                                          Geofence.addGeolocation(location, GeolocationEvent.entry)
                                              .then((onValue) {
                                            if(result.data['Category'][0]['category_aggregate']['aggregate']['count']!=0){
                                              setState(() {
                                                eventModelID=result.data['Category'][index]['category'][index]['modelID'].toString();
                                                eventRelatedBrandID=result.data['Category'][index]['category'][index]['brand']['brandID'].toString();
                                              });
                                              showInsistentNotification();
                                            }
                                            debugPrint("Georegion added" "Geofence has been added!");
                                          }).catchError((onError) {
                                            print("ERROR "+onError.toString());
                                          });
                                          Geofence.getCurrentLocation().then((coordinate) {
                                            print(
                                                "Get latitude: ${coordinate?.latitude} and longitude: ${coordinate?.longitude}");
                                          });

                                          Geofence.startListeningForLocationChanges();

                                        }
                                        else {
                                          selectedIndexList.remove(index);
                                          debugPrint('Button '+index.toString()+' is Canceled');
                                          debugPrint("Area "+index.toString()+" GeoFencing Service Stopped");

                                          Geofence.stopListeningForLocationChanges();

                                        }
                                        setState(() {
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                        ) ,
                      )
                  )
              ),
            );
          }
      )
    );
  }
}








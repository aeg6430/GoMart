

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_list_sample/clips.dart';
import 'package:flutter_video_list_sample/play_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:video_player/video_player.dart';

import 'GraphQLConfig.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IntroPage(),
    );
  }
}

class IntroPage extends StatefulWidget {
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {



  //FileReader fileReader = new FileReader();



  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GraphQLConfiguration.client,
      child: Scaffold(
        body: SafeArea(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                      color:Colors.black,
                      child: PlayPage(clips: VideoClip.remoteClips),
                    )
                ),



                SizedBox(
                  width: MediaQuery.of(context).size.width*0.0075,
                  height: MediaQuery.of(context).size.height,
                  child: const DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.black),),
                ),

                Container(
                    color: Colors.black,
                    child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width*0.2,
                                height: MediaQuery.of(context).size.height*0.07,
                                child:Marquee(
                                  text: '掃描QR-Code 獲得更多資訊',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25
                                  ),
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  blankSpace: 20.0,
                                  velocity: 40.0,
                                  pauseAfterRound: Duration(seconds: 2),
                                  startPadding: 10.0,
                                  accelerationDuration: Duration(seconds: 1),
                                  accelerationCurve: Curves.linear,
                                  decelerationDuration: Duration(milliseconds: 500),
                                  decelerationCurve: Curves.easeOut,
                                )
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.025,
                              child: const DecoratedBox(
                                decoration: const BoxDecoration(color: Colors.black),),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              height: MediaQuery.of(context).size.height*0.35,
                              decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(10.0),
                                color: Colors.white
                              ),
                              child:QrImage(
                                data: 'This is a simple QR code',
                                version: QrVersions.auto,
                                size: 320,
                                gapless: true,
                                foregroundColor: Colors.black,
                              ),
                            ),
                          ],
                        )
                    )
                )
              ],
            )
        ),
      )
    );
  }




}

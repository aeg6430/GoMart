import 'dart:html';
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'dart:ui' as ui;

Widget getMap() {
  String htmlId = "7";

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {


    final mapOptions = MapOptions()
      ..zoom = 20
      ..center = LatLng(24.985059971613758, 121.34153144943028);

    final elem = DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = 'none';

    final map = GMap(elem, mapOptions);

   /* List<Data> data=[
      Data(lat:24.965059971613758,lng:121.33153144943028),
      Data(lat:24.975059971613758,lng:121.35153144943028),
    ];

    List<MyTitle> mytitle=[
      MyTitle(title:'T1'),
      MyTitle(title:'T2'),
    ];

    List<Marker>myMarker=[];
    myMarker=[];
    myMarker.add(
        Marker(MarkerOptions()
          ..position = data as LatLng?
          ..map = map
          ..title = mytitle as String?
        )
    );*/

    final myLatlng = LatLng(24.985059971613758, 121.34153144943028);
    Marker(MarkerOptions()
      ..position = myLatlng
      ..map = map
      ..title = '1'
    );



    return elem;
  });

  return HtmlElementView(viewType: htmlId);
}

class MyTitle {
  String title;
  MyTitle({required this.title});
}

class Data {
  double lat;
  double lng;
  Data({required this.lat,required this.lng});
}
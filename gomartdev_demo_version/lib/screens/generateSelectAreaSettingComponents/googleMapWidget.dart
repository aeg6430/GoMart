
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../../constants/constants.dart';

class googleMapWidget extends StatefulWidget{
  googleMapWidget(String showTitle, {Key? key,}) : super(key: key);


  @override
  stateGoogleMapWidget createState() => stateGoogleMapWidget();
}


class stateGoogleMapWidget extends State<googleMapWidget> {

  //final Map<String, Marker> _markers = {};
  /*Future<void> _onMapCreated(GoogleMapController controller) async {
    List<LatLng> latlng=[
      LatLng(24.965059971613758,121.33153144943028),
      LatLng(24.975059971613758,121.35153144943028),
    ];

    List<String> title=[
      ('T1'),
      ('T2'),
    ];
    debugPrint(title[0]);
    debugPrint(latlng[0].toString());

    setState(() {
      _markers.clear();

      for(int i=0;i<latlng.length;i++){
        final marker = Marker(
          markerId: MarkerId(title[i]),
          position: latlng[i],
          infoWindow: InfoWindow(
            title: title[i],
          ),
        );
        _markers[title[i]] = marker;
      }


    });
  }*/




  List<Marker> markers=[];
  int id=0;
  Set<Polyline>_polylines=Set<Polyline>();
  List<LatLng>polylineCorrdinates=[];

  Set<Circle> circles = Set<Circle>();






  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: GoogleMap(
            //onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(24.98507202574232, 121.34152743461986),
              zoom: 18,
            ),
            //markers: _markers.values.toSet(),
            circles: circles.map((e)=>e).toSet(),
            markers: markers.map((e)=>e).toSet(),
            polylines: _polylines,


            onTap: (LatLng latlng){

              Marker newmarker=Marker(
                  markerId: MarkerId('$id'),
                  position: LatLng(latlng.latitude,latlng.longitude),
                  infoWindow: InfoWindow(
                  title:''
                 ),
              );
              Circle newCircle=Circle(
                  circleId: CircleId('$id'),
                  center: LatLng(latlng.latitude,latlng.longitude),
                  radius: 10,
                  fillColor: Colors.blue.shade100.withOpacity(0.5),
                  strokeColor:  Colors.blue.shade100.withOpacity(0.1),
              );

              markers.add(newmarker);
              id=id+1;
              setState((){
              });



              //debugPrint('latlng :'+latlng.toString()+'id'+subscription.toString());
              circles.add(newCircle);
              id=id+1;
              setState((){
              });
            },
          ),
        )
    );
  }
}





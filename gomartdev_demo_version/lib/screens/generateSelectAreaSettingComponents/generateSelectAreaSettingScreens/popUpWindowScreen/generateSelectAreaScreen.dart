
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../../constants/constants.dart';
import '../../publicComponents/controlBar/deleteButton/deleteMapDataPopUpWindow.dart';
import '../../publicComponents/controlBar/editButton/editMapDataPopUpWindow.dart';
import '../../publicComponents/controlBar/searchingButton/selectMapDataPopUpWindow.dart';





class generateSelectAreaScreen extends StatefulWidget{
  generateSelectAreaScreen({Key? key,}) : super(key: key);
  @override
  stateGenerateSelectAreaScreen createState() => stateGenerateSelectAreaScreen();
}





class stateGenerateSelectAreaScreen extends State<generateSelectAreaScreen>{




   TextEditingController areaIDTextController = TextEditingController();
   TextEditingController areaNameTextController = TextEditingController();
   TextEditingController areaLongitudeTextController = TextEditingController();
   TextEditingController areaLatitudeTextController = TextEditingController();
   TextEditingController areaRadiusTextController = TextEditingController();



   bool enabled = false;
   bool readOnly= true;
   int tapCounter=1;


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
          child:Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
              SizedBox(height: 10,),
              Container(
                height: 30,
                child:Container(
                  height:30 ,
                  child: Row(
                    mainAxisAlignment:  MainAxisAlignment.start,
                    children: [
                      SizedBox(width:10),
                      Container(
                        decoration: new BoxDecoration(
                            color: primaryColor,
                            borderRadius: new BorderRadius.all(Radius.circular(5))
                        ),
                        child:TextButton.icon(
                          icon:Icon(Icons.add_box,color: Colors.white,),
                          label:Text('新增',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12,color:Colors.white )
                          ),
                          onPressed: ()async{
                            debugPrint('button add');
                            setState(() {
                              tapCounter++;
                              if(tapCounter %2==0)
                              {
                                enabled =true;
                              }
                            },

                            );
                          },
                        ),
                      ),
                      SizedBox(width:10),
                      Container(
                        decoration: new BoxDecoration(
                            color: primaryColor,
                            borderRadius: new BorderRadius.all(Radius.circular(5))
                        ),
                        child:TextButton.icon(
                          icon:Icon(Icons.edit,color: Colors.white,),
                          label:Text('修改',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12,color:Colors.white )
                          ),
                          onPressed: (){
                            debugPrint('button edit');
                            setState(()async{
                              tapCounter++;
                              if(tapCounter %2==0)
                              {
                                enabled =true;
                              }
                              showDialog(
                                anchorPoint:Offset.infinite, //Offset(1000, 1000),
                                context: context,
                                builder: (_) => editMapDataPopUpWindow(),
                              );
                            });
                          },
                        ),
                      ),
                      SizedBox(width:10),
                      Container(
                        decoration: new BoxDecoration(
                            color: primaryColor,
                            borderRadius: new BorderRadius.all(Radius.circular(5))
                        ),
                        child:TextButton.icon(
                          icon:Icon(Icons.delete_forever,color: Colors.white,),
                          label:Text('刪除',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12,color:Colors.white )
                          ),
                          onPressed: ()async{
                            debugPrint('button delete');
                            showDialog(
                              anchorPoint:Offset.infinite, //Offset(1000, 1000),
                              context: context,
                              builder: (_) => deleteMapDataPopUpWindow(),

                            );
                          },
                        ),
                      ),
                      SizedBox(width:10),
                      Container(
                        decoration: new BoxDecoration(
                            color: primaryColor,
                            borderRadius: new BorderRadius.all(Radius.circular(5))
                        ),
                        child:TextButton.icon(
                          icon:Icon(Icons.search,color: Colors.white,),
                          label:Text('搜尋',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12,color:Colors.white )
                          ),
                          onPressed: () async{
                            showDialog(
                              anchorPoint:Offset.infinite, //Offset(1000, 1000),
                              context: context,
                              builder: (_) => selectMapDataPopUpWindow(),

                            );
                          },
                        ),
                      ),
                      SizedBox(width:50),
                      Container(
                        decoration: new BoxDecoration(
                            color: Colors.green,
                            borderRadius: new BorderRadius.all(Radius.circular(5))
                        ),
                        child:TextButton.icon(
                          icon:Icon(Icons.save,color: Colors.white,),
                          label:Text('儲存',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12,color:Colors.white )
                          ),
                          onPressed: (){
                            debugPrint('button save');
                            setState(() {
                              tapCounter++;
                              if(tapCounter %2==0)
                              {
                                enabled =false;
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(width:10),
                      Container(
                        decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: new BorderRadius.all(Radius.circular(5))
                        ),
                        child:TextButton.icon(
                          icon:Icon(Icons.cancel,color: Colors.white,),
                          label:Text('取消',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12,color:Colors.white )
                          ),
                          onPressed: (){
                            debugPrint('button cancel');
                            setState(() {
                              tapCounter++;
                              if(tapCounter %2==1)
                              {
                                enabled =false;
                              }
                            });
                          },
                        ),
                      ),



                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: SizedBox(
                  height:MediaQuery.of(context).size.height,
                  child: Container(

                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height:MediaQuery.of(context).size.height*0.8,
                            child: GoogleMap(
                              initialCameraPosition: const CameraPosition(
                                target: LatLng(24.985125, 121.343097),
                                zoom: 17.5,
                              ),
                              circles: circles.map((e)=>e).toSet(),
                              markers: markers.map((e)=>e).toSet(),
                              polylines: _polylines,
                              onTap: (LatLng latlng){
                                id=id+1;
                                Marker newmarker=Marker(
                                  markerId: MarkerId('$id'),
                                  position: LatLng(latlng.latitude,latlng.longitude),
                                  infoWindow: InfoWindow(
                                      title:areaNameTextController.text
                                  ),
                                );
                                Circle newCircle=Circle(
                                  circleId: CircleId('$id'),
                                  center: LatLng(latlng.latitude,latlng.longitude),
                                  radius: double.parse(areaRadiusTextController.text),
                                  fillColor: Colors.blue.shade100.withOpacity(0.5),
                                  strokeColor:  Colors.blue.shade100.withOpacity(0.1),
                                );
                                areaLongitudeTextController.value=areaLongitudeTextController.value.copyWith(text: latlng.longitude.toString());
                                areaLatitudeTextController.value=areaLatitudeTextController.value.copyWith(text: latlng.latitude.toString());
                                debugPrint(
                                    'Marker No.$id '+
                                        '\nArea name: '+areaNameTextController.text+
                                        '\nArea ID: '+ areaIDTextController.text+
                                        '\nRadius: '+areaRadiusTextController.text+
                                        '\nlatlng: '+latlng.toString());
                                markers.add(newmarker);
                                setState((){
                                });
                                circles.add(newCircle);
                                setState((){
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: appPadding),
                          child: const VerticalDivider(thickness: 1, width: 1),
                        ),
                        Container(
                          height:MediaQuery.of(context).size.height*0.9,
                          width: MediaQuery.of(context).size.width*0.15,
                          child:  Padding(
                            padding: const EdgeInsets.symmetric(horizontal: appPadding),
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.15,
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: TextField(
                                    controller: areaNameTextController,
                                    enabled: enabled,
                                    readOnly: false,
                                    decoration:
                                    InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        isDense: true,
                                        //contentPadding: EdgeInsets.all(10),
                                        labelText: '區域名稱',
                                        helperText: '輸入完成後按Enter鍵'
                                    ),
                                    onSubmitted: (value) {
                                      String uuid = Uuid().v4();
                                      areaIDTextController.text = uuid ;
                                    },
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.15,
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: TextField(
                                    controller: areaIDTextController,
                                    enabled: enabled,
                                    readOnly: true,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    minLines: 2,
                                    decoration:
                                    InputDecoration(
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      isDense: true,
                                      //contentPadding: EdgeInsets.all(10),
                                      labelText: '區域編號',
                                      helperText: '自動產生區域編號',
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.15,
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: TextFormField(
                                    controller: areaRadiusTextController,
                                    readOnly: false,
                                    enabled: enabled,
                                    decoration:
                                    InputDecoration(
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(10),
                                      labelText: '半徑',
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.15,
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: TextField(
                                    controller: areaLongitudeTextController,
                                    readOnly: true,
                                    enabled: false,
                                    decoration:
                                    InputDecoration(
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      isDense: true,
                                      labelText: '經度',
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.15,
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: TextFormField(
                                    controller: areaLatitudeTextController,
                                    readOnly: true,
                                    enabled: false,
                                    decoration:
                                    InputDecoration(
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(10),
                                      labelText: '緯度',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ),
                      ],
                    ) ,
                  ),
                ),
              )
            ],
            )
          )
      ),
    );
  }

}
/*class StreamTitle {
  StreamTitle({required this.getTitle});
  final String getTitle;
  Stream<String> get showTitle async* {
      yield getTitle;
  }


}*/

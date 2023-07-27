import 'package:flutter/material.dart';
import 'package:gomartdev/screens/productDataSettingComponents/productDataSettingScreens/productLocationScreen/productLocationThumbnailDropZone.dart';
import '../../../../constants/constants.dart';
import '../publicComponents/controlBar/batchProcessingButton/batchProcessingPopUpWindow.dart';
import '../publicComponents/controlBar/createButton/createDataPopUpWindow.dart';
import '../publicComponents/controlBar/deleteButton/deleteDataPopUpWindow.dart';
import '../publicComponents/controlBar/editButton/editDataPopUpWindow.dart';
import '../publicComponents/controlBar/searchingButton/selectDataPopUpWindow.dart';

class productLocationScreen extends StatefulWidget{
  productLocationScreen({Key? key,}) : super(key: key);

  @override
  stateProductLocationScreen createState() => stateProductLocationScreen();
}


class stateProductLocationScreen extends State<productLocationScreen>{





   TextEditingController modelIDTextController = TextEditingController(text: "品號");
   TextEditingController modelNameTextController = TextEditingController(text: "品名");
   TextEditingController productLocateIDTextController = TextEditingController(text: "商品陳列位置編號");
   TextEditingController productLocateNameTextController = TextEditingController(text: "商品陳列位置名稱");
   TextEditingController productLocateThumbnailTextController = TextEditingController(text: "FileNameFromDB");




   bool enabled = false;
   bool readOnly= true;
   int tapCounter=1;







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
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height:MediaQuery.of(context).size.height*0.05,
                    child: Row(
                      mainAxisAlignment:  MainAxisAlignment.start,
                      children: [
                        SizedBox(width:MediaQuery.of(context).size.width*0.01),
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
                                showDialog(
                                  anchorPoint:Offset.infinite, //Offset(1000, 1000),
                                  context: context,
                                  builder: (_) => createDataPopUpWindow(),

                                );
                              },

                              );
                            },
                          ),
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width*0.01),
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
                                  builder: (_) => editDataPopUpWindow(),

                                );
                              });
                            },
                          ),
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width*0.01),
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
                                builder: (_) => deleteDataPopUpWindow(),

                              );
                            },
                          ),
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width*0.05),
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.amberAccent.withOpacity(0.8),
                              borderRadius: new BorderRadius.all(Radius.circular(5))
                          ),
                          child:TextButton.icon(
                            icon:Icon(Icons.file_copy_rounded,color: Colors.white,),
                            label:Text('批量處理',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12,color:Colors.white )
                            ),
                            onPressed: () async{
                              showDialog(
                                anchorPoint:Offset.infinite, //Offset(1000, 1000),
                                context: context,
                                builder: (_) => batchProcessingPopUpWindow(),

                              );
                            },
                          ),
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width*0.05),
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
                        SizedBox(width:MediaQuery.of(context).size.width*0.01),
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
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Expanded(
                  child: DefaultTabController(
                    animationDuration: Duration.zero,
                    length: 1,
                    child: SizedBox(
                      height:MediaQuery.of(context).size.height*0.8,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height:MediaQuery.of(context).size.height*0.05,

                            color: textColor.withOpacity(0.25),
                            child: TabBar(
                              indicator: BoxDecoration(
                                color: Colors.white,
                              ),
                              unselectedLabelColor: textColor,
                              labelColor: secondaryColor,

                              tabs: <Tab>[
                                Tab(
                                  child: Text(
                                    "基本資料",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color:textColor),),
                                ),
                              ],

                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              height:MediaQuery.of(context).size.height*0.5,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 20,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*0.15,
                                                    padding: EdgeInsets.symmetric(horizontal: 2),
                                                    child: TextFormField(

                                                      controller: modelIDTextController,
                                                      enabled: false,
                                                      readOnly: true,

                                                      decoration:
                                                      InputDecoration(
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,

                                                        isDense: true,
                                                        contentPadding: EdgeInsets.all(10),
                                                        labelText: '品號',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*0.15,
                                                    padding: EdgeInsets.symmetric(horizontal: 2),
                                                    child: TextFormField(
                                                      controller: modelNameTextController,
                                                      enabled: false,
                                                      readOnly: true,

                                                      decoration:
                                                      InputDecoration(
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide( color: Colors.black12),),
                                                        isDense: true,
                                                        contentPadding: EdgeInsets.all(10),
                                                        labelText: '品名',
                                                      ),

                                                    ),
                                                  ),
                                                  SizedBox(height: 20,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*0.15,
                                                    padding: EdgeInsets.symmetric(horizontal: 2),
                                                    child: TextFormField(
                                                      controller: productLocateIDTextController,
                                                      enabled: enabled,
                                                      readOnly: false,
                                                      decoration:
                                                      InputDecoration(
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,

                                                        isDense: true,
                                                        contentPadding: EdgeInsets.all(10),
                                                        labelText: '商品陳列位置編號',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height:20,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*0.15,
                                                    padding: EdgeInsets.symmetric(horizontal: 2),
                                                    child: TextFormField(
                                                      controller: productLocateNameTextController,
                                                      enabled: enabled,
                                                      readOnly: false,
                                                      decoration:
                                                      InputDecoration(
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,

                                                        isDense: true,
                                                        contentPadding: EdgeInsets.all(10),
                                                        labelText: '商品陳列位置',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height:20,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*0.15,
                                                    padding: EdgeInsets.symmetric(horizontal: 2),
                                                    child: TextFormField(
                                                      controller: productLocateThumbnailTextController,
                                                      readOnly: true,
                                                      enabled: enabled,
                                                      decoration:
                                                      InputDecoration(
                                                          floatingLabelBehavior: FloatingLabelBehavior.always,

                                                          isDense: true,
                                                          contentPadding: EdgeInsets.all(10),
                                                          labelText: '商品陳列位置圖',
                                                          suffixIcon: TextButton(
                                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
                                                            child: Text(style: TextStyle(color: Colors.white),'上傳'),
                                                            onPressed: () async{

                                                              showDialog(
                                                                anchorPoint:Offset.infinite, //Offset(1000, 1000),
                                                                context: context,
                                                                builder: (_) => productLocationThumbnailDropZone(),
                                                              );
                                                            },
                                                          )

                                                      ),

                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ) ,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

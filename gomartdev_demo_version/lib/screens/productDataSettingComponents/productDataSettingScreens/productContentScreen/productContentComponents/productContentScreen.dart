import 'dart:convert';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import '../../../../../constants/constants.dart';
import '../../publicComponents/controlBar/batchProcessingButton/batchProcessingPopUpWindow.dart';
import '../../publicComponents/controlBar/createButton/createDataPopUpWindow.dart';
import '../../publicComponents/controlBar/deleteButton/deleteDataPopUpWindow.dart';
import '../../publicComponents/controlBar/editButton/editDataPopUpWindow.dart';
import '../../publicComponents/controlBar/searchingButton/selectDataPopUpWindow.dart';
import 'productPictureDropZone.dart';

class productContentScreen extends StatefulWidget{
  productContentScreen({Key? key,}) : super(key: key);
  @override
  stateProductContentScreen createState() => stateProductContentScreen();
}


class stateProductContentScreen extends State<productContentScreen>{

   TextEditingController hintTextController = TextEditingController();

   DateTime startDateTime=DateTime.now();
   DateTime endDateTime=DateTime.now();

   final operatorDiscount = ['請選擇','折扣', '點數',];
   String selectedOperatorDiscountValue = '請選擇';
   bool v1=false;

   TextEditingController createTimeTextController = TextEditingController(text: "生效時間");
   TextEditingController editTimeTextController = TextEditingController(text: "失效時間");
   TextEditingController modelIDTextController = TextEditingController(text: "品號");
   TextEditingController modelNameTextController = TextEditingController(text: "品名");
   TextEditingController brandIDTextController = TextEditingController(text: "品牌編號");
   TextEditingController brandNameTextController = TextEditingController(text: "品牌名稱");
   TextEditingController categoryIDTextController = TextEditingController(text: "類別編號");
   TextEditingController categoryNameTextController = TextEditingController(text: "類別名稱");
   TextEditingController priceOriginalTextController = TextEditingController(text: "原價");
   TextEditingController priceSellingTextController = TextEditingController(text: "售價");
   TextEditingController priceDifferenceTextController = TextEditingController(text: "價差");
   TextEditingController effectTimeTextController = TextEditingController(text: "生效時間");
   TextEditingController expireTimeTextController = TextEditingController(text: "失效時間");
   TextEditingController productLocateIDTextController = TextEditingController(text: "商品陳列位置編號");
   TextEditingController productLocateNameTextController = TextEditingController(text: "商品陳列位置名稱");
   TextEditingController productPictureTextController = TextEditingController(text: "FileNameFromDB");
   TextEditingController discountCategoryTextController = TextEditingController(text: "折扣類別");


   bool enabled = false;
   bool readOnly= true;
   int tapCounter=1;







   @override
  Widget build(BuildContext context) {
    final startHours=startDateTime.hour.toString().padLeft(2,'0');
    final startMinutes=startDateTime.minute.toString().padLeft(2,'0');

    final endHours=endDateTime.hour.toString().padLeft(2,'0');
    final endMinutes=endDateTime.minute.toString().padLeft(2,'0');

    return Scaffold(
      backgroundColor: bgColor,

      body: SafeArea(
          child:Column(children: [
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
                    SizedBox(width:MediaQuery.of(context).size.width*0.01),
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
                            builder: (_) => selectDataPopUpWindow(),

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
            SizedBox(height: 10,),
            Expanded(
              child: DefaultTabController(
                animationDuration: Duration.zero,
                length: 2,
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
                            Tab(
                              child: Text(
                                "折扣優惠",
                                textAlign: TextAlign.center,
                                style: TextStyle(color:textColor),
                              ),
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
                                              controller: brandIDTextController,
                                              readOnly: true,
                                              enabled: false,
                                              decoration:
                                              InputDecoration(
                                                floatingLabelBehavior: FloatingLabelBehavior.always,

                                                isDense: true,
                                                labelText: '品牌編號',
                                                contentPadding: EdgeInsets.all(10),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.15,
                                            padding: EdgeInsets.symmetric(horizontal: 2),
                                            child: TextFormField(
                                              controller: categoryNameTextController,
                                              readOnly: true,
                                              enabled: false,
                                              decoration:
                                              InputDecoration(
                                                floatingLabelBehavior: FloatingLabelBehavior.always,

                                                isDense: true,
                                                contentPadding: EdgeInsets.all(10),
                                                labelText: '類別',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ),
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
                                                  controller: priceSellingTextController,
                                                  enabled: enabled,
                                                  readOnly: false,
                                                  decoration:
                                                  InputDecoration(
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,

                                                    isDense: true,
                                                    contentPadding: EdgeInsets.all(10),
                                                    labelText: '售價',
                                                  )
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.15,
                                                padding: EdgeInsets.symmetric(horizontal: 2),
                                                child: TextFormField(
                                                  controller: productLocateNameTextController,
                                                  readOnly: readOnly,
                                                  enabled: false,
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
                                                  controller: productPictureTextController,
                                                  readOnly: true,
                                                  enabled: enabled,
                                                  decoration:
                                                  InputDecoration(
                                                      floatingLabelBehavior: FloatingLabelBehavior.always,

                                                      isDense: true,
                                                      contentPadding: EdgeInsets.all(10),
                                                      labelText: '商品圖檔',
                                                      suffixIcon: TextButton(
                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
                                                        child: Text(style: TextStyle(color: Colors.white),'上傳'),
                                                        onPressed: () async{

                                                          showDialog(
                                                            anchorPoint:Offset.infinite, //Offset(1000, 1000),
                                                            context: context,
                                                            builder: (_) => productPictureDropZone(),
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
                                                  controller: discountCategoryTextController,
                                                  readOnly: true,
                                                  enabled: enabled,
                                                  decoration:
                                                  InputDecoration(
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide( color: Colors.black12),),
                                                    isDense: true,
                                                    contentPadding: EdgeInsets.all(10),
                                                    labelText: '折扣/優惠類別',
                                                    suffixIcon:Container(
                                                        width: MediaQuery.of(context).size.width*0.5,
                                                        child: Container(
                                                          child: Row(
                                                            children: [
                                                              SizedBox(width: 15,),
                                                              DropdownButton<String>(
                                                                items: operatorDiscount.map<DropdownMenuItem<String>>(
                                                                        (String value) => DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    ))
                                                                    .toList(),
                                                                value: selectedOperatorDiscountValue,
                                                                onChanged: (v1) =>
                                                                    setState(() => selectedOperatorDiscountValue = v1!,
                                                                    ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              SizedBox(
                                                                width: MediaQuery.of(context).size.width*0.04,
                                                                child: TextFormField(
                                                                  decoration:
                                                                  InputDecoration(
                                                                    isDense: true,
                                                                    hintText: '數值',
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                  showText(selectedOperatorDiscountValue)
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                    ),

                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.15,
                                                padding: EdgeInsets.symmetric(horizontal: 2),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  enabled: enabled,
                                                  controller: effectTimeTextController,
                                                  decoration:
                                                  InputDecoration(
                                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide( color: Colors.black12),),
                                                      isDense: true,
                                                      contentPadding: EdgeInsets.all(10),
                                                      labelText: '生效時間',
                                                      suffixIcon: Container(
                                                        width: MediaQuery.of(context).size.width*0.5,
                                                        child: TextButton(
                                                          child: Text(
                                                              style: TextStyle(color: Colors.black),
                                                              '${startDateTime.year}/${startDateTime.month}/${startDateTime.day} $startHours:$startMinutes'),
                                                          onPressed: pickStartDateTime,
                                                        ),
                                                      )

                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.15,
                                                padding: EdgeInsets.symmetric(horizontal: 2),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  enabled: enabled,
                                                  controller: expireTimeTextController,
                                                  decoration:
                                                  InputDecoration(

                                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide( color: Colors.black12),),
                                                      isDense: true,
                                                      contentPadding: EdgeInsets.all(10),
                                                      labelText: '失效時間',
                                                      suffixIcon: Container(
                                                        width: MediaQuery.of(context).size.width*0.5,
                                                        child: TextButton(
                                                          child: Text(
                                                              style: TextStyle(color: Colors.black),
                                                              '${endDateTime.year}/${endDateTime.month}/${endDateTime.day} $endHours:$endMinutes'),
                                                          onPressed: pickEndDateTime,
                                                        ),
                                                      )

                                                  ),
                                                ),
                                              ),
                                              SizedBox(height:40,),
                                              Container(
                                                  width: MediaQuery.of(context).size.width*0.15,
                                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                                  child: AutoSizeTextField(
                                                    keyboardType: TextInputType.multiline,
                                                    minLines: 1,
                                                    maxLines: 5,
                                                    controller: hintTextController,
                                                    readOnly: false,
                                                    enabled: enabled,
                                                    style: TextStyle(fontSize: 14),
                                                    decoration: InputDecoration(
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,

                                                        border: OutlineInputBorder(
                                                          borderSide: BorderSide( color: Colors.black12.withOpacity(0.1)),),
                                                        isDense: true,
                                                        labelText: '說明文字',
                                                        labelStyle: TextStyle(fontSize: 16),
                                                        contentPadding: const EdgeInsets.all(10)
                                                    ),
                                                  )

                                              ),
                                            ],
                                          ),
                                        ),)
                                  ),
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
                                                  controller: priceOriginalTextController,
                                                  readOnly: true,
                                                  enabled: false,
                                                  decoration:
                                                  InputDecoration(
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,

                                                    isDense: true,
                                                    contentPadding: EdgeInsets.all(10),
                                                    labelText: '原價',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.15,
                                                padding: EdgeInsets.symmetric(horizontal: 2),
                                                child: TextFormField(
                                                  controller: priceSellingTextController,
                                                  readOnly: true,
                                                  enabled: false,
                                                  decoration:
                                                  InputDecoration(
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,

                                                    isDense: true,
                                                    contentPadding: EdgeInsets.all(10),
                                                    labelText: '售價',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.15,
                                                padding: EdgeInsets.symmetric(horizontal: 2),
                                                child: TextFormField(
                                                  controller: priceDifferenceTextController,
                                                  readOnly: true,
                                                  enabled: false,
                                                  decoration:
                                                  InputDecoration(
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,

                                                    isDense: true,
                                                    contentPadding: EdgeInsets.all(10),
                                                    labelText: '價差',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            )
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
      ),
    );
  }

   Future pickStartDateTime() async{
    DateTime? date=await pickDate();
    if(date==null) return;
    TimeOfDay? time =await pickTime();
    if(time==null)return;
    final dateTime=DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(()=>this.startDateTime=dateTime);
   }

  Future<DateTime?>pickDate()=> showDatePicker
    (context: context,
      initialDate: startDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

   Future<TimeOfDay?>pickTime()=> showTimePicker
     (context: context,
     initialTime:TimeOfDay(hour: startDateTime.hour, minute: startDateTime.minute),
   );


   Future pickEndDateTime() async{
     DateTime? date=await pickDate();
     if(date==null) return;
     TimeOfDay? time =await pickTime();
     if(time==null)return;
     final dateTime=DateTime(
       date.year,
       date.month,
       date.day,
       time.hour,
       time.minute,
     );
     setState(()=>this.endDateTime=dateTime);
   }

   Future<DateTime?>pickEndDate()=> showDatePicker
     (context: context,
     initialDate: endDateTime,
     firstDate: DateTime(2000),
     lastDate: DateTime(2100),
   );

   Future<TimeOfDay?>pickEndTime()=> showTimePicker
     (context: context,
     initialTime:TimeOfDay(hour: endDateTime.hour, minute: endDateTime.minute),

   );

   showText(String selectedOperatorDiscountValue) {
     String s='';
    switch(selectedOperatorDiscountValue)
    {
      case '折扣':
        s='元';
        break;
      case '點數':
        s='點';
        break;
      default:
        break;
    }
    return s;
  }




}

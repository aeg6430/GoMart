import 'package:flutter/material.dart';
import '../../../../../../constants/constants.dart';





class filterPopUpWindow extends StatefulWidget {
  filterPopUpWindow({Key? key}) : super(key: key);






  @override
  stateFilterPopUpWindow createState() => stateFilterPopUpWindow();
}
class stateFilterPopUpWindow extends State<filterPopUpWindow> {

  final operator = ['請選擇','>', '≥', '=', '<','≤','like','like%','%like'];
  String selectedOperatorValue = '請選擇';
  bool v1=false;


  final syntax = ['請選擇','and', 'or'];
  String selectedSyntaxValue = '請選擇';
  bool v2=false;

  final operator2 = ['請選擇','>', '≥', '=', '<','≤','like','like%','%like'];
  String selectedOperatorValue2 = '請選擇';
  bool v3=false;

  final operatorConditions = ['請選擇','品號', '品名', '品牌代號',
    '品牌名稱','類別代號','類別名稱','商品陳列位置代號','商品陳列位置名稱','建立時間','修改時間'];
  String selectedOperatorConditionsValue = '請選擇';
  bool v4=false;

  final operatorConditions2 = ['請選擇','品號', '品名', '品牌代號',
    '品牌名稱','類別代號','類別名稱','商品陳列位置代號','商品陳列位置名稱','建立時間','修改時間'];
  String selectedOperatorConditionsValue2 = '請選擇';
  bool v5=false;




  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Dialog(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),

            child: SizedBox(
                height:MediaQuery.of(context).size.height*0.65,
                width: MediaQuery.of(context).size.width*0.55,
                child:Column(
                  children: [
                  Align(
                    alignment: Alignment.center,
                    child:Container(
                        padding: new EdgeInsets.all(5.0),
                        decoration: new BoxDecoration(
                            color: primaryColor,
                            borderRadius: new BorderRadius.only(
                                topLeft:  const  Radius.circular(10.0),
                                topRight: const  Radius.circular(10.0))
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '進階搜尋',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25,color: Colors.white),),
                        )
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [


                            DropdownButton<String>(

                              items: operatorConditions.map<DropdownMenuItem<String>>(
                                      (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                                  .toList(),


                              value: selectedOperatorConditionsValue,
                              onChanged: (v4) =>
                                  setState(() => selectedOperatorConditionsValue = v4!),


                            ),
                            SizedBox(width: 25,),
                            Container(
                                width: MediaQuery.of(context).size.width*0.15,
                                decoration: BoxDecoration(
                                    color: primaryColor, borderRadius: BorderRadius.circular(10)),
                                child:Padding(
                                    padding: const EdgeInsets.only(top: 3.0,bottom: 3.0),
                                    child:Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left:10 ,right: 20),
                                          child: Text('條件式'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:10),
                                          child:Container(
                                            width: MediaQuery.of(context).size.width*0.07,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10)),
                                            child: DropdownButton<String>(

                                              items: operator.map<DropdownMenuItem<String>>(
                                                      (String value) => DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  ))
                                                  .toList(),


                                              value: selectedOperatorValue,
                                              onChanged: (v1) =>
                                                  setState(() => selectedOperatorValue = v1!),


                                            ),
                                          ),
                                        ),



                                      ],
                                    )
                                )
                            ),
                            SizedBox(width: 25,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.095,
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: TextFormField(
                                decoration:
                                InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide( color: Colors.black12),),
                                  isDense: true,                      // Added this
                                ),
                                initialValue: "輸入搜尋值",
                              ),
                            ),

                          ],
                        ),
                      ),

                      SizedBox(height: 25,),
                      Align(alignment: Alignment.center,
                        child: Container(

                            width: MediaQuery.of(context).size.width*0.15,
                            decoration: BoxDecoration(
                                color: primaryColor, borderRadius: BorderRadius.circular(10)),
                            child:Padding(
                                padding: const EdgeInsets.only(top: 3.0,bottom: 3.0),
                                child:Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:10 ,right: 20),
                                      child: Text('條件式'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:10),
                                      child:Container(
                                        width: MediaQuery.of(context).size.width*0.07,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: DropdownButton<String>(

                                          items: syntax.map<DropdownMenuItem<String>>(
                                                  (String value) => DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              ))
                                              .toList(),


                                          value: selectedSyntaxValue,
                                          onChanged: (v2) =>
                                              setState(() => selectedSyntaxValue = v2!),


                                        ),
                                      ),
                                    ),



                                  ],
                                )
                            )




                        ),),

                      SizedBox(height: 25,),
                      Align(alignment: Alignment.center,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            DropdownButton<String>(

                              items: operatorConditions2.map<DropdownMenuItem<String>>(
                                      (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                                  .toList(),


                              value: selectedOperatorConditionsValue2,
                              onChanged: (v5) =>
                                  setState(() => selectedOperatorConditionsValue2 = v5!),


                            ),
                            SizedBox(width: 25,),
                            Container(

                                width: MediaQuery.of(context).size.width*0.15,
                                decoration: BoxDecoration(
                                    color: primaryColor, borderRadius: BorderRadius.circular(10)),
                                child:Padding(
                                    padding: const EdgeInsets.only(top: 3.0,bottom: 3.0),
                                    child:Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left:10 ,right: 20),
                                          child: Text('條件式'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:10),
                                          child:Container(
                                            width: MediaQuery.of(context).size.width*0.07,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10)),
                                            child: DropdownButton<String>(

                                              items: operator2.map<DropdownMenuItem<String>>(
                                                      (String value) => DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  ))
                                                  .toList(),


                                              value: selectedOperatorValue2,
                                              onChanged: (v3) =>
                                                  setState(() => selectedOperatorValue2 = v3!),


                                            ),
                                          ),
                                        ),



                                      ],
                                    )
                                )




                            ),
                            SizedBox(width: 25,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.095,
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: TextFormField(
                                decoration:
                                InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide( color: Colors.black12),),
                                  isDense: true,                      // Added this
                                ),
                                initialValue: "輸入搜尋值",
                              ),
                            ),

                          ],
                        ),
                      ),



                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      decoration: new BoxDecoration(
                          color: Colors.green,
                          borderRadius: new BorderRadius.all(Radius.circular(5))
                      ),
                      child:TextButton.icon(
                        icon:Icon(Icons.check_circle,color: Colors.white,),
                        label:Text('確認',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12,color:Colors.white )
                        ),
                        onPressed: (){
                          debugPrint('button confirm');
                          Navigator.of(context).pop();
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
                          Navigator.of(context).pop();
                          },
                      ),
                    ),
                  ],)
                ],)

            )
       )






    );


  }
}
















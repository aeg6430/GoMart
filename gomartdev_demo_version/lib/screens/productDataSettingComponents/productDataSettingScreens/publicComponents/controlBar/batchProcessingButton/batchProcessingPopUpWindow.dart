
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../globals.dart';
import 'batchProcessingComponents/batchFileDropZone.dart';
import 'batchProcessingComponents/downloadCSVTemplateFile.dart';


class batchProcessingPopUpWindow extends StatefulWidget {
  batchProcessingPopUpWindow({Key? key}) : super(key: key);





  @override
  stateBatchProcessingPopUpWindow createState() => stateBatchProcessingPopUpWindow();
}
class stateBatchProcessingPopUpWindow extends State<batchProcessingPopUpWindow> {













  List<List<dynamic>> _data = [];

  void _loadCSV() async {

    List<List<dynamic>> _listData =
    const CsvToListConverter().convert(result);
    setState(() {
      _data = _listData;
    });
  }






  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: SizedBox(
            height:MediaQuery.of(context).size.height*0.65,
            width: MediaQuery.of(context).size.width*0.65,
            child: DefaultTabController(
              animationDuration: Duration.zero,
              length: 2,
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 50,
                          decoration: new BoxDecoration(
                              color: primaryColor,
                              borderRadius: new BorderRadius.only(
                                  topLeft:  const  Radius.circular(10.0),
                                  topRight: const  Radius.circular(10.0))
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '批量處理',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25,color: Colors.white),),
                          )
                      ),
                      Container(
                        height:MediaQuery.of(context).size.height*0.07,



                        color: textColor.withOpacity(0.25),
                        child: TabBar(
                          onTap:  (int) {
                            switch (int) {

                              case 1:
                                _loadCSV();
                                break;
                            }
                          },
                          indicator: BoxDecoration(
                            color: Colors.white,
                          ),
                          unselectedLabelColor: textColor,
                          labelColor: secondaryColor,

                          tabs: <Tab>[
                            Tab(
                              child: Text(
                                "上傳檔案",
                                textAlign: TextAlign.center,
                                style: TextStyle(color:textColor),),
                            ),
                            Tab(
                              child: Text(
                                "檢視內容",
                                textAlign: TextAlign.center,
                                style: TextStyle(color:textColor),
                              ),
                            ),
                          ],

                        ),
                      ),
                    ],
                  ),



                  Expanded(
                    child: Center(
                      child: TabBarView(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(10),
                          child: Container(
                              height:MediaQuery.of(context).size.height*0.75,
                              width: MediaQuery.of(context).size.width*0.45,
                              child:SingleChildScrollView(

                                  child:Center(
                                    child:  Column(
                                    children: [
                                      Center(child: Text('步驟1. 下載CSV範本文件')),
                                      SizedBox(height: 10,),
                                      downloadCSVTemplateFile(),
                                      SizedBox(height: 10,),
                                      Center(child: Text('步驟2. 編輯CSV文件')),
                                      SizedBox(height: 10,),
                                      Center(child: Text('步驟3. 上傳CSV文件\n文件大小超過25KB可能造成卡頓',
                                        textAlign: TextAlign.center,)),
                                      SizedBox(height: 10,),
                                      batchFileDropZone(),

                                    ],
                                  ),
                                  )
                              )


                          ),),

                        Container(
                            height:MediaQuery.of(context).size.height*0.65,
                            width: MediaQuery.of(context).size.width*0.35,


                            child:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    SizedBox(height: 20,),

                                    Container(
                                      width: MediaQuery.of(context).size.width*0.9,
                                      height: MediaQuery.of(context).size.height*0.45,
                                      child: SingleChildScrollView(
                                        child: Table(
                                          border: TableBorder.all(width: 1.0),
                                          children: _data.map((item) {
                                            return TableRow(
                                                children: item.map((row) {
                                                  return Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(1.0),
                                                      child: Text(
                                                        row.toString(),
                                                      ),
                                                    ),
                                                  );
                                                }).toList());
                                          }).toList(),
                                        ),
                                      ),

                                    ),




                                  ],

                                ),
                              ),

                            )


                        ),
                      ],
                    ),)
                  ),
                ],
              ),
            ),)
        )
    );
  }


}



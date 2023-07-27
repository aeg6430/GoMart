import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gomartdev/screens/productDataSettingComponents/productDataSettingScreens/dataListScreen/productDataList.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/responsive.dart';
import '../../../dashboardComponents/custom_appbar.dart';
import '../popUpWindowScreen/popUpWindow.dart';





class productDataSettingContent extends StatelessWidget {
  const productDataSettingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
          body:Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(appPadding),
                child: Column(
                  children: [

                    CustomAppbar(),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child:  Column(
                                children: [

                                  SizedBox(
                                    height: appPadding,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: double.infinity,height: 80,
                                                  decoration: new BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius: new BorderRadius.only(
                                                          topLeft:  const  Radius.circular(10.0),
                                                          topRight: const  Radius.circular(10.0))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          '品名',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(fontSize: 20,color: Colors.white),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text('品號',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(fontSize: 20,color: Colors.white),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          '品牌名稱',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(fontSize: 20,color: Colors.white),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          '建立時間',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(fontSize: 20,color: Colors.white),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          '修改時間',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(fontSize: 20,color: Colors.white),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          '預覽畫面',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(fontSize: 20,color: Colors.white),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                    width: double.infinity,
                                                    height: 600,
                                                    alignment: Alignment.center,
                                                    child: productDataList()
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (!Responsive.isMobile(context))
                              SizedBox(
                                width: appPadding,
                              ),
                          ],
                        ),


                      ],
                    ),


                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () async{
                    showDialog(
                      anchorPoint:Offset.infinite, //Offset(1000, 1000),
                      context: context,
                      builder: (_) => popUpWindow(),

                    );
                  },
                ),
              ),

            ],
          )
      ) ,

    );
  }
}

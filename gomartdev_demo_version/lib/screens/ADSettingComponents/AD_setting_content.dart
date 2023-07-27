import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gomartdev/screens/ADSettingComponents/reorderableItem.dart';
import '../../constants/constants.dart';
import '../../constants/responsive.dart';
import '../../globals.dart';

import '../dashboardComponents/custom_appbar.dart';
import 'dropZone.dart';


class ADSettingContent extends StatefulWidget {
  const ADSettingContent({Key? key}) : super(key: key);

  @override
  stateADSettingContent createState() => stateADSettingContent();




}


class stateADSettingContent extends State<ADSettingContent>  {








  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  dropZone(),
                                  SizedBox(height: appPadding),



                                  Container(width: double.infinity,
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
                                                 '廣告名稱',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 20,color: Colors.white)),
                                           ),
                                           Container(
                                             child: Text('廣告ID',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(fontSize: 20,color: Colors.white)),
                                           ),
                                           Container(
                                             child: Text('廣告URL',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(fontSize: 20,color: Colors.white)),
                                           ),
                                           Container(
                                             child: Text('文件類型',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(fontSize: 20,color: Colors.white)),
                                           ),
                                           Container(
                                             child: Text('文件大小',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(fontSize: 20,color: Colors.white)),
                                           ),
                                           Container(
                                             child: Text('預覽畫面',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(fontSize: 20,color: Colors.white)),
                                           ),
                                         ],
                                       ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 500,
                                        child: RecorderableItem()
                                      ),
                                    ],
                                  ),
                                  ),
                                  if (Responsive.isMobile(context))
                                    SizedBox(height: appPadding),
                                ],
                              ),
                            ),

                          ],
                        )
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
    );
  }



}



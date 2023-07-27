import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import 'generateSelectAreaScreen.dart';
class generateSelectAreaPopUpWindow extends StatefulWidget {
  generateSelectAreaPopUpWindow({Key? key}) : super(key: key);

  @override
  stateGenerateSelectAreaPopUpWindow createState() => stateGenerateSelectAreaPopUpWindow();
}
class stateGenerateSelectAreaPopUpWindow  extends State<generateSelectAreaPopUpWindow> {




  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            width: MediaQuery.of(context).size.width*0.7,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child:Container(
                      padding: new EdgeInsets.all(5.0),
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
                          '購物小幫手區域設定',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25,color: Colors.white),),
                      )
                  ),
                ),
                Container(

                  height: MediaQuery.of(context).size.height*0.7,

                  child:Center(
                    child: Container(
                        height: MediaQuery.of(context).size.height*0.7,
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft:  const  Radius.circular(10.0),
                                bottomRight: const  Radius.circular(10.0))
                        ),
                        child:generateSelectAreaScreen()
                    ),
                  ),

                ),
              ],
            ),
          )
        )
    );
  }
}



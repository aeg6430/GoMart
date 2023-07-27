import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../modelScreen/modelComponents/modelScreen.dart';
import '../productBrandScreen/productBrandComponents/productBrandScreen.dart';
import '../productCategoryScreen/productCategoryComponents/productCategoryScreen.dart';
import '../productContentScreen/productContentComponents/productContentScreen.dart';
import '../productLocationScreen/productLocationScreen.dart';
class popUpWindow extends StatefulWidget {
  popUpWindow({Key? key}) : super(key: key);

  @override
  statepopUpWindow createState() => statepopUpWindow();
}
class statepopUpWindow extends State<popUpWindow> {

  int _selectedIndex=0;
  List<StatefulWidget> ListView = [
    modelScreen(),
    productBrandScreen(),
    productCategoryScreen(),
    productLocationScreen(),
    productContentScreen()
  ];


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            width: MediaQuery.of(context).size.width*0.7,
            child:Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child:Container(
                      padding: new EdgeInsets.all(5.0),
                      height: MediaQuery.of(context).size.height*0.08,
                      decoration: new BoxDecoration(
                          color: primaryColor,
                          borderRadius: new BorderRadius.only(
                              topLeft:  const  Radius.circular(10.0),
                              topRight: const  Radius.circular(10.0))
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '商品資料設定',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25,color: Colors.white),),
                      )
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  child: Row(
                    children: <Widget>[
                      SingleChildScrollView(
                        child:ConstrainedBox(
                            constraints: BoxConstraints(),
                            child: IntrinsicHeight(
                              child:NavigationRail(
                                selectedIndex: _selectedIndex,
                                onDestinationSelected: (int index) {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },
                                labelType: NavigationRailLabelType.all,
                                destinations: const <NavigationRailDestination>[
                                  NavigationRailDestination(
                                    icon: Icon(Icons.numbers),
                                    selectedIcon: Icon(Icons.numbers),
                                    label: Text('品號管理作業'),
                                  ),
                                  NavigationRailDestination(
                                    icon: Icon(Icons.abc_rounded),
                                    selectedIcon: Icon(Icons.abc_rounded),
                                    label: Text('商品品牌管理作業'),

                                  ),
                                  NavigationRailDestination(
                                    icon: Icon(Icons.category_outlined),
                                    selectedIcon: Icon(Icons.category),
                                    label: Text('商品類別管理作業'),
                                  ),
                                  NavigationRailDestination(
                                    icon: Icon(Icons.edit_location_alt_outlined),
                                    selectedIcon: Icon(Icons.edit_location_alt),
                                    label: Text('商品位置管理作業'),
                                  ),
                                  NavigationRailDestination(
                                    icon: Icon(Icons.dashboard_outlined),
                                    selectedIcon: Icon(Icons.dashboard),
                                    label: Text('商品內容管理作業'),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                      const VerticalDivider(thickness: 1, width: 1),
                      Expanded(
                        child: Center(
                          child: Container(
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.only(
                                      bottomLeft:  const  Radius.circular(10.0),
                                      bottomRight: const  Radius.circular(10.0))
                              ),
                              child:ListView[_selectedIndex]
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          )
        )
    );
  }
}



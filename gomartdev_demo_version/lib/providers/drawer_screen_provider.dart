




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/AD_setting_screen.dart';
import '../screens/dash_board_screen.dart';
import '../screens/generate_select_area_setting_screen.dart';
import '../screens/product_data_setting_screen.dart';

class DrawerScreenProvider extends ChangeNotifier {
  late Widget _currentScreen = const ADSettingScreen();
  Widget get currentScreen => _currentScreen;
  set currentScreen(Widget newScreen) {
    _currentScreen = newScreen;
    notifyListeners();
  }

  void changeCurrentScreen(CustomScreensEnum screen){
    switch(screen){
      case CustomScreensEnum.ADSettingScreen:
        currentScreen = const ADSettingScreen();
        break;
      case CustomScreensEnum.productDataSettingScreen:
        currentScreen = const ProductDataSettingScreen();
        break;
      case CustomScreensEnum.generateSelectAreaSettingScreen:
        currentScreen = const GenerateSelectAreaSettingScreen();
        break;
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }


}

enum CustomScreensEnum {
  ADSettingScreen,
  productDataSettingScreen,
  generateSelectAreaSettingScreen
}
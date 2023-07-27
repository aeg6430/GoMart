import 'package:flutter/material.dart';
import 'package:gomartdev/screens/productDataSettingComponents/productDataSettingScreens/dataListScreen/product_data_setting_content.dart';



import '../../providers/drawer_screen_provider.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../constants/responsive.dart';
import '../drawer/drawer_menu.dart';


class ProductDataSettingScreen extends StatelessWidget {
  const ProductDataSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: Drawer(),
      key: context.read<DrawerScreenProvider>().scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) Expanded(child: DrawerMenu(),),
            Expanded(
              flex: 5,
              child: productDataSettingContent()
            )
          ],
        ),
      ),
    );
  }
}

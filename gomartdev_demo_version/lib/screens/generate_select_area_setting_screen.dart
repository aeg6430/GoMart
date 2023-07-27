import 'package:flutter/material.dart';


import '../../providers/drawer_screen_provider.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../constants/responsive.dart';
import '../drawer/drawer_menu.dart';
import 'generateSelectAreaSettingComponents/generate_select_area_setting_content.dart';


class GenerateSelectAreaSettingScreen extends StatelessWidget {
  const GenerateSelectAreaSettingScreen({Key? key}) : super(key: key);

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
              child: generateSelectAreaSettingContent()
            )
          ],
        ),
      ),
    );
  }
}

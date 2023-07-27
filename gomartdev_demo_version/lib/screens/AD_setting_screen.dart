

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../providers/drawer_screen_provider.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../constants/responsive.dart';
import '../drawer/drawer_menu.dart';
import 'ADSettingComponents/AD_setting_content.dart';

class ADSettingScreen extends StatelessWidget {
  const ADSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: DrawerMenu(),
      key: context.read<DrawerScreenProvider>().scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) Expanded(child: DrawerMenu(),),
            Expanded(
              flex: 5,
              child: ADSettingContent()
            )
          ],
        ),
      ),
    );
  }
}

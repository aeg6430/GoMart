import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../constants/responsive.dart';
import '../drawer/drawer_menu.dart';
import '../providers/drawer_screen_provider.dart';
import 'package:provider/provider.dart';

import 'dashboardComponents/dashboard_content.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

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
              child: DashboardContent(),
            )
          ],
        ),
      ),
    );
  }
}

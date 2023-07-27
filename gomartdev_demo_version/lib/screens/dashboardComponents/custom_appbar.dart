import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../constants/responsive.dart';
import '../../providers/drawer_screen_provider.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            onPressed: context.read<DrawerScreenProvider>().controlMenu,

            icon: Icon(Icons.menu,color: textColor.withOpacity(0.5),),
          ),
        //Expanded(child: SearchField()),
        //ProfileInfo()
      ],
    );
  }
}

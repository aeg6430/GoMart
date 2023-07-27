import 'package:flutter/material.dart';

import '../popUpWindowScreen/popUpWindow.dart';
class productDataList extends StatefulWidget {
  productDataList({Key? key}) : super(key: key);

  @override
  stateProductDataList createState() => stateProductDataList();
}

class stateProductDataList extends State<productDataList> {

  final List<int> _items = List<int>.generate(20, (int index) => index);
  bool status=false;
  String popupMenuText="編輯";
  int tapCounter=1;

  Widget icon=Icon(IconData(0xe19d, fontFamily: 'MaterialIcons')) as Widget;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 0.1),
      buildDefaultDragHandles:false,
      children: <Widget>[
        for (int index = 0; index < _items.length; index += 1)
          ListTile(

              key: Key('$index'),
              tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
              title:
              Align(
                alignment: Alignment.center,
                child:
                Row(
                    children: <Widget>[


                      Expanded(
                          child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              'name'
                          )
                      ),
                      Expanded(
                          child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              '7f26fc13-0fef-49ac-a075-f8edb6adc74f'
                          )
                      ),
                      Expanded(
                          child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              'brand'
                          )
                      ),
                      Expanded(
                          child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              'YY/MM/DD HH:MM:SS'
                          )
                      ),
                      Expanded(
                          child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              'YY/MM/DD HH:MM:SS'
                          )
                      ),
                      Expanded(
                          child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              'Thumbnail'
                          )
                      ),

                      PopupMenuButton(
                        tooltip: "編輯",
                        itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<int>(
                            value: 0,
                            child:
                            Row(
                              children: <Widget>[
                                icon,
                                Text(popupMenuText),
                              ],
                            ),
                          ),

                        ];
                      },
                          onSelected:(value) {
                            if(value == 0)
                            {

                              setState(() {
                                tapCounter++;
                                if(tapCounter %2==0)
                                {
                                  popupMenuText="儲存";
                                  debugPrint("編輯");
                                  icon=Icon(IconData(0xf0126, fontFamily: 'MaterialIcons')) as Widget;
                                  showDialog(
                                    anchorPoint:Offset.infinite, //Offset(1000, 1000),
                                    context: context,
                                    builder: (_) => popUpWindow(),

                                  );
                                }
                                else
                                {
                                  popupMenuText="編輯";
                                  debugPrint("儲存");
                                  icon=Icon(IconData(0xe19d, fontFamily: 'MaterialIcons')) as Widget;
                                }
                              });
                            }

                          }
                      ),
                      SizedBox(width: 5),
                    ]
                ),
              )
          ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final int item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
    );

  }
}

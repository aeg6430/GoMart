import 'package:flutter/material.dart';
class RecorderableItem extends StatefulWidget {
  RecorderableItem({Key? key}) : super(key: key);

  @override
  stateRecorderableItem createState() => stateRecorderableItem();
}

class stateRecorderableItem extends State<RecorderableItem> {

  final List<int> _items = List<int>.generate(20, (int index) => index);
  bool status=false;
  String popupMenuText="修改順序";
  int tapCounter=1;

  Widget icon=Icon(IconData(0xe19d, fontFamily: 'MaterialIcons')) as Widget;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 0.1),
      buildDefaultDragHandles:status,
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
                              'Item ${_items[index]}'
                          )
                      ),
                      Expanded(
                          child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              'ID'
                          )
                      ),
                      Expanded(
                          child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              'http://localhost:52184/3b773feb-8e06-4ee1-90cc-aef404cc486f'
                          )
                      ),
                      Expanded(
                          child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              'MIME'
                          )
                      ),
                      Expanded(
                          child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              'Size'
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

                      PopupMenuButton(itemBuilder: (BuildContext context) {
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
                          PopupMenuItem<int>(
                            value: 1,
                            child:
                            Row(
                              children: <Widget>[
                                Icon(Icons.delete),
                                Text("刪除"),
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
                                    debugPrint("修改順序");
                                    status=true;
                                    icon=Icon(IconData(0xf0126, fontFamily: 'MaterialIcons')) as Widget;
                                }
                                else
                                {
                                    popupMenuText="修改順序";
                                    debugPrint("儲存");
                                    status=false;
                                    icon=Icon(IconData(0xe19d, fontFamily: 'MaterialIcons')) as Widget;
                                }
                              });
                            }
                            else if(value == 1)
                            {
                             debugPrint("刪除");
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

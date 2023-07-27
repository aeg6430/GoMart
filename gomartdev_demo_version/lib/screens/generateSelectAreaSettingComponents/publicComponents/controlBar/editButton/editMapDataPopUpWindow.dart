
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../searchingButton/filterPopUpWindow.dart';




class editMapDataPopUpWindow extends StatefulWidget {
  editMapDataPopUpWindow({Key? key}) : super(key: key);






  @override
  stateEditMapDataPopUpWindow createState() => stateEditMapDataPopUpWindow();
}


class Item {

  Item({

    required this.id,

    required this.areaName,

    required this.areaId,

    required this.createTime,

    required this.editTime,

    required this.isSelected,

  });


  int id;
  String areaName;
  String areaId;
  String createTime;
  String editTime;
  bool isSelected;

}

class stateEditMapDataPopUpWindow extends State<editMapDataPopUpWindow> {
  List<Item> _items = [];
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  var uuid = Uuid().v4();
  @override
  void initState() {
    super.initState();
    setState(() {
      _items = _generateItems();
    });
  }

  List<Item> _generateItems() {
    return List.generate(15, (int index) {
      return Item(
        id: index + 1,
        areaId: uuid,
        areaName: 'Item ${index + 1}',
        createTime: 'Create Time ${index + 1}',
        editTime: 'Edit Time ${index + 1}',
        isSelected: false,
      );
    });
  }

  void updateSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  List<DataColumn> _createColumns() {

    return [
      DataColumn(
        label: const Text('No'),
        numeric: false, // Deliberately set to false to avoid right alignment.
        onSort: (int columnIndex, bool ascending) {
          if (ascending) {
            _items.sort((item1, item2) => item1.id.compareTo(item2.id));
          } else {
            _items.sort((item1, item2) => item2.id.compareTo(item1.id));
          }
          setState(() {
            _sortColumnIndex = columnIndex;
            _sortAscending = ascending;
          });
        },
      ),

      DataColumn(
        label: const Text('areaId'),
        numeric: false,
        onSort: (int columnIndex, bool ascending) {
          if (ascending) {
            _items.sort((item1, item2) => item1.areaId.compareTo(item2.areaId));
          } else {
            _items.sort((item1, item2) => item2.areaId.compareTo(item1.areaId));
          }
          setState(() {
            _sortColumnIndex = columnIndex;
            _sortAscending = ascending;
          });
        },
      ),

      DataColumn(
        label: const Text('areaName'),
        numeric: false,
        tooltip: 'Name of the item',
      ),

      DataColumn(
        label: const Text('createTime'),
        numeric: false,  // Deliberately set to false to avoid right alignment.
        tooltip: 'Price of the item',
        onSort: (int columnIndex, bool ascending) {
          if (ascending) {
            _items.sort((item1, item2) => item1.createTime.compareTo(item2.createTime));
          } else {
            _items.sort((item1, item2) => item2.createTime.compareTo(item1.createTime));
          }
          setState(() {
            _sortColumnIndex = columnIndex;
            _sortAscending = ascending;
          });
        },
      ),

      DataColumn(
        label: const Text('editTime'),
        numeric: false,
        tooltip: 'Description of the item',
        onSort: (int columnIndex, bool ascending) {
          if (ascending) {
            _items.sort((item1, item2) => item1.editTime.compareTo(item2.editTime));
          } else {
            _items.sort((item1, item2) => item2.editTime.compareTo(item1.editTime));
          }
          setState(() {
            _sortColumnIndex = columnIndex;
            _sortAscending = ascending;
          });
        },
      ),
    ];
  }

  DataRow _createRow(Item item) {
    return DataRow(
      // index: item.id, // for DataRow.byIndex
      key: ValueKey(item.id),
      selected: item.isSelected,
      onSelectChanged: (bool? isSelected) {
        if (isSelected != null) {
          item.isSelected = isSelected;
          setState(() {});
        }
      },
      color: MaterialStateColor.resolveWith((Set<MaterialState> states) =>
      states.contains(MaterialState.selected) ? Color.fromRGBO(17, 159, 250, 1).withOpacity(0.4) : Color.fromARGB(100, 215, 217, 219)
      ),
      cells: [
        DataCell(
          Text(item.id.toString()),
        ),
        DataCell(
            Text(item.areaId)
        ),
        DataCell(
          Text(item.areaName),
          placeholder: false,
          onTap: () {
            print('onTap');
          },
        ),
        DataCell(
          Text(item.createTime),
        ),
        DataCell(
          Text(item.editTime),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Dialog(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Align(alignment: Alignment.centerRight,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: "Search",
                                            prefixIcon: Icon(Icons.search),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.filter_alt),
                                              onPressed: () async{
                                                showDialog(
                                                  anchorPoint:Offset.infinite, //Offset(1000, 1000),
                                                  context: context,
                                                  builder: (_) => Center(child: filterPopUpWindow()),
                                                );
                                              },
                                            )
                                        ),
                                        onChanged: (value) {


                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                    child:Container(
                                      width: MediaQuery.of(context).size.width * 0.65,
                                      child:
                                      DataTable(
                                        sortColumnIndex: _sortColumnIndex,
                                        sortAscending: _sortAscending,
                                        columnSpacing: 0,
                                        dividerThickness: 5,
                                        onSelectAll: (bool? isSelected) {
                                          if (isSelected != null) {
                                            _items.forEach((item) {
                                              item.isSelected = isSelected;
                                            });
                                            setState(() {});
                                          }
                                        },
                                        dataRowColor:
                                        MaterialStateColor.resolveWith((Set<MaterialState> states)
                                        => states.contains(MaterialState.selected) ? Colors.blue : Color.fromARGB(100, 215, 217, 219)
                                        ),
                                        dataRowHeight: 80,
                                        dataTextStyle: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
                                        headingRowColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(17, 159, 250, 1)),
                                        headingRowHeight: 80,
                                        headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                        horizontalMargin: 10,
                                        showBottomBorder: true,
                                        showCheckboxColumn: true,
                                        columns: _createColumns(),
                                        rows: _items.map((item) => _createRow(item)).toList(),
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child:Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: new BorderRadius.all(Radius.circular(5))
                                      ),
                                      child:TextButton.icon(
                                        icon:Icon(Icons.check_circle,color: Colors.white,),
                                        label:Text('確認',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 12,color:Colors.white )
                                        ),
                                        onPressed: (){
                                          debugPrint('button confirm');
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(width:10),
                                    Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: new BorderRadius.all(Radius.circular(5))
                                      ),
                                      child:TextButton.icon(
                                        icon:Icon(Icons.cancel,color: Colors.white,),
                                        label:Text('取消',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 12,color:Colors.white )
                                        ),
                                        onPressed: (){
                                          debugPrint('button cancel');
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],)
                            )
                        )
                      ],
                    )
                )
            )
        )
    );
  }
}






















import 'package:flutter/material.dart';

List<Color> colors = [
  const Color.fromARGB(255, 255, 255, 255),
  const Color.fromARGB(255, 252, 201, 207),
  const Color.fromARGB(255, 250, 252, 201),
  const Color.fromARGB(255, 208, 252, 201),
  const Color.fromARGB(255, 201, 234, 252),
];

class PriorityPicker extends StatefulWidget {
  final Function(int) onTap;
  final int selectedIndex;
  const PriorityPicker({Key key, this.onTap, this.selectedIndex}) : super(key: key);
  @override
  _PriorityPickerState createState() => _PriorityPickerState();
}

class _PriorityPickerState extends State<PriorityPicker> {
  int selectedIndex;
  List<String> priorityText = ['不重要', '次要重要', '重要'];
  List<Color> priorityColor = [Colors.green, Color.fromARGB(255, 255, 145, 0), Colors.red];
  @override
  Widget build(BuildContext context) {
    selectedIndex ??= widget.selectedIndex;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTap(index);
            },
            child: Container(
              padding: const EdgeInsets.all(3.0),
              width: width / 3,
              height: 70,
              child: Container(
                child: Center(
                  child: Text(priorityText[index],
                      style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? priorityColor[index]
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                    border: selectedIndex == index
                        ? Border.all(width: 2, color: Colors.black)
                        : Border.all(width: 0,color: Colors.transparent)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  final Function(int) onTap;
  final int selectedIndex;
  const ColorPicker({Key key, this.onTap, this.selectedIndex}) : super(key: key);
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    selectedIndex ??= widget.selectedIndex;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTap(index);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: 50,
              height: 50,
              child: Container(
                child: Center(
                    child: selectedIndex == index
                        ? const Icon(Icons.done)
                        : Container()),
                decoration: BoxDecoration(
                    color: colors[index],
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.black)),
              ),
            ),
          );
        },
      ),
    );
  }
}

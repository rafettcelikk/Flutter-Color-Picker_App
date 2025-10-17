import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_color_picker_app/constants/colors.dart';
import 'package:flutter_color_picker_app/widgets/color_display.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({super.key});

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  Color selectedColor = Colors.blue;
  bool isCircular = false;
  bool isShowColorName = true;

  void _selectRandomColor() {
    final colorList = colors.keys.toList();
    final randomIndex = Random().nextInt(colorList.length);
    final randomColor = colorList[randomIndex];
    setState(() {
      selectedColor = randomColor;
      debugPrint("Rastgele renk seçildi: ${colors[selectedColor]}");
    });
  }

  void _showColorCode() {
    Fluttertoast.showToast(
      msg:
          "RGB (${selectedColor.red}, ${selectedColor.green}, ${selectedColor.blue})",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: selectedColor,
      textColor: Colors.white,
      fontSize: 24.0,
    );
  }

  void _changeShapeOfContainer() {
    setState(() {
      isCircular = !isCircular;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Renk Seçici"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "toggleColorName",
                  child: Row(
                    children: [
                      Icon(
                        isShowColorName
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                        color: Colors.black,
                      ),
                      SizedBox(width: 4),
                      Text(
                        isShowColorName
                            ? "Renk Adını Gizle"
                            : "Renk Adını Göster",
                      ),
                    ],
                  ),
                ),
              ];
            },
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              setState(() {
                isShowColorName = !isShowColorName;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ColorDisplay(
                selectedColor: selectedColor,
                isCircular: isCircular,
              ),
              SizedBox(height: 10),
              isShowColorName
                  ? Text("Seçilen Renk: ${colors[selectedColor]}")
                  : SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<Color>(
                      value: selectedColor,
                      items: colors.entries.map((entry) {
                        return DropdownMenuItem(
                          value: entry.key,
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                color: entry.key,
                              ),
                              SizedBox(width: 4),
                              Text(entry.value),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedColor = value!;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: _selectRandomColor,
                      child: Text("Rastgele"),
                    ),
                    IconButton(
                      onPressed: _showColorCode,
                      icon: Icon(Icons.info),
                    ),
                    IconButton(
                      onPressed: () {
                        _changeShapeOfContainer();
                      },
                      icon: Icon(
                        isCircular
                            ? Icons.square_outlined
                            : Icons.circle_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

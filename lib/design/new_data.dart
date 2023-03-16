import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import "package:scoutingapp/design/my_dropdown_menu.dart";
import 'package:scoutingapp/logic/error_pop_up.dart';
import 'package:path_provider/path_provider.dart';

class NewData extends StatefulWidget {
  const NewData({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewDataState createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  TextEditingController autoPiecesController = TextEditingController(text: "0");
  TextEditingController highPiecesController = TextEditingController(text: "0");
  TextEditingController midPiecesController = TextEditingController(text: "0");
  TextEditingController lowPiecesController = TextEditingController(text: "0");
  TextEditingController nameController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController teamController = TextEditingController();
  TextEditingController qualController = TextEditingController();
  String autoPiecesControllerStr = "";
  String highPiecesControllerStr = "";
  String midPiecesControllerStr = "";
  String lowPiecesControllerStr = "";
  List<String> compList = ["TEST", "Sammamish", "DCMP", "Worlds"];
  List<String> autoDockList = [
    "Did not dock",
    "Docked but Unbalanced",
    "Balanced Dock"
  ];
  List<String> pieceList = [
    "Both Cones and Cubes",
    "Only Cubes",
    "Only Cones",
    "Neither"
  ];
  List<String> endgameParkList = ["Yes", "No"];
  List<String> autoTaxiList = ["Yes", "No"];
  List<String> endgameDockList = [
    "Did not dock",
    "Docked but Unbalanced",
    "Balanced Dock"
  ];
  late MyDropdownMenu compMenu = MyDropdownMenu(list: compList);
  late MyDropdownMenu pieceMenu = MyDropdownMenu(list: pieceList);
  late MyDropdownMenu autoDockMenu = MyDropdownMenu(list: autoDockList);
  late MyDropdownMenu autoTaxiMenu = MyDropdownMenu(list: autoTaxiList);
  late MyDropdownMenu endgameParkMenu = MyDropdownMenu(list: endgameParkList);
  late MyDropdownMenu endgameDockMenu = MyDropdownMenu(list: endgameDockList);

  void update(BuildContext context) async {
    if (compMenu.getCurrentValue().isEmpty ||
        pieceMenu.getCurrentValue().isEmpty ||
        autoDockMenu.getCurrentValue().isEmpty ||
        autoTaxiMenu.getCurrentValue().isEmpty ||
        endgameParkMenu.getCurrentValue().isEmpty ||
        endgameDockMenu.getCurrentValue().isEmpty) {
      errorPopUp(context, "Fill out all fields");
    } else if (autoPiecesController.text.isEmpty ||
        autoPiecesController.text.isEmpty ||
        highPiecesController.text.isEmpty ||
        midPiecesController.text.isEmpty ||
        lowPiecesController.text.isEmpty ||
        nameController.text.isEmpty ||
        // notesController.text.isEmpty ||
        teamController.text.isEmpty ||
        qualController.text.isEmpty) {
      errorPopUp(context, "Fill out all fields");
    } else if (double.tryParse(autoPiecesController.text) == null ||
        double.tryParse(highPiecesController.text) == null ||
        double.tryParse(midPiecesController.text) == null ||
        double.tryParse(lowPiecesController.text) == null) {
      errorPopUp(context, "Fill out all fields with integers");
    }

    // print("${compMenu.getCurrentValue()}\n");
    Map<String, dynamic> jsonMap = {};
    jsonMap['Name'] = nameController.text;
    jsonMap['High Pieces'] = highPiecesController.text;
    jsonMap['Mid Pieces'] = midPiecesController.text;
    jsonMap['Low Pieces'] = lowPiecesController.text;
    jsonMap['Notes'] = notesController.text;
    jsonMap['Auto Pieces'] = autoPiecesController.text;
    jsonMap['Place Cubes'] = (compMenu.getCurrentValue() == pieceList[0] ||
            compMenu.getCurrentValue() == pieceList[1])
        ? 1
        : 0;
    jsonMap['Place Cones'] = (compMenu.getCurrentValue() == pieceList[0] ||
            compMenu.getCurrentValue() == pieceList[2])
        ? 1
        : 0;

    int autoPoints = 0;
    autoPoints += autoTaxiMenu.getCurrentValue() == autoTaxiList[0] ? 3 : 0;
    autoPoints += autoDockMenu.getCurrentValue() == autoDockList[2]
        ? 12
        : (autoDockMenu.getCurrentValue() == autoDockList[1] ? 8 : 0);
    jsonMap['Auto Points'] = autoPoints;
    int endgamePoints = 0;
    endgamePoints +=
        endgameParkMenu.getCurrentValue() == endgameParkList[0] ? 2 : 0;
    endgamePoints += endgameDockMenu.getCurrentValue() == endgameDockList[2]
        ? 10
        : (endgameDockMenu.getCurrentValue() == endgameDockList[1] ? 6 : 0);
    jsonMap['Endgame Points'] = endgamePoints;
    jsonMap['Team Number'] = teamController.text;
    jsonMap['Qual Number'] = qualController.text;
    jsonMap['Competition'] = compMenu.getCurrentValue();

    String jsonString = json.encode(jsonMap);
    final Directory documents = await getApplicationDocumentsDirectory();
    print(documents.path);
    final File file = File(
        "${documents.path}/${compMenu.getCurrentValue()}-${qualController.text}-${teamController.text}.json");
    await file.writeAsString(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add New Scouting Data"),
          actions: [
            IconButton(
              onPressed: () => update(context),
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "Name of Scouter:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      controller: nameController,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "Which Comp?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  compMenu
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "Name of Team Number:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      controller: teamController,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "Qual#:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      controller: qualController,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "Auto pieces placed:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.green),
                        hintText: "Enter numbers only",
                        errorText: autoPiecesControllerStr),
                    controller: autoPiecesController,
                    onChanged: (text) {
                      setState(() {
                        if (text == "") {
                          autoPiecesControllerStr = "Please Type in a Value";
                        } else if (double.tryParse(text) == null) {
                          autoPiecesControllerStr = "Please Enter a Number";
                        } else {
                          autoPiecesControllerStr = "";
                        }
                      });
                    },
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_upward_outlined),
                        onPressed: () {
                          setState(() {
                            String cur = autoPiecesController.text;
                            int num = int.parse(cur);
                            num++;
                            autoPiecesController.text = num.toString();
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_downward_outlined),
                        onPressed: () {
                          setState(() {
                            String cur = autoPiecesController.text;
                            int num = int.parse(cur);
                            num--;
                            autoPiecesController.text = num.toString();
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "Type Of AutoBalancing:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  autoDockMenu
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "Auto Mobility?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  autoTaxiMenu
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "Type of Pieces Placed:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  pieceMenu
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "Low teleop pieces placed:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.green),
                        hintText: "Enter numbers only",
                        errorText: lowPiecesControllerStr),
                    controller: lowPiecesController,
                    onChanged: (text) {
                      setState(() {
                        if (text == "") {
                          lowPiecesControllerStr = "Please Type in a Value";
                        } else if (double.tryParse(text) == null) {
                          lowPiecesControllerStr = "Please Enter a Number";
                        } else {
                          lowPiecesControllerStr = "";
                        }
                      });
                    },
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_upward_outlined),
                        onPressed: () {
                          setState(() {
                            String cur = lowPiecesController.text;
                            int num = int.parse(cur);
                            num++;
                            lowPiecesController.text = num.toString();
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_downward_outlined),
                        onPressed: () {
                          setState(() {
                            String cur = lowPiecesController.text;
                            int num = int.parse(cur);
                            num--;
                            lowPiecesController.text = num.toString();
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "Mid teleop pieces placed:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.green),
                        hintText: "Enter numbers only",
                        errorText: midPiecesControllerStr),
                    controller: midPiecesController,
                    onChanged: (text) {
                      setState(() {
                        if (text == "") {
                          midPiecesControllerStr = "Please Type in a Value";
                        } else if (double.tryParse(text) == null) {
                          midPiecesControllerStr = "Please Enter a Number";
                        } else {
                          midPiecesControllerStr = "";
                        }
                      });
                    },
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_upward_outlined),
                        onPressed: () {
                          setState(() {
                            String cur = midPiecesController.text;
                            int num = int.parse(cur);
                            num++;
                            midPiecesController.text = num.toString();
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_downward_outlined),
                        onPressed: () {
                          setState(() {
                            String cur = midPiecesController.text;
                            int num = int.parse(cur);
                            num--;
                            midPiecesController.text = num.toString();
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "High teleop pieces placed:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.green),
                        hintText: "Enter numbers only",
                        errorText: highPiecesControllerStr),
                    controller: highPiecesController,
                    onChanged: (text) {
                      setState(() {
                        if (text == "") {
                          highPiecesControllerStr = "Please Type in a Value";
                        } else if (double.tryParse(text) == null) {
                          highPiecesControllerStr = "Please Enter a Number";
                        } else {
                          highPiecesControllerStr = "";
                        }
                      });
                    },
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_upward_outlined),
                        onPressed: () {
                          setState(() {
                            String cur = highPiecesController.text;
                            int num = int.parse(cur);
                            num++;
                            highPiecesController.text = num.toString();
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_downward_outlined),
                        onPressed: () {
                          setState(() {
                            String cur = highPiecesController.text;
                            int num = int.parse(cur);
                            num--;
                            highPiecesController.text = num.toString();
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "Endgame Park?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  endgameParkMenu
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "Type Of Endgame Balancing",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  endgameDockMenu
                ],
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    "Additional Notes:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    controller: notesController,
                  )),
              // TextButton(
              //     onPressed: () => update(context),
              //     child: const Text('Upload Data'))
            ],
          ),
        ));
  }
}

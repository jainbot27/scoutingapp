import 'package:flutter/material.dart';
import "package:scoutingapp/design/my_dropdown_menu.dart";

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
  String autoPiecesControllerStr = "";
  String highPiecesControllerStr = "";
  String midPiecesControllerStr = "";
  String lowPiecesControllerStr = "";
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
  late MyDropdownMenu pieceMenu = MyDropdownMenu(list: pieceList);
  late MyDropdownMenu autoDockMenu = MyDropdownMenu(list: autoDockList);
  late MyDropdownMenu autoTaxiMenu = MyDropdownMenu(list: autoTaxiList);
  late MyDropdownMenu endgameParkMenu = MyDropdownMenu(list: endgameParkList);
  late MyDropdownMenu endgameDockMenu = MyDropdownMenu(list: endgameDockList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add New Scouting Data"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.all(15),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                      padding: EdgeInsets.all(15),
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
                      padding: EdgeInsets.all(15),
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
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Auto Taxi?",
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
                      padding: EdgeInsets.all(15),
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
                      padding: EdgeInsets.all(15),
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
                      padding: EdgeInsets.all(15),
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
                      padding: EdgeInsets.all(15),
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
                            String cur = midPiecesController.text;
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
                            String cur = midPiecesController.text;
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
                      padding: EdgeInsets.all(15),
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
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Type Of Endgame Balancing",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  endgameDockMenu 
                ],
              ),
            ],
          ),
        ));
  }
}

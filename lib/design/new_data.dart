import 'package:flutter/material.dart';
import "package:scoutingapp/design/my_dropdown_menu.dart";

class NewData extends StatefulWidget {
  const NewData({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewDataState createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  TextEditingController conesController = TextEditingController(text: "0");
  String conesErrorStr = "";
  List<String> autoDockList = [
    "Did not dock",
    "Docked but Unbalanced",
    "Balanced Dock"
  ];
  late MyDropdownMenu autoDockMenu = MyDropdownMenu(list: autoDockList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add New Scouting Data"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Number of cones:",
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
                        errorText: conesErrorStr),
                    controller: conesController,
                    onChanged: (text) {
                      setState(() {
                        if (text == "") {
                          conesErrorStr = "Please Type in a Value";
                        } else if (double.tryParse(text) == null) {
                          conesErrorStr = "Please Enter a Number";
                        } else {
                          conesErrorStr = "";
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
                            String cur = conesController.text;
                            int num = int.parse(cur);
                            num++;
                            conesController.text = num.toString();
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_downward_outlined),
                        onPressed: () {
                          setState(() {
                            String cur = conesController.text;
                            int num = int.parse(cur);
                            num--;
                            conesController.text = num.toString();
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
              )
            ],
          ),
        ));
  }
}

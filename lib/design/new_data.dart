import 'package:flutter/material.dart';

class NewData extends StatefulWidget {
  const NewData({super.key});

  @override
  _NewDataState createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  TextEditingController conesController = TextEditingController(text: "0");
  String errorString = "";

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
                  const Expanded(
                    child: Text("Number of cones:"),
                  ),
                  Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.green),
                        hintText: "Enter numbers only",
                        errorText: errorString),
                    controller: conesController,
                    onChanged: (text) {
                      setState(() {
                        if (text == "") {
                          errorString = "Please Type in a Value";
                        } else if (double.tryParse(text) == null) {
                          errorString = "Please Enter a Number";
                        } else {
                          errorString = "";
                        }
                      });
                    },
                  )),
                  Column(
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
              )
            ],
          ),
        ));
  }
}

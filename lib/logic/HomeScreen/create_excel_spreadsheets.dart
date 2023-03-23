import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../error_pop_up.dart';

void createExcelSpreadsheets(BuildContext context) async {
  var storageRef = FirebaseStorage.instance.ref();
  var listJsons = await storageRef.listAll();
  var documents = (await getApplicationDocumentsDirectory());
  File temporary = File("${documents.path}/temp");
  // okay how do we want to do this...
  // each comp has a map with teams which has a map with quals,
  // which has a map with
  // all the info
  // COMP     TEAM      QUAL             ITEM
  Map<String, Map<String, Map<String, Map<String, dynamic>>>> map = {};
  for (Reference items in listJsons.items) {
    var fileRef = storageRef.child(items.name);
    await fileRef.writeToFile(temporary);
    String s = await temporary.readAsString();
    Map<String, dynamic> information = jsonDecode(s);
    var name = information['Name'];
    var highPieces = information['High Pieces'];
    var midPieces = information['Mid Pieces'];
    var lowPieces = information['Low Pieces'];
    var notes = information['Notes'];
    var placeCubes = information['Place Cubes'];
    var placeCones = information['Place Cones'];
    var autoPoints = information['Auto Points'];
    var endPoints = information['Endgame Points'];
    var teamNumber = information['Team Number'];
    var qualNumber = information['Qual Number'];
    var competition = information['Competition'];
    // print(competition);
    // print(teamNumber);
    // print(qualNumber);
    if (map[competition] == null) {
      map[competition] = {};
    }
    if (map[competition]![teamNumber] == null) {
      map[competition]![teamNumber] = {};
    }
    if (map[competition]![teamNumber]![qualNumber] == null) {
      map[competition]![teamNumber]![qualNumber] = {};
    }
    if (map[competition]![teamNumber]![qualNumber] == null) {
      map[competition]![teamNumber]![qualNumber] = {};
    }
    map[competition]![teamNumber]![qualNumber]!['Name'] = name;
    map[competition]![teamNumber]![qualNumber]!['High Pieces'] = highPieces;
    map[competition]![teamNumber]![qualNumber]!['Mid Pieces'] = midPieces;
    map[competition]![teamNumber]![qualNumber]!['Low Pieces'] = lowPieces;
    map[competition]![teamNumber]![qualNumber]!['Notes'] = notes;
    map[competition]![teamNumber]![qualNumber]!['Place Cubes'] = placeCubes;
    map[competition]![teamNumber]![qualNumber]!['Place Cones'] = placeCones;
    map[competition]![teamNumber]![qualNumber]!['Auto Points'] = autoPoints;
    map[competition]![teamNumber]![qualNumber]!['Endgame Points'] = endPoints;
  }
  map.forEach((key, value) async {
    final Workbook workbook = Workbook();
    int wsCount = 0;
    value.forEach((key1, value1) {
      if (wsCount == 0) {
        workbook.worksheets[0].name = key1;
      } else {
        workbook.worksheets.addWithName(key1);
      }
      final worksheet = workbook.worksheets[wsCount++];
      worksheet.getRangeByIndex(2, 1).setText("Name");
      worksheet.getRangeByIndex(3, 1).setText("High Pieces");
      worksheet.getRangeByIndex(4, 1).setText("Mid Pieces");
      worksheet.getRangeByIndex(5, 1).setText("Low Pieces");
      worksheet.getRangeByIndex(6, 1).setText("Auto Points");
      worksheet.getRangeByIndex(7, 1).setText("Endgame Points");
      worksheet.getRangeByIndex(8, 1).setText("Place Cubes");
      worksheet.getRangeByIndex(9, 1).setText("Place Cones");
      worksheet.getRangeByIndex(10, 1).setText("Notes");
      List<String> s = [];
      value1.forEach((key2, value2) {
        s.add(key2);
      });
      s.sort((a, b) {
        if (double.parse(a) < double.parse(b)) return -1;
        return 1;
      });
      for (int i = 0; i < s.length; i++) {
        value1.forEach((key2, value2) {
          if (key2 == s[i]) {
            int b = "B".codeUnitAt(0);
            worksheet
                .getRangeByName("${String.fromCharCode(b + i)}1")
                .setNumber(double.parse(key2));
            for (int j = 2; j <= 10; j++) {
              String? ff = worksheet.getRangeByIndex(j, 1).getText();
              if (value2[ff] is int) {
                worksheet
                    .getRangeByIndex(j, 2 + i)
                    .setNumber(value2[ff].toDouble());
              } else {
                worksheet.getRangeByIndex(j, 2 + i).setText(value2[ff]);
              }
              // print(value2[ff]);
              // if (double.tryParse(value2[ff]!) != null) {
              //   worksheet.getRangeByIndex(j, 2 + i).setNumber(double.parse(value2[ff]));
              // } else {
              //   worksheet.getRangeByIndex(j, 2 + i).setText(value2[ff]);
              // }
            }
          }
        });
      }
    });
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final outputFile = File("${documents.path}/output.xlsx");
    await outputFile.writeAsBytes(bytes, flush: true);
    await storageRef.child("spreadsheets").child(key).putFile(outputFile);
    outputFile.delete();
  });
  // print(map);
  errorPopUp(context, "You created spreadsheets", title: "Congrats!");
  temporary.delete();
}

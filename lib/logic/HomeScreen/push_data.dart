// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:scoutingapp/logic/error_pop_up.dart';


void pushData(BuildContext context) async {
  String documents = (await getApplicationDocumentsDirectory()).path;
  List<FileSystemEntity> files = [];
  files = Directory(documents).listSync();
  final storageRef = FirebaseStorage.instance.ref();
  for (var element in files) {
    File currentData = File(element.path);
    String filename = currentData.path.split(Platform.pathSeparator).last;
    try {
      await storageRef.child(filename).putFile(currentData);
    } on FirebaseException catch (e) {
      errorPopUp(context, e.toString());
    }
  }
  errorPopUp(context, "You pushed data!", title: "Congrats!");
  for (var element in files) {
    File currentData = File(element.path);
    currentData.delete();
  }
}

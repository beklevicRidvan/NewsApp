import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final String databaseName = "news.sqlite";
  static Future<Database> getDataBase() async {
    String veritabaniYolu = join(await getDatabasesPath(),databaseName);
    if(await databaseExists(veritabaniYolu)){
    }else{
      ByteData data = await rootBundle.load("database/$databaseName");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await File(veritabaniYolu).writeAsBytes(bytes,flush: true);
    }
    return openDatabase(veritabaniYolu);
  }


  static Future<void> saveNewsIdList(List<String> newsIdList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('newsIdList', newsIdList);
  }

  static Future<List<String>> getNewsIdList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('newsIdList') ?? [];
  }



}
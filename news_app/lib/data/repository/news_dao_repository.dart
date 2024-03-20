import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../sqflite/database_helper.dart';
import '../entity/detail_news_model.dart';
import '../entity/saved_page_model.dart';
import '../entity/source_news_model.dart';

class NewsDaoRepository {
  final _apiKey = "37e39fb6b4f04a76b008d57bb36112f1";

  Future<List<NewsSourceModel>> getNews() async {
    var dio = Dio();
    final url = "https://newsapi.org/v2/top-headlines/sources?&apiKey=$_apiKey";
    List<NewsSourceModel> sources = [];

    try {
      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;

        var results = jsonData["sources"];

        if (results is List) {
          sources = results.map((e) => NewsSourceModel.fromJson(e)).toList();
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
        print('Response data: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return sources;
  }

  Future<List<DetailNewsModel>> getNewsBySourceId(String sourceId) async {
    var dio = Dio();
    final url =
        "https://newsapi.org/v2/top-headlines?sources=$sourceId&apiKey=$_apiKey";
    List<DetailNewsModel> sources = [];

    try {
      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;

        var results = jsonData["articles"];

        if (results is List) {
          sources = results.map((e) => DetailNewsModel.fromJson(e)).toList();
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
        print('Response data: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return sources;
  }

  Future<List<DetailNewsModel>> getNewsByCountryCode(String countryCode) async {
    final url =
        "https://newsapi.org/v2/top-headlines?country=$countryCode&apiKey=$_apiKey";
    List<DetailNewsModel> sources = [];

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        var results = jsonData["articles"];

        if (results is List) {
          sources = results.map((e) => DetailNewsModel.fromJson(e)).toList();
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return sources;
  }

  Future<List<SavedPageModel>> getSavedNews() async {
    var db = await DatabaseHelper.getDataBase();

    List<Map<String, dynamic>> maps = await db.query("newstable");

    return List<SavedPageModel>.generate(maps.length, (index) {
      var row = maps[index];

      return SavedPageModel(
          id: row["id"],
          author: row["author"],
          title: row["title"],
          description: row["description"],
          urlToImage: row["urlToImage"]);
    });
  }

  Future<void> addBookmars(
      {required String author,
      required String title,
      required String description,
      required String urlToImage}) async {
    var db = await DatabaseHelper.getDataBase();

    Map<String, dynamic> maps = Map<String, dynamic>();
    maps["author"] = author;
    maps["title"] = title;
    maps["description"] = description;
    maps["urlToImage"] = urlToImage;
    await db.insert("newstable", maps);
  }
  Future<void> deleteBookmarsById({required int bookmarsId}) async{
    var db = await DatabaseHelper.getDataBase();
    await db.delete("newstable",where: "id= ?",whereArgs: [bookmarsId]);

  }

  Future<void> deleteBookmarsByTitle({required String title}) async{
    var db = await DatabaseHelper.getDataBase();
    await db.delete("newstable",where: "title= ?",whereArgs: [title]);

  }
}

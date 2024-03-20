// To parse this JSON data, do
//
//     final detailNewsModel = detailNewsModelFromJson(jsonString);

import 'dart:convert';

DetailNewsModel detailNewsModelFromJson(String str) => DetailNewsModel.fromJson(json.decode(str));

String detailNewsModelToJson(DetailNewsModel data) => json.encode(data.toJson());

class DetailNewsModel {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime? publishedAt;
  String content;

  DetailNewsModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory DetailNewsModel.fromJson(Map<String, dynamic> json) => DetailNewsModel(
    source: Source.fromJson(json["source"]),
    author: json["author"] ?? "Anonymous",
    title: json["title"] ?? "b",
    description: json["description"] ?? "Description",
    url: json["url"] ?? "d",
    urlToImage: json["urlToImage"] ?? "https://ecommercegermany.com/wp-content/uploads/2023/05/EcommerceNews-1024x576.png",
    publishedAt: DateTime.parse(json["publishedAt"])  ?? DateTime.now(),
    content: json["content"] ?? "aa",
  );

  Map<String, dynamic> toJson() => {
    "source": source.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt!.toIso8601String(),
    "content": content,
  };
}

class Source {
  String id;
  String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"] ?? "1",
    name: json["name"] ?? "Anonymous",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

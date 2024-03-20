class NewsSourceModel {
  String id;
  String name;
  String description;
  String url;
  String category;
  String language;
  String country;

  NewsSourceModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.url,
      required this.category,
      required this.language,
      required this.country});

  factory NewsSourceModel.fromJson(Map<String, dynamic> json) {
    return NewsSourceModel(
        id: json["id"],
        name: json["name"] ?? "BBC News",
        description: json["description"] ?? "Description",
        url: json["url"] ?? "https://www.bbc.com/news",
        category: json["category"] ?? "general",
        language: json["language"] ?? "tr",
        country: json["country"] ?? "tr"
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "url": url,
      "category": category,
      "language": language,
      "country": country,
    };
  }
}

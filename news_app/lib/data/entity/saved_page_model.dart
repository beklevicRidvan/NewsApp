class SavedPageModel{
    int id;
    String author;
    String title;
    String description;
    String urlToImage;


    SavedPageModel({required this.id,required this.author, required this.title,required this.description,required this.urlToImage});


    factory SavedPageModel.fromMap(Map<String,dynamic> maps){
      return SavedPageModel(
          id: maps["id"],
          author: maps["author"] ?? "Anonymous",
          title: maps["title"] ?? "Title",
          description: maps["description"] ?? "Description",
          urlToImage: maps["urlToImage"] ?? "https://ecommercegermany.com/wp-content/uploads/2023/05/EcommerceNews-1024x576.png"
      );
    }


    Map<String,dynamic> toMap(){
      return {
        "id":id,
        "author":author,
        "title":title,
        "description":description,
        "urlToImage":urlToImage,
      };
    }

}
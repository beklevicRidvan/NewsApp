import 'package:flutter/material.dart';

import '../../data/entity/saved_page_model.dart';

class SavedDetailPage extends StatelessWidget {
  final int index;
  final SavedPageModel savedNewsModel;
  const SavedDetailPage(
      {super.key, required this.savedNewsModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  savedNewsModel.title,
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 20),
                Image(
                  image: NetworkImage(savedNewsModel.urlToImage),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/placeholder.png");
                  },
                ),
                const SizedBox(height: 20),
                Text(savedNewsModel.description,
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text("Author: ${savedNewsModel.author}",
                          style: const TextStyle(fontSize: 16))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Bookmark ${savedNewsModel.id}"),
    );
  }
}

import 'package:flutter/material.dart';

import '../../data/entity/detail_news_model.dart';

class NewDetailPage extends StatelessWidget {
  final int index;
  final DetailNewsModel detailNewsModel;
  const NewDetailPage({super.key,required this.detailNewsModel,required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body:  _buildBody(),
    );
  }

 Widget  _buildBody() {
    return SingleChildScrollView(

      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

               Text(detailNewsModel.title,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                const SizedBox(height: 20),

                Hero(
                  tag: '${detailNewsModel.source.id}_$index',
                  child: Image(image: NetworkImage(detailNewsModel.urlToImage),fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/placeholder.png");
                  },),
                ),
                const SizedBox(height: 20),

                Text(detailNewsModel.description,style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(alignment: Alignment.bottomRight,child: Text("Author: ${detailNewsModel.author}",style: const TextStyle(fontSize: 16))),
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
      title: Text(detailNewsModel.source.name),
    );
 }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/source_news_model.dart';
import '../cubit/news_page_cubit.dart';
import 'detailnews_page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NewsSourceCubit>().getData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsSourceCubit,List<NewsSourceModel>>(builder: (context,news){
      return ListView.builder(itemCount: news.length, itemBuilder: (context, index) {
        var currentElement = news[index];
        return _buildListItem(currentElement,index);
      },);
    });
  }

  Widget _buildListItem(NewsSourceModel currentElement,int index) {

      return Card(
        child: ExpansionTile(
          key: PageStorageKey("${currentElement.id}_$index"),
          leading: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailNews(currentModel: currentElement,)));
          }, icon: const Icon(Icons.info_outline)),
      tilePadding: const EdgeInsets.all(15),
          collapsedBackgroundColor: Colors.grey.shade800,
          title: Text(currentElement.name,style:const TextStyle(fontSize: 18)),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Text(currentElement.description,style:const TextStyle(fontSize: 16),strutStyle: const StrutStyle(leading: 2),),
            const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Text("Country:"),
                  Text(currentElement.country.toUpperCase())

                ],
              ),
              Row(
                children: [
                  const Text("Language: "),
                  Text(currentElement.language.toUpperCase())

                ],
              ),
            ],
          ),
          ],
        ),
      );

  }
}

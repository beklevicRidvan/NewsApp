import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/entity/source_news_model.dart';

import '../../data/entity/detail_news_model.dart';
import '../cubit/detail_page_cubit.dart';
import 'new_detail_page.dart';

class DetailNews extends StatefulWidget {
  final NewsSourceModel currentModel;
  const DetailNews({super.key, required this.currentModel});

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DetailPageCubit>().getData(widget.currentModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<DetailPageCubit, List<DetailNewsModel>>(
        builder: (context, state) {
      if(state.isNotEmpty){
        return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              var currentElement = state[index];

              return _buildListItem(currentElement,index);
            });
      }
      else{
        return const Center(child: CircularProgressIndicator(color: Colors.red,),);
      }
    });
  }

  Widget _buildListItem(DetailNewsModel currentElement,int index) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> NewDetailPage(detailNewsModel: currentElement,index: index,)));
      },
      child: Card(
        margin: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Hero(
              tag: '${currentElement.source.id}_${index}',
              child: Image(image: NetworkImage(currentElement.urlToImage),fit: BoxFit.contain,errorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/placeholder.png");
              },),
            ),
            Positioned(
                bottom: 0,
      
      
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        currentElement.title.length > 20 ? '${currentElement.title.substring(0, 20)}...' : currentElement.title ?? "Null",
                        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    )
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(widget.currentModel.name),
    );
  }
}

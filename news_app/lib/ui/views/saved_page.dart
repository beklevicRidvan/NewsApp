import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/saved_page_model.dart';
import '../cubit/saved_page_cubit.dart';
import 'saved_detail_page.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SavedPageCubit>().getSavedNews();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Text(
              "BOOKMARS",
              style: TextStyle(fontSize: 35),
            ),
          ),
          _buildListView(),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return BlocBuilder<SavedPageCubit, List<SavedPageModel>>(
      builder: (context, state) {
        if (state.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                var currentElement = state[index];
                return _buildListItem(currentElement,index);
              },
            ),
          );
        } else {
          return const Align(
            alignment: Alignment.center,
            child: Text(
              textAlign: TextAlign.center,
              "You have no recorded news",
              style: TextStyle(fontSize: 20),
            ),
          );
        }
      },
    );
  }

  Widget _buildListItem(SavedPageModel currentElement,int index) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SavedDetailPage(index: index,savedNewsModel: currentElement,),));
      },
      child: Dismissible(
          key: Key(currentElement.id.toString()),
          onDismissed: (direction) {
            context
                .read<SavedPageCubit>()
                .deleteSavedNewById(bookmarsId: currentElement.id);
          },
          background: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.delete_outline),
              Text("${currentElement.id} deleted")
            ],
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(

              title: Stack(
                children: [
                  Image(
                    image: NetworkImage(currentElement.urlToImage),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/placeholder.png");
                    },
                  ),
                  Positioned(
                      bottom: 0,
                      child: Text(currentElement.title.length > 20
                          ? '${currentElement.title.substring(0, 20)}...'
                          : currentElement.title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
                ],
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(currentElement.id.toString()),
              ),
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/ui/views/new_detail_page.dart';

import '../../data/constants/constants.dart';
import '../../data/entity/detail_news_model.dart';
import '../../sqflite/database_helper.dart';
import '../cubit/saved_page_cubit.dart';
import '../cubit/searching_page_cubit.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({super.key});

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  List<String> newsIdList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context
        .read<SearchingPageCubit>()
        .getDataByCountryCode(selectedCountryCode);
    _loadNewsIdList();
  }

  String selectedCountryCode = "tr";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Country: ",
              style: TextStyle(fontSize: 17),
            ),
            _buildDropDownButton()
          ],
        ),
        Expanded(
          child: _buildListView(),
        ),
      ],
    );
  }

  _buildDropDownButton() {
    return DropdownButton<String>(
      hint: const Text('Select the Country Code'),
      value: selectedCountryCode,
      onChanged: (String? newValue) {
        // Dropdown butonda seçilen değeri güncelle
        setState(() {
          selectedCountryCode = newValue!;
          context
              .read<SearchingPageCubit>()
              .getDataByCountryCode(selectedCountryCode);
        });
      },
      items:
          Constants.countryCodes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(Constants.countryNames[value] ?? ""),
        );
      }).toList(),
    );
  }

  Widget _buildListView() {
    return BlocBuilder<SearchingPageCubit, List<DetailNewsModel>>(
        builder: (context, state) {
      if (state.isNotEmpty) {
        return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              var currentElement = state[index];

              return _buildListItem(currentElement, index);
            });
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        );
      }
    });
  }

  Widget _buildListItem(DetailNewsModel currentElement, int index) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewDetailPage(
                      detailNewsModel: currentElement,
                      index: index,
                    )));
      },
      child: Card(
        margin: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Hero(
              tag: '${currentElement.source.id}_$index',
              child: Image(
                image: NetworkImage(currentElement.urlToImage),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/placeholder.png");
                },
              ),
            ),
            Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    currentElement.title.length > 20
                        ? '${currentElement.title.substring(0, 20)}...'
                        : currentElement.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )),
            Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                    tooltip: "Save",
                    onPressed: () async{
                       setState(() {


                         if (newsIdList.contains(currentElement.title)) {
                           newsIdList.remove(currentElement.title);
                           context
                               .read<SavedPageCubit>()
                               .deleteSavedNewByTitle(title: currentElement.title);
                         } else {
                           newsIdList.add(currentElement.title);
                           context.read<SavedPageCubit>().addSavedNew(
                               author: currentElement.author,
                               title: currentElement.title,
                               description: currentElement.description,
                               urlToImage: currentElement.urlToImage);
                         }

                       });
                      await DatabaseHelper.saveNewsIdList(newsIdList);



                    },
                    icon: newsIdList.contains(currentElement.title) ?  const Icon(
                      Icons.bookmark,
                      color: Colors.red,
                      size: 35,
                    ) :  const Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                      size: 35,
                    )
                )
            ),
          ],
        ),
      ),
    );
  }


  void _loadNewsIdList() async {
    List<String> savedNewsIdList = await DatabaseHelper.getNewsIdList();
    setState(() {
      newsIdList = savedNewsIdList;
    });
  }
}

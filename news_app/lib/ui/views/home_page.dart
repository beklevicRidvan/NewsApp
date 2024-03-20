import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/ui/views/news_page.dart';
import 'package:news_app/ui/views/saved_page.dart';
import 'package:news_app/ui/views/searching_page.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../cubit/homepageindex_cubit.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final Color navigationBarColor =  ThemeData.dark().primaryColor;
  late List<Widget> pageList;
  late NewsPage newsPage;
  late SearchingPage searchingPage;
  late SavedPage savedPage;
  final PageStorageKey _newsPageStorageKey = const PageStorageKey<String>('news_page_key');
  final PageStorageKey _searchingPageStorageKey = const PageStorageKey<String>('searching_page_key');
  final PageStorageKey _savedPageStorageKey = const PageStorageKey<String>('saved_page_key');





  @override
  void initState() {
    super.initState();
    newsPage =  NewsPage(key: _newsPageStorageKey,);
    searchingPage =  SearchingPage(key: _searchingPageStorageKey,);
    savedPage =  SavedPage(key: _savedPageStorageKey,);
    pageList = [newsPage,searchingPage,savedPage];

  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(

        systemNavigationBarColor: ThemeData.dark().primaryColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: _buildNavigationBar(),
      ),
    );
  }


  Widget _buildNavigationBar(){
    return BlocBuilder<HomePageIndexCubit, int>(
      builder: (context, state) {
        return WaterDropNavBar(
          waterDropColor: Colors.red,
          iconSize: 30,
          backgroundColor: navigationBarColor,
          inactiveIconColor: Colors.white,
          onItemSelected: (int index) {
            context.read<HomePageIndexCubit>().changeIndex(index);
          },
          selectedIndex: state,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.home,
              outlinedIcon: Icons.home_outlined,
            ),
            BarItem(
                filledIcon: Icons.search,
                outlinedIcon: CupertinoIcons.search),
            BarItem(
              filledIcon: Icons.bookmark,
              outlinedIcon: Icons.bookmark_border,
            ),

          ],
        );
      },
    );
  }

 Widget _buildBody() {
    return BlocBuilder<HomePageIndexCubit,int>(builder:(context,state){
      return pageList[state];
    });
 }

 AppBar _buildAppBar() {

    return AppBar(
      toolbarHeight: 100,
      title: Image.asset("assets/logo.png",fit: BoxFit.contain),
    );
 }
}
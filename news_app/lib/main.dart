import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/ui/views/home_page.dart';

import 'ui/cubit/detail_page_cubit.dart';
import 'ui/cubit/homepageindex_cubit.dart';
import 'ui/cubit/news_page_cubit.dart';
import 'ui/cubit/saved_page_cubit.dart';
import 'ui/cubit/searching_page_cubit.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> HomePageIndexCubit()),
        BlocProvider(create: (context)=> NewsSourceCubit()),
        BlocProvider(create: (context)=> DetailPageCubit()),
        BlocProvider(create: (context)=> SearchingPageCubit()),
        BlocProvider(create: (context)=> SavedPageCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home:  HomePage(),
      ),
    );
  }
}

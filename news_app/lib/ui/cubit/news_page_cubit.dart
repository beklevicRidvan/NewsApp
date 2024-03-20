import 'dart:ui' as ui;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/source_news_model.dart';
import '../../data/repository/news_dao_repository.dart';

class NewsSourceCubit extends Cubit<List<NewsSourceModel>>{
  NewsSourceCubit():super(<NewsSourceModel>[]);

  final _repo = NewsDaoRepository();
  

  Future<void> getData() async{
    var data = await _repo.getNews();
    emit(data);
  }
}
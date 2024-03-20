import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/detail_news_model.dart';
import '../../data/repository/news_dao_repository.dart';

class SearchingPageCubit extends Cubit<List<DetailNewsModel>>{
  SearchingPageCubit():super(<DetailNewsModel>[]);


  final _repo = NewsDaoRepository();

  Future<void> getDataByCountryCode(String countryCode) async{
    var data = await _repo.getNewsByCountryCode(countryCode);
    emit(data);
  }
}
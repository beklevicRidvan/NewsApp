import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/detail_news_model.dart';
import '../../data/repository/news_dao_repository.dart';

class DetailPageCubit extends Cubit<List<DetailNewsModel>>{
  DetailPageCubit():super(<DetailNewsModel>[]);

  final _repo = NewsDaoRepository();

  Future<void> getData(String sourceId) async{
    var data = await _repo.getNewsBySourceId(sourceId)    ;
    emit(data);
  }

}
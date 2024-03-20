import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/saved_page_model.dart';
import '../../data/repository/news_dao_repository.dart';

class SavedPageCubit extends Cubit<List<SavedPageModel>> {
  SavedPageCubit() : super(<SavedPageModel>[]);

  final _repo = NewsDaoRepository();

  Future<void> getSavedNews() async {
    var data = await _repo.getSavedNews();
    emit(data);
  }

  Future<void> addSavedNew(
      {required String author,
      required String title,
      required String description,
      required String urlToImage}) async {
    await _repo.addBookmars(
        author: author,
        title: title,
        description: description,
        urlToImage: urlToImage);
  }


  Future<void> deleteSavedNewById({required int bookmarsId}) async{
    await _repo.deleteBookmarsById(bookmarsId: bookmarsId);
  }
  Future<void> deleteSavedNewByTitle({required String title}) async{
    await _repo.deleteBookmarsByTitle(title: title);
  }

}

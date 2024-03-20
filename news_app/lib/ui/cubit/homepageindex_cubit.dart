import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageIndexCubit extends Cubit<int>{
  HomePageIndexCubit():super(0);


  Future<void> changeIndex(int value)async{
    emit(value);
  }
}
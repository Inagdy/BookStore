import 'package:bookkia/feature/Home/data/model/books_model.dart';
import 'package:bookkia/feature/Home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  getBestsellerBooks() async {
    emit(GetBestSaller_loadingState());
    final responed = await HomeRepo.getBestsellerBooks();
    if (responed is BookModel) {
      emit(GetBestSaller_SuccesState(responed.data?.products));
    } else {
      emit(GetBestSaller_loadingState());
    }
  }
}

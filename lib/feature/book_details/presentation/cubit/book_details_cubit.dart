import 'package:bloc/bloc.dart';
import 'package:bookkia/feature/book_details/data/model/book_detials_model.dart';
import 'package:bookkia/feature/book_details/data/repo/book_detials_repo.dart';
import 'package:meta/meta.dart';

part 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit() : super(BookDetailsInitial());

  getDetails(int id) async {
    emit(GetbookDetailsLoading());

    final data = await BookDetialsRepo.getBookDetials(id);

    if (data is BookDetialsModel) {
      emit(GetbookDetailsSucces(data));
    } else {
      emit(GetbookDetailsError());
    }
  }
}

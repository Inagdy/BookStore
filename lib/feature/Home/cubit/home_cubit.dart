import 'package:bookkia/core/networking/api_error_handling.dart';
import 'package:bookkia/feature/Home/data/model/books_model.dart';
import 'package:bookkia/feature/Home/data/repo/home_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<Products>? bestsellerBooks;

  Future<void> getBestsellerBooks() async {
    emit(GetBestSaller_loadingState());
    try {
      final responed = await HomeRepo.getBestsellerBooks();
      if (responed is BookModel) {
        bestsellerBooks = responed.data?.products;
        emit(GetBestSaller_SuccesState(bestsellerBooks));
      } else {
        emit(GetBestSaller_ErrorState('Something went wrong, please try again'));
      }
    } on DioException catch (e) {
      final errorMessage = ApiErrorHandling.handlingDioException(e);
      emit(GetBestSaller_ErrorState(errorMessage));
    }
  }




  Future<void> searchBookNames(String text) async {
    emit(SearchLoading());
    final data = await HomeRepo.searchProducts(text);
    if (data is List<Products>) {
      emit(SearchLSuccess(data));
    } else {
      emit(SearchError());
    }
  }

  Future<void> addToCart(int productId) async {
    emit(AddToCartLoading());
    final response = await HomeRepo.addToCart(productId);
    if (response) {
      emit(AddToCartSuccess());
    } else {
      emit(AddToCartError());
    }
  }
}

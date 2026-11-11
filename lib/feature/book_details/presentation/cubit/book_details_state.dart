part of 'book_details_cubit.dart';

@immutable
sealed class BookDetailsState {}

final class BookDetailsInitial extends BookDetailsState {}

final class GetbookDetailsError extends BookDetailsState {
  final String? error;
  GetbookDetailsError({this.error});
}

final class GetbookDetailsSucces extends BookDetailsState {
  final BookDetialsModel details;
  GetbookDetailsSucces(this.details);
}

final class GetbookDetailsLoading extends BookDetailsState {}

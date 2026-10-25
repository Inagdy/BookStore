part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetBestSaller_loadingState extends HomeState {}

final class GetBestSaller_SuccesState extends HomeState {
  final List<Products>? products;

  GetBestSaller_SuccesState(this.products);
}

final class GetBestSaller_ErrorState extends HomeState {}

part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class GetProfileLoaded extends ProfileState {}
final class GetProfileError extends ProfileState {}
final class GetProfileSuccess extends ProfileState {
  final ProfileData? profile;

  GetProfileSuccess(this.profile);
}

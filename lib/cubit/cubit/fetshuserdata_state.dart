part of 'fetshuserdata_cubit.dart';

@immutable
sealed class FetshuserdataState {}

final class FetshuserdataInitial extends FetshuserdataState {}

final class FetshuserdataLoading extends FetshuserdataState {}

final class FetshuserdataLoaded extends FetshuserdataState {
  final usermodel user;
  FetshuserdataLoaded(this.user);
}

final class FetshuserdataError extends FetshuserdataState {
  final String error;
  FetshuserdataError(this.error);
}

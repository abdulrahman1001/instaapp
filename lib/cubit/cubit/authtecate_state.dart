part of 'authtecate_cubit.dart';

@immutable
abstract class AuthtecateState {}

class AuthtecateInitial extends AuthtecateState {}

class AuthtecateLoadingstate extends AuthtecateState {}

class AuthtecateSuccessstate extends AuthtecateState {}

class AuthtecateImageUploadSuccess extends AuthtecateState {
  final String imageUrl;

  AuthtecateImageUploadSuccess(this.imageUrl);
}

class AuthtecateErrorstate extends AuthtecateState {
  final String error;

  AuthtecateErrorstate(this.error);
}

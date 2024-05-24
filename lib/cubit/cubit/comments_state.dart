part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

final class CommentsLoadingstate extends CommentsState {}

final class CommentsErrorstate extends CommentsState {

  final String error;

  CommentsErrorstate(this.error);
}

final class CommentsSuccessstate extends CommentsState {}


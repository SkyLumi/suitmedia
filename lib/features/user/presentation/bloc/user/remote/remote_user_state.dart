import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:suitmedia/features/user/domain/entities/user.dart';

abstract class RemoteUserState extends Equatable {
  final List<UserEntity>? users;
  final DioException? exception;
  final bool hasReachedMax;
  final int currentPage;

  const RemoteUserState({
    this.users, 
    this.exception,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [users, exception, hasReachedMax, currentPage];
}

class RemoteUserLoading extends RemoteUserState {
  const RemoteUserLoading();
}

class RemoteUserDone extends RemoteUserState {
  const RemoteUserDone(
    List<UserEntity> users, {
    super.hasReachedMax,
    super.currentPage,
  }) : super(
    users: users,
  );
}

class RemoteUserException extends RemoteUserState {
  const RemoteUserException(DioException exception) : super(exception: exception);
}
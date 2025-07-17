import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:suitmedia/features/user/domain/entities/user.dart';

abstract class RemoteUserState extends Equatable {
  final List<UserEntity>? users;
  final DioException? exception;

  const RemoteUserState({this.users, this.exception});

  @override
  List<Object?> get props => [users, exception];
}

class RemoteUserLoading extends RemoteUserState {
  const RemoteUserLoading();
}

class RemoteUserDone extends RemoteUserState {
  const RemoteUserDone(List<UserEntity> user) : super(users: user);
}

class RemoteUserException extends RemoteUserState {
  const RemoteUserException(DioException exception) : super(exception: exception);
}
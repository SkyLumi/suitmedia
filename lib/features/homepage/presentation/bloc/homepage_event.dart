import 'package:equatable/equatable.dart';
import 'package:suitmedia/features/user/domain/entities/user.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomepage extends HomepageEvent {
  final String userName;
  const LoadHomepage(this.userName);

  @override
  List<Object?> get props => [userName];
}

class SelectUser extends HomepageEvent {
  final UserEntity user;
  const SelectUser(this.user);

  @override
  List<Object?> get props => [user];
}

class ClearSelectedUser extends HomepageEvent {
  const ClearSelectedUser();
}

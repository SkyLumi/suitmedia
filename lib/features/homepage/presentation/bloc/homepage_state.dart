import 'package:equatable/equatable.dart';
import 'package:suitmedia/features/user/domain/entities/user.dart';

abstract class HomepageState extends Equatable {
  const HomepageState();

  @override
  List<Object?> get props => [];
}

class HomepageInitial extends HomepageState {
  const HomepageInitial();
}

class HomepageLoaded extends HomepageState {
  final String userName;
  final UserEntity? selectedUser;

  const HomepageLoaded({
    required this.userName,
    this.selectedUser,
  });

  @override
  List<Object?> get props => [userName, selectedUser];

  HomepageLoaded copyWith({
    String? userName,
    UserEntity? selectedUser,
    bool clearUser = false,
  }) {
    return HomepageLoaded(
      userName: userName ?? this.userName,
      selectedUser: clearUser ? null : selectedUser ?? this.selectedUser,
    );
  }
}

import 'package:suitmedia/features/user/domain/entities/user.dart';

class UserModel extends UserEntity{
  const UserModel({
    super.id,
    super.email,
    super.firstName,
    super.lastName,
    super.avatar,
  });

  factory UserModel.fromJson(Map < String, dynamic > map) {
    return UserModel(
      id: map['id'],
      email: map['email'] ?? "",
      firstName: map['first_name'] ?? "",
      lastName: map['last_name'] ?? "",
      avatar: map['avatar'] ?? "",
    );
  }
}
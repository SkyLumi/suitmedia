import 'package:suitmedia/core/resources/data_state.dart';
import 'package:suitmedia/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<DataState<List<UserEntity>>> getUsers({int pageQuery = 1});
}
import 'package:suitmedia/core/usecases/usecase.dart';
import 'package:suitmedia/core/resources/data_state.dart';
import 'package:suitmedia/features/user/domain/entities/user.dart';
import 'package:suitmedia/features/user/domain/repository/user_repository.dart';

class GetUserUseCase implements UseCase<DataState<List<UserEntity>>,void>{

  final UserRepository _userRepository;

  GetUserUseCase(this._userRepository);
  @override
  Future<DataState<List<UserEntity>>> call({void params}){
    return _userRepository.getUsers();
  }
}
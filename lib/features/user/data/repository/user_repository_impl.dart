import 'dart:io';
import 'package:dio/dio.dart';
import 'package:suitmedia/core/constants/constants.dart';
import 'package:suitmedia/features/user/data/data_sources/remote/user_api_service.dart';
import 'package:suitmedia/features/user/data/models/user.dart';
import 'package:suitmedia/features/user/domain/repository/user_repository.dart';
import 'package:suitmedia/core/resources/data_state.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiService _userApiService;
  UserRepositoryImpl(this._userApiService);

  @override
  Future<DataState<List<UserModel>>> getUsers({int pageQuery = 1}) async {
    try {
      final httpResponse = await _userApiService.getUsers(
        page: pageQuery,
        perPage: perPageQuery,
      );
      
      if (httpResponse.response.statusCode == HttpStatus.ok){
        final responseData = httpResponse.data;
        final List<dynamic> usersJson = responseData['data'] as List<dynamic>;
        
        final List<UserModel> users = usersJson
            .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
            .toList();
            
        return DataSuccess(users);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
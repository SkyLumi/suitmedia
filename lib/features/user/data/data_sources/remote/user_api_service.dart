import 'package:suitmedia/core/constants/constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'user_api_service.g.dart';

@RestApi(baseUrl: userAPIurl)
abstract class UserApiService {
  factory UserApiService(Dio dio) = _UserApiService;

  @GET('/users')
  Future<HttpResponse<Map<String, dynamic>>> getUsers({
    @Query("page") int? page,
    @Query("per_page") int? perPage,
  });
}
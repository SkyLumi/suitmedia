import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:suitmedia/features/user/data/data_sources/remote/user_api_service.dart';
import 'package:suitmedia/features/user/domain/repository/user_repository.dart';
import 'package:suitmedia/features/user/data/repository/user_repository_impl.dart';
import 'package:suitmedia/features/user/domain/usecases/get_user.dart';
import 'package:suitmedia/features/user/presentation/bloc/user/remote/remote_user_bloc.dart';
import 'package:suitmedia/features/palindrome/presentation/bloc/palindrome_bloc.dart';
import 'package:suitmedia/features/homepage/presentation/bloc/homepage_bloc.dart';
import 'package:suitmedia/core/dio/dio_client.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  sl.registerSingleton<Dio>(createDio());

  sl.registerSingleton<UserApiService>(UserApiService(sl()));

  sl.registerSingleton<UserRepository>(
    UserRepositoryImpl(sl())
  );

  sl.registerSingleton<GetUserUseCase>(
    GetUserUseCase(sl())
  );

  sl.registerFactory<RemoteUserBloc>(
    () => RemoteUserBloc(sl())
  );

  sl.registerFactory<PalindromeBloc>(
    () => PalindromeBloc()
  );

  sl.registerFactory<HomepageBloc>(
    () => HomepageBloc()
  );
}
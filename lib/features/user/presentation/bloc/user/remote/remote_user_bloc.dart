import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia/core/resources/data_state.dart';
import 'package:suitmedia/features/user/domain/usecases/get_user.dart';
import 'package:suitmedia/features/user/presentation/bloc/user/remote/remote_user_state.dart';
import 'package:suitmedia/features/user/presentation/bloc/user/remote/remote_user_event.dart';

class RemoteUserBloc extends Bloc<RemoteUserEvent, RemoteUserState> {
  final GetUserUseCase _getUserUseCase;
  
  RemoteUserBloc(this._getUserUseCase) : super(const RemoteUserLoading()) {
    on<GetUsers>(onGetUsers);
  }

  void onGetUsers(GetUsers event, Emitter<RemoteUserState> emit) async {
    if (event.isRefresh) {
      emit(const RemoteUserLoading());
    }
    
    final dataState = await _getUserUseCase(
      params: GetUserParams(pageQuery: event.page)
    );

    if (dataState is DataSuccess && dataState.data != null) {
      final newUsers = dataState.data!;
      
      if (event.isRefresh || event.page == 1) {
        emit(RemoteUserDone(
          newUsers,
          hasReachedMax: newUsers.isEmpty || newUsers.length < 10,
          currentPage: event.page,
        ));
      } 
      else {
        final currentState = state;
        if (currentState is RemoteUserDone) {
          final isLastPage = newUsers.isEmpty || newUsers.length < 2;
          final existingIds = currentState.users!.map((u) => u.id).toSet();
          final uniqueNewUsers = newUsers.where((user) => !existingIds.contains(user.id)).toList();
          final updatedUsers = List.of(currentState.users!)..addAll(uniqueNewUsers);
          
          emit(RemoteUserDone(
            updatedUsers,
            hasReachedMax: isLastPage,
            currentPage: event.page,
          ));
        }
      }
    } 
    else if (dataState is DataFailed) {
      emit(RemoteUserException(dataState.exception!));
    }
  }
}

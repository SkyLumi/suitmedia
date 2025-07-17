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
    emit(const RemoteUserLoading());
    
    final dataState = await _getUserUseCase();
    
    if (dataState is DataSuccess && dataState.data != null) {
      emit(RemoteUserDone(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteUserException(dataState.exception!));
    }
  }
}

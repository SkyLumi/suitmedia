import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia/features/homepage/presentation/bloc/homepage_event.dart';
import 'package:suitmedia/features/homepage/presentation/bloc/homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(const HomepageInitial()) {
    on<LoadHomepage>(_onLoadHomepage);
    on<SelectUser>(_onSelectUser);
    on<ClearSelectedUser>(_onClearSelectedUser);
  }

  void _onLoadHomepage(
    LoadHomepage event,
    Emitter<HomepageState> emit,
  ) {
    emit(HomepageLoaded(userName: event.userName));
  }

  void _onSelectUser(
    SelectUser event,
    Emitter<HomepageState> emit,
  ) {
    if (state is HomepageLoaded) {
      final currentState = state as HomepageLoaded;
      emit(currentState.copyWith(selectedUser: event.user));
    }
  }

  void _onClearSelectedUser(
    ClearSelectedUser event,
    Emitter<HomepageState> emit,
  ) {
    if (state is HomepageLoaded) {
      final currentState = state as HomepageLoaded;
      emit(currentState.copyWith(clearUser: true));
    }
  }
}

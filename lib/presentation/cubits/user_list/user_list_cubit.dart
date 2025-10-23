import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_random_user.dart';
import 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  final GetRandomUser getRandomUser;
  Ticker? _ticker;
  Duration _elapsed = Duration.zero;
  static const Duration _tickInterval = Duration(seconds: 5);

  UserListCubit({required this.getRandomUser}) : super(UserListInitial());

  void startTicker() {
    if (_ticker != null && _ticker!.isActive) return;

    emit(const UserListLoaded(users: [], isTickerActive: true));

    _ticker = Ticker((elapsed) {
      if (elapsed - _elapsed >= _tickInterval) {
        _elapsed = elapsed;
        fetchRandomUser();
      }
    });

    _ticker!.start();
    fetchRandomUser();
  }

  void stopTicker() {
    _ticker?.stop();
    _ticker?.dispose();
    _ticker = null;
    _elapsed = Duration.zero;

    if (state is UserListLoaded) {
      final currentState = state as UserListLoaded;
      emit(currentState.copyWith(isTickerActive: false));
    }
  }

  Future<void> fetchRandomUser() async {
    try {
      final user = await getRandomUser(NoParams());

      if (state is UserListLoaded) {
        final currentState = state as UserListLoaded;
        final updatedUsers = [...currentState.users, user];
        emit(currentState.copyWith(users: updatedUsers));
      } else {
        emit(UserListLoaded(users: [user], isTickerActive: true));
      }
    } catch (e) {
      if (state is UserListLoaded) {
      } else {
        emit(UserListError(message: e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    stopTicker();
    return super.close();
  }
}

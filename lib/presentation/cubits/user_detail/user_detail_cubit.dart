import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/delete_user.dart';
import '../../../domain/usecases/is_user_saved.dart';
import '../../../domain/usecases/save_user.dart';
import 'user_detail_state.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  final SaveUser saveUser;
  final DeleteUser deleteUser;
  final IsUserSaved isUserSaved;

  UserDetailCubit({
    required this.saveUser,
    required this.deleteUser,
    required this.isUserSaved,
  }) : super(UserDetailInitial());

  Future<void> loadUser(UserEntity user) async {
    emit(UserDetailLoading());
    try {
      final saved = await isUserSaved(IsUserSavedParams(uuid: user.login.uuid));
      emit(UserDetailLoaded(user: user, isSaved: saved));
    } catch (e) {
      emit(UserDetailError(message: e.toString()));
    }
  }

  Future<void> toggleSaveUser() async {
    if (state is UserDetailLoaded) {
      final currentState = state as UserDetailLoaded;
      try {
        if (currentState.isSaved) {
          await deleteUser(DeleteUserParams(uuid: currentState.user.login.uuid));
          emit(currentState.copyWith(isSaved: false));
        } else {
          await saveUser(SaveUserParams(user: currentState.user));
          emit(currentState.copyWith(isSaved: true));
        }
      } catch (e) {
        emit(UserDetailError(message: e.toString()));
      }
    }
  }

  Future<void> deleteCurrentUser() async {
    if (state is UserDetailLoaded) {
      final currentState = state as UserDetailLoaded;
      try {
        await deleteUser(DeleteUserParams(uuid: currentState.user.login.uuid));
        emit(const UserDetailDeleted());
      } catch (e) {
        emit(UserDetailError(message: e.toString()));
      }
    }
  }
}


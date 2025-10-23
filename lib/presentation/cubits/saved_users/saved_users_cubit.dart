import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/delete_user.dart';
import '../../../domain/usecases/get_saved_users.dart';
import 'saved_users_state.dart';

class SavedUsersCubit extends Cubit<SavedUsersState> {
  final GetSavedUsers getSavedUsers;
  final DeleteUser deleteUser;

  SavedUsersCubit({required this.getSavedUsers, required this.deleteUser})
    : super(SavedUsersInitial());

  Future<void> loadSavedUsers() async {
    emit(SavedUsersLoading());
    try {
      final users = await getSavedUsers(NoParams());
      emit(SavedUsersLoaded(users: users));
    } catch (e) {
      emit(SavedUsersError(message: e.toString()));
    }
  }

  Future<void> deleteUserById(String uuid) async {
    try {
      await deleteUser(DeleteUserParams(uuid: uuid));
      await loadSavedUsers(); // Reload da lista
    } catch (e) {
      emit(SavedUsersError(message: e.toString()));
    }
  }
}

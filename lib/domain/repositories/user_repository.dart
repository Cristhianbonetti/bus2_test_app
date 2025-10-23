import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getRandomUser();
  Future<void> saveUser(UserEntity user);
  Future<List<UserEntity>> getAllSavedUsers();
  Future<void> deleteUser(String uuid);
  Future<bool> isUserSaved(String uuid);
}


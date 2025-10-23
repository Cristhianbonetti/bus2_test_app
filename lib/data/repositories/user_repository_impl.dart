import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserEntity> getRandomUser() async {
    try {
      final user = await remoteDataSource.getRandomUser();
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      await localDataSource.saveUser(userModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserEntity>> getAllSavedUsers() async {
    try {
      final users = await localDataSource.getAllSavedUsers();
      return users;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(String uuid) async {
    try {
      await localDataSource.deleteUser(uuid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isUserSaved(String uuid) async {
    try {
      return await localDataSource.isUserSaved(uuid);
    } catch (e) {
      rethrow;
    }
  }
}


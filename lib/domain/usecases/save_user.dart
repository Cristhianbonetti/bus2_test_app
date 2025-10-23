import '../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class SaveUser implements UseCase<void, SaveUserParams> {
  final UserRepository repository;

  SaveUser(this.repository);

  @override
  Future<void> call(SaveUserParams params) async {
    return await repository.saveUser(params.user);
  }
}

class SaveUserParams {
  final UserEntity user;

  SaveUserParams({required this.user});
}


import '../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetSavedUsers implements UseCase<List<UserEntity>, NoParams> {
  final UserRepository repository;

  GetSavedUsers(this.repository);

  @override
  Future<List<UserEntity>> call(NoParams params) async {
    return await repository.getAllSavedUsers();
  }
}


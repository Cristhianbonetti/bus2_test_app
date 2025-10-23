import '../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetRandomUser implements UseCase<UserEntity, NoParams> {
  final UserRepository repository;

  GetRandomUser(this.repository);

  @override
  Future<UserEntity> call(NoParams params) async {
    return await repository.getRandomUser();
  }
}


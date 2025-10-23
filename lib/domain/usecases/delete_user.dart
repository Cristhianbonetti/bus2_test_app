import '../../core/usecases/usecase.dart';
import '../repositories/user_repository.dart';

class DeleteUser implements UseCase<void, DeleteUserParams> {
  final UserRepository repository;

  DeleteUser(this.repository);

  @override
  Future<void> call(DeleteUserParams params) async {
    return await repository.deleteUser(params.uuid);
  }
}

class DeleteUserParams {
  final String uuid;

  DeleteUserParams({required this.uuid});
}


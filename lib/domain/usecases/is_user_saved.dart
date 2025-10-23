import '../../core/usecases/usecase.dart';
import '../repositories/user_repository.dart';

class IsUserSaved implements UseCase<bool, IsUserSavedParams> {
  final UserRepository repository;

  IsUserSaved(this.repository);

  @override
  Future<bool> call(IsUserSavedParams params) async {
    return await repository.isUserSaved(params.uuid);
  }
}

class IsUserSavedParams {
  final String uuid;

  IsUserSavedParams({required this.uuid});
}


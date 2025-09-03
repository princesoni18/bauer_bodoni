
import 'package:bodoni/core/error/either.dart';
import 'package:bodoni/core/error/error.dart';
import 'package:bodoni/features/auth/domain/auth_domain.dart';
import 'package:bodoni/features/auth/domain/repos/auth_repo.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password, String name) async {
    return await repository.register(email, password, name);
  }
}
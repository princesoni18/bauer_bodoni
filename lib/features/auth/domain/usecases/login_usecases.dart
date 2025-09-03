

import 'package:bodoni/core/error/either.dart';
import 'package:bodoni/core/error/error.dart';
import 'package:bodoni/features/auth/domain/auth_domain.dart';
import 'package:bodoni/features/auth/domain/repos/auth_repo.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
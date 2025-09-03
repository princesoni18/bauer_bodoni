import 'package:bodoni/core/error/either.dart';
import 'package:bodoni/core/error/error.dart';
import 'package:bodoni/features/auth/domain/auth_domain.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(String email, String password, String name);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getCurrentUser();
}
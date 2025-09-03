
import 'package:bodoni/core/error/either.dart';
import 'package:bodoni/core/error/error.dart';
import 'package:bodoni/core/utils/logger.dart';
import 'package:bodoni/features/auth/data/auth_data.dart';
import 'package:bodoni/features/auth/domain/auth_domain.dart';
import 'package:bodoni/features/auth/domain/repos/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      Logger.info('Repository: Attempting login for $email');
      final user = await remoteDataSource.login(email, password);
      Logger.info('Repository: Login success for $email');
      return Right(user);
    } catch (e) {
      Logger.error('Repository: Login error for $email: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register(String email, String password, String name) async {
    try {
      final user= await remoteDataSource.register(email, password, name);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return  Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
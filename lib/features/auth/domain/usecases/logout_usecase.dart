import 'package:bodoni/features/auth/domain/repos/auth_repo.dart';

class LogoutUsecase{


  AuthRepository authRepository;

  LogoutUsecase(this.authRepository);

  Future<void> call() async {
    await authRepository.logout();
  }
}
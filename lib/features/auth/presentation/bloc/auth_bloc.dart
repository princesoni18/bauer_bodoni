import 'package:bodoni/features/auth/data/models/user_model.dart';
import 'package:bodoni/features/auth/domain/auth_domain.dart';
import 'package:bodoni/features/auth/domain/usecases/login_usecases.dart';
import 'package:bodoni/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bodoni/features/auth/domain/usecases/register_usecase.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bodoni/core/utils/logger.dart';
part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUsecase logoutUseCase;

  AuthBloc(this.loginUseCase, this.registerUseCase, this.logoutUseCase) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    Logger.info('Login requested for email: ${event.email}');
    emit(AuthLoading());
    final result = await loginUseCase(event.email, event.password);
    result.fold(
      (failure) {
        Logger.error('Login failed: ${failure.message}');
        emit(AuthError(failure.message));
      },
      (user) {

        Logger.info('Login successful for email: ${event.email}');
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    Logger.info('Register requested for email: ${event.email}, name: ${event.name}');
      emit(AuthLoading());
    final result = await registerUseCase(event.email, event.password, event.name);
     result.fold(
      (failure) {
        Logger.error('Login failed: ${failure.message}');
        emit(AuthError(failure.message));
      },
      (user) {

        Logger.info('Login successful for email: ${event.email}');
        emit(AuthAuthenticated(user));
      },
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {

    await logoutUseCase();
    emit(AuthUnauthenticated());
  }
}